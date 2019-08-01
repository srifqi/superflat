-- (Yet Another) Superflat Map Generator
-- Modify parameter in parameter.lua!

--------------------
-- Internal stuff --
--------------------

if sflat == nil then sflat = {} end
sflat.options = {
	biome = "",
	decoration = false
}

dofile(minetest.get_modpath("superflat") .. "/parsetext.lua")
dofile(minetest.get_modpath("superflat") .. "/parameter.lua")
dofile(minetest.get_modpath("superflat") .. "/decoration.lua")

minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_setting("mg_name", "singlenode", true)
end)

-- Superflat's bedrock
minetest.register_node("superflat:bedrock", {
	description = "Superflat's Bedrock",
	tiles = {"superflat_bedrock.png"},
	groups = {unbreakable = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults()
})

-- Read and check if superflat.txt file exists
-- If there is no text at superflat.txt, it will use default setting.
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

local LAYERS = nil
-- Wait until all nodes are loaded
minetest.after(1, function()
	if LAYERS == nil then
		LAYERS = sflat.parsetext(sflat.BLOCKS)
	end
end)

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y >= LAYERS[#LAYERS][3] then
		return
	end
	local t1 = os.clock()
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	local pr = PseudoRandom(seed + 1)
	
	-- Generate layers
	local li = 1
	for y = minp.y, maxp.y do
		if li > #LAYERS then
			break
		end
		if y >= LAYERS[li][3] then
			li = li + 1
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

sflat.bedrock_timer = 0
minetest.register_globalstep(function(dtime)
	sflat.bedrock_timer = sflat.bedrock_timer - dtime
	if sflat.bedrock_timer > 0 then return end
	sflat.bedrock_timer = 1
	for k,player in ipairs(minetest.get_connected_players()) do
		local pos = player:get_pos()
		if pos.y < sflat.Y_ORIGIN - 1 then
			-- Prepare space for falling players
			minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3] + 1, z = pos.z}, {name = "air"})
			minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3], z = pos.z}, {name = "air"})
			minetest.set_node({x = pos.x, y = LAYERS[#LAYERS][3] - 1, z = pos.z}, {name = LAYERS[#LAYERS][1]})
			-- Teleport them back to surface
			player:set_pos({x = pos.x, y = LAYERS[#LAYERS][3] - 0.5, z = pos.z})
		end
	end
end)
