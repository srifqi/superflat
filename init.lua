-- (Yet Another) Superflat Map Generator
-- MIT License (for code)
-- Modify the parameters in parameter.lua!

---------------
-- Main Code --
---------------

if sflat == nil then sflat = {} end
sflat.options = {
	biome = "",
	decoration = false
}

sflat.game_id = minetest.get_game_info().id

-- If the current game is not supported, throw an error.
if sflat.game_id == "cavegame" or
		sflat.game_id == "exile" or
		sflat.game_id == "mesecraft" then
	error("The current game (" .. sflat.game_id .. ") does not support the superflat mod.")
end

-- A helper function to get content ID if exists
-- Returns air if it does not exists
local c_air = minetest.get_content_id("air")
function sflat.get_content_id(name)
	local id = c_air
	if minetest.registered_nodes[name] then
		id = minetest.get_content_id(name)
	end
	return id
end

dofile(minetest.get_modpath("superflat") .. "/parsetext.lua")
dofile(minetest.get_modpath("superflat") .. "/parameter.lua")
dofile(minetest.get_modpath("superflat") .. "/decoration.lua")

-- Make sure that we use singlenode mapgen
minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_setting("mg_name", "singlenode", true)
end)

-- Superflat's bedrock
local bedrock_group = {}
local bedrock_sound = nil
-- Minetest Game
-- also for Asuna, Dreambuilder Game, New Planet, Survivetest, and Voxelgarden
if sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "dreambuilder_game" or
		sflat.game_id == "newplanet" or
		sflat.game_id == "survivetest" or
		sflat.game_id == "voxelgarden" then
	bedrock_group = {unbreakable = 1, not_in_creative_inventory = 1}
	bedrock_sound = default.node_sound_stone_defaults()
-- Hades Revisited
elseif sflat.game_id == "hades_revisited" then
	bedrock_group = {unbreakable = 1, not_in_creative_inventory = 1}
	bedrock_sound = hades_sounds.node_sound_stone_defaults()
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	bedrock_group = {creative_breakable = 1, building_block = 1, material_stone = 1}
	bedrock_sound = mcl_sounds.node_sound_stone_defaults()
-- Repixture
elseif sflat.game_id == "repixture" then
	bedrock_group = {not_in_creative_inventory = 1}
	bedrock_sound = rp_sounds.node_sound_stone_defaults()
end
minetest.register_node("superflat:bedrock", {
	description = "Superflat's Bedrock",
	tiles = {"superflat_bedrock.png"},
	groups = bedrock_group,
	sounds = bedrock_sound
})

-- Read and check whether superflat.txt file exists
-- If superflat.txt does not exist, the default setting will be used instead.
if file_exists(minetest.get_worldpath() .. DIR_DELIM .. "superflat.txt") == true then
	dofile(minetest.get_worldpath() .. DIR_DELIM .. "superflat.txt")
else
	local list = io.open(minetest.get_worldpath() .. DIR_DELIM .. "superflat.txt", "w")
	list:write(
		"sflat.Y_ORIGIN = " .. sflat.Y_ORIGIN .. "\n" ..
		"sflat.BLOCKS = \"" .. sflat.BLOCKS .. "\""
	)
	list:close()
end

-- Parse the blocks' parameter once at start
local LAYERS = sflat.parsetext(sflat.BLOCKS)
-- Wait until all nodes are loaded
minetest.after(1, function()
	-- Then parse it again
	LAYERS = sflat.parsetext(sflat.BLOCKS)
end)

-- The main code
minetest.register_on_generated(function(minp, maxp, seed)
	-- If it's above or below the layers, do nothing.
	if minp.y >= LAYERS[#LAYERS][3] or maxp.y < sflat.Y_ORIGIN then
		return
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	local pr = PseudoRandom(seed + 1)
	
	-- Generate layers
	local li = 1
	while (minp.y >= LAYERS[li][3] and li < #LAYERS) do
		li = li + 1
	end
	for y = minp.y, maxp.y do
		if y >= LAYERS[li][3] then
			li = li + 1
		end
		if li > #LAYERS then
			break
		end
		if (y >= sflat.Y_ORIGIN and y < LAYERS[#LAYERS][3]) then
			local block = LAYERS[li][2]
			for z = minp.z, maxp.z do
			for x = minp.x, maxp.x do
				local vi = area:index(x, y, z)
				data[vi] = block
			end
			end
		else
			-- air
		end
	end
	
	-- Decorate terrain if enabled
	if sflat.options.decoration == true then
		sflat.decoration.generate(minp, maxp, LAYERS, data, area, seed, pr)
	end
	
	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:update_liquids()
	vm:calc_lighting()
	vm:write_to_map(data)
end)

-- A timer for teleporting falling players to surface
sflat.bedrock_timer = 0
minetest.register_globalstep(function(dtime)
	sflat.bedrock_timer = sflat.bedrock_timer - dtime
	if sflat.bedrock_timer > 0 then return end
	sflat.bedrock_timer = 1
	for k, player in ipairs(minetest.get_connected_players()) do
		local pos = player:get_pos()
		if pos.y < sflat.Y_ORIGIN - 1 then
			-- Prepare space for falling players
			minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3] + 1, z = pos.z}, {name = "air"})
			minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3], z = pos.z}, {name = "air"})
			if minetest.registered_nodes[LAYERS[#LAYERS][1]] then
				minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3] - 1, z = pos.z}, {name = LAYERS[#LAYERS][1]})
			end
			-- Teleport them back to surface
			player:set_pos({x = pos.x, y = LAYERS[#LAYERS][3] - 0.5, z = pos.z})
		end
	end
end)
