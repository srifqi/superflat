-- Modify the parameters in parameter.lua!

-- Decoration engine
sflat = sflat or {}
sflat.biome = sflat.biome or {}
sflat.biome.list = {}
function sflat.biome.register(param)
	sflat.biome.list[param.name] = {
		decoration = param.decoration or false
	}
end

sflat.decoration = sflat.decoration or {}
sflat.decoration.list = {}

local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")

function sflat.decoration.generate(minp, maxp, LAYERS, data, area, seed, pr)
	local biome = sflat.biome.list[sflat.options.biome]
	local dcr = biome.decoration
	for i = 1, #dcr do
		local dcri = sflat.decoration.list[dcr[i][1]] or sflat.decoration.list["nil"]
		if LAYERS[#LAYERS][1] == dcri.grows_on then
			for z = minp.z, maxp.z do
			for x = minp.x, maxp.x do
				local vi = area:index(x, LAYERS[#LAYERS][3], z)
				local chance = dcr[i][2] or 1024
				if pr:next(1, chance) == 1 and data[vi] == c_air then
					sflat.decoration.list[dcr[i][1]].grow(
						{x = x, y = LAYERS[#LAYERS][3], z = z},
						data, area, seed,
						minp, maxp, pr
					)
				end
			end
			end
		end
	end
end

function sflat.decoration.register(param)
	sflat.decoration.list[param.name] = {
		chance = param.chance or 1024,
		grows_on = param.grows_on or "air",
		grow = param.grow or function() return nil end
	}
end

---------------------
-- Decoration Data --
---------------------

-- Biome definition (from cold to hot)

sflat.biome.register({
	name = ""
})

-- cold
sflat.biome.register({
	name = "Ice Plains Spikes",
	decoration = {{"ice_spike", 40}}
})

-- medium/lush
sflat.biome.register({
	name = "Flower Plains",
	decoration = {{"flowers", 20}, {"grass14", 80}}
})
sflat.biome.register({
	name = "Plains",
	decoration = {{"grass14", 40}, {"grass35", 15}, {"papyrus", 40}, {"flowers", 25}}
})
sflat.biome.register({
	name = "Forest",
	decoration = {{"normal", 29}, {"grass14", 70}, {"grass35", 15}, {"papyrus", 26}, {"flowers", 28}}
})
sflat.biome.register({
	name = "Jungle",
	decoration = {{"jungle", 21}, {"jungle_grass", 10}, {"papyrus", 25}, {"flowers", 25}}
})

-- hot
sflat.biome.register({
	name = "Desert",
	decoration = {{"cactus", 60}, {"dry_shrub", 60}}
})

-- Decoration definition

-- blocks' name
local n_dirt_grass = "air"
local n_dirt_snow = "air"
local n_sand = "air"
local n_desert_sand = "air"

-- Development Test
if sflat.game_id == "devtest" then
	n_dirt_grass = "basenodes:dirt_with_grass"
	n_dirt_snow = "basenodes:dirt_with_snow"
	n_sand = "basenodes:sand"
	n_desert_sand = "basenodes:desert_sand"
-- Minetest Game
-- also for Asuna, Survivetest, and Voxelgarden
elseif sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "survivetest" or
		sflat.game_id == "voxelgarden" then
	n_dirt_grass = "default:dirt_with_grass"
	n_dirt_snow = "default:dirt_with_snow"
	n_sand = "default:sand"
	n_desert_sand = "default:desert_sand"
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	n_dirt_grass = "mcl_core:dirt_with_grass"
	n_dirt_snow = "mcl_core:dirt_with_grass_snow"
	n_sand = "mcl_core:sand"
	n_desert_sand = "mcl_core:sand"
-- Repixture
elseif sflat.game_id == "repixture" then
	n_dirt_grass = "rp_default:dirt_with_grass"
	n_sand = "rp_default:sand"
	n_desert_sand = "rp_default:sand"
end

-- blocks

local c_tree = c_air
local c_leaves = c_air
local c_apple = c_air
local c_jungletree = c_air
local c_jungleleaves = c_air

-- Development Test
if sflat.game_id == "devtest" then
	c_tree = sflat.get_content_id("basenodes:tree")
	c_leaves = sflat.get_content_id("basenodes:leaves")
	c_apple = sflat.get_content_id("basenodes:apple")
	c_jungletree = sflat.get_content_id("basenodes:jungletree")
	c_jungleleaves = sflat.get_content_id("basenodes:jungleleaves")
-- Minetest Game
-- also for Asuna, Survivetest, and Voxelgarden
elseif sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "survivetest" or
		sflat.game_id == "voxelgarden" then
	c_tree = sflat.get_content_id("default:tree")
	c_leaves = sflat.get_content_id("default:leaves")
	c_apple = sflat.get_content_id("default:apple")
	c_jungletree = sflat.get_content_id("default:jungletree")
	c_jungleleaves = sflat.get_content_id("default:jungleleaves")
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	c_tree = sflat.get_content_id("mcl_core:tree")
	c_leaves = sflat.get_content_id("mcl_core:leaves")
	c_jungletree = sflat.get_content_id("mcl_core:jungletree")
	c_jungleleaves = sflat.get_content_id("mcl_core:jungleleaves")
-- Repixture
elseif sflat.game_id == "repixture" then
	c_tree = sflat.get_content_id("rp_default:tree")
	c_leaves = sflat.get_content_id("rp_default:leaves")
	c_apple = sflat.get_content_id("rp_default:apple")
end

-- leaves
local function add_leaves(data, vi, c_leaf, other)
	local other = other or c_leaf
	if data[vi] == c_air or data[vi] == c_ignore or data[vi] == other then
		data[vi] = c_leaf
	end
end

-- normal tree
function sflat.decoration.normal_tree(pos, data, area, seed, minp, maxp, pr)
	local x, y, z = pos.x, pos.y, pos.z
	local is_apple_tree = false
	if pr:next(1, 100) < 25 then
		is_apple_tree = true
	end
	local th = pr:next(4, 5)
	
	for yy = y, y + th do
		local vi = area:index(x, yy, z)
		data[vi] = c_tree
	end
	
	local y = y + th - 1
	
	for xx = x - 1, x + 1 do
	for yy = y - 1, y + 1 do
	for zz = z - 1, z + 1 do
		if area:contains(xx, yy, zz) then
			local vi = area:index(xx, yy, zz)
			if pr:next(1, 100) > 25 then
				add_leaves(data, vi, c_leaves)
			else
				if is_apple_tree == true then
					add_leaves(data, vi, c_apple)
				else
					add_leaves(data, vi, c_leaves)
				end
			end
		end
	end
	end
	end
	
	for ii = 1, 8 do
		local xx = x + pr:next(-2, 2)
		local yy = y + pr:next(-1, 2)
		local zz = z + pr:next(-2, 2)
		for xxx = 0, 1 do
		for yyy = 0, 1 do
		for zzz = 0, 1 do
			if area:contains(xx + xxx, yy + yyy, zz + zzz) then
				local vi = area:index(xx + xxx, yy + yyy, zz + zzz)
				add_leaves(data, vi, c_leaves, c_leaves)
			end
		end
		end
		end
	end
end
sflat.decoration.register({
	name = "normal",
	chance = 15,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		sflat.decoration.normal_tree(pos, data, area, seed, minp, maxp, pr)
	end
})

-- jungle tree
function sflat.decoration.jungle_tree(pos, data, area, seed, minp, maxp, pr)
	local x, y, z = pos.x, pos.y, pos.z
	local th = pr:next(8, 12)
	
	for zz = z - 1, z + 1, maxp.z do
	for xx = x - 1, x + 1, maxp.x do
		if pr:next(1, 3) >= 2 and area:contains(xx, y, zz) then
			local vi = area:index(xx, y, zz)
			add_leaves(data, vi, c_jungletree)
		end
	end
	end
	
	for yy = y, y + th do
		local vi = area:index(x, yy, z)
		data[vi] = c_jungletree
	end
	
	local y = y + th - 1
	
	for xx = x - 1, x + 1 do
	for yy = y - 1, y + 1 do
	for zz = z - 1, z + 1 do
		if area:contains(xx, yy, zz) then
			local vi = area:index(xx, yy, zz)
			add_leaves(data, vi, c_jungleleaves)
		end
	end
	end
	end
	
	for ii = 1, 30 do
		local xx = x + pr:next(-3, 3)
		local yy = y + pr:next(-2, 2)
		local zz = z + pr:next(-3, 3)
		for xxx = 0, 1 do
		for yyy = 0, 1 do
		for zzz = 0, 1 do
			if area:contains(xx + xxx, yy + yyy, zz + zzz) then
				local vi = area:index(xx + xxx, yy + yyy, zz + zzz)
				add_leaves(data, vi, c_jungleleaves, c_jungleleaves)
			end
		end
		end
		end
	end
end
sflat.decoration.register({
	name = "jungle",
	chance = 10,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		sflat.decoration.jungle_tree(pos, data, area, seed, minp, maxp, pr)
	end
})

-- small plants

local c_cactus = c_air
local c_dry_shrub = c_air
local c_papyrus = c_air
local c_junglegrass  = c_air
local c_grass_1 = c_air
local c_grass_2 = c_air
local c_grass_3 = c_air
local c_grass_4 = c_air
local c_grass_5 = c_air

-- Development Test
if sflat.game_id == "devtest" then
	c_junglegrass  = sflat.get_content_id("basenodes:junglegrass")
-- Minetest Game
-- also for Asuna, Survivetest, and Voxelgarden
elseif sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "survivetest" or
		sflat.game_id == "voxelgarden" then
	c_cactus = sflat.get_content_id("default:cactus")
	c_dry_shrub = sflat.get_content_id("default:dry_shrub")
	c_papyrus = sflat.get_content_id("default:papyrus")
	c_junglegrass  = sflat.get_content_id("default:junglegrass")
	c_grass_1 = sflat.get_content_id("default:grass_1")
	c_grass_2 = sflat.get_content_id("default:grass_2")
	c_grass_3 = sflat.get_content_id("default:grass_3")
	c_grass_4 = sflat.get_content_id("default:grass_4")
	c_grass_5 = sflat.get_content_id("default:grass_5")
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	c_cactus = sflat.get_content_id("mcl_core:cactus")
	c_dry_shrub = sflat.get_content_id("mcl_core:deadbush")
	c_papyrus = sflat.get_content_id("mcl_core:reeds")
	c_junglegrass  = sflat.get_content_id("mcl_flowers:fern")
	c_grass_1 = sflat.get_content_id("mcl_flowers:tallgrass")
	c_grass_2 = sflat.get_content_id("mcl_flowers:fern")
	c_grass_3 = sflat.get_content_id("mcl_flowers:tallgrass")
	c_grass_4 = sflat.get_content_id("mcl_flowers:fern")
	c_grass_5 = sflat.get_content_id("mcl_flowers:tallgrass")
-- Repixture
elseif sflat.game_id == "repixture" then
	c_cactus = sflat.get_content_id("rp_default:cactus")
	c_dry_shrub = sflat.get_content_id("rp_default:dry_grass")
	c_papyrus = sflat.get_content_id("rp_default:papyrus")
	c_grass_1 = sflat.get_content_id("rp_default:grass")
	c_grass_2 = sflat.get_content_id("rp_default:grass")
	c_grass_3 = sflat.get_content_id("rp_default:fern")
	c_grass_4 = sflat.get_content_id("rp_default:tall_grass")
	c_grass_5 = sflat.get_content_id("rp_default:tall_grass")
end

local c_grasses = {c_grass_1, c_grass_2, c_grass_3, c_grass_4, c_grass_5}

-- dry shrub
sflat.decoration.register({
	name = "dry_shrub",
	chance = 50,
	grows_on = n_sand,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_dry_shrub
		end
	end
})

sflat.decoration.register({
	name = "dry_shrub_desert",
	chance = 50,
	grows_on = n_desert_sand,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_dry_shrub
		end
	end
})

-- cactus
sflat.decoration.register({
	name = "cactus",
	chance = 50,
	grows_on = n_desert_sand,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		for yy = math.max(y, minp.y), math.min(y + pr:next(1, 4), maxp.y) do
			data[area:index(x, yy, z)] = c_cactus
		end
	end
})

-- papyrus
sflat.decoration.register({
	name = "papyrus",
	chance = 10,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		for yy = math.max(y, minp.y), math.min(y + pr:next(2, 4), maxp.y) do
			data[area:index(x, yy, z)] = c_papyrus
		end
	end
})

-- jungle grass
sflat.decoration.register({
	name = "jungle_grass",
	chance = 25,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_junglegrass
		end
	end
})

-- grass 1-4
sflat.decoration.register({
	name = "grass14",
	chance = 60,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_grasses[pr:next(1, 4)]
		end
	end
})

-- grass 3-5
sflat.decoration.register({
	name = "grass35",
	chance = 5,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_grasses[pr:next(3, 5)]
		end
	end
})

-- flowers

local c_flowers = {}

-- Minetest Game
-- also for Asuna and Survivetest
if sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "survivetest" then
	c_flowers = {
		sflat.get_content_id("flowers:chrysanthemum_green"),
		sflat.get_content_id("flowers:dandelion_white"),
		sflat.get_content_id("flowers:dandelion_yellow"),
		sflat.get_content_id("flowers:geranium"),
		sflat.get_content_id("flowers:rose"),
		sflat.get_content_id("flowers:tulip"),
		sflat.get_content_id("flowers:tulip_black"),
		sflat.get_content_id("flowers:viola")
	}
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	c_flowers = {
		sflat.get_content_id("mcl_flowers:allium"),
		sflat.get_content_id("mcl_flowers:azure_bluet"),
		sflat.get_content_id("mcl_flowers:blue_orchid"),
		sflat.get_content_id("mcl_flowers:cornflower"),
		sflat.get_content_id("mcl_flowers:dandelion"),
		sflat.get_content_id("mcl_flowers:oxeye_daisy"),
		sflat.get_content_id("mcl_flowers:poppy"),
		sflat.get_content_id("mcl_flowers:tulip_orange"),
		sflat.get_content_id("mcl_flowers:tulip_pink"),
		sflat.get_content_id("mcl_flowers:tulip_red"),
		sflat.get_content_id("mcl_flowers:tulip_white")
	}
-- Voxelgarden
elseif sflat.game_id == "voxelgarden" then
	c_flowers = {
		sflat.get_content_id("flowers:dandelion_white"),
		sflat.get_content_id("flowers:dandelion_yellow"),
		sflat.get_content_id("flowers:geranium"),
		sflat.get_content_id("flowers:rose"),
		sflat.get_content_id("flowers:tulip"),
		sflat.get_content_id("flowers:viola")
	}
end

-- flowers
sflat.decoration.register({
	name = "flowers",
	chance = 3,
	grows_on = n_dirt_grass,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		if #c_flowers == 0 then
			return
		end
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_flowers[pr:next(1, #c_flowers)]
		end
	end
})

-- ice

local c_ice = c_air

-- Development Test
if sflat.game_id == "devtest" then
	c_ice = sflat.get_content_id("basenodes:ice")
-- Minetest Game
-- also for Asuna, Survivetest, and Voxelgarden
elseif sflat.game_id == "minetest_game" or
		sflat.game_id == "asuna" or
		sflat.game_id == "survivetest" or
		sflat.game_id == "voxelgarden" then
	c_ice = sflat.get_content_id("default:ice")
-- MineClone 2
-- also for Mineclonia
elseif sflat.game_id == "mineclone2" or
		sflat.game_id == "mineclonia" then
	c_ice = sflat.get_content_id("mcl_core:ice")
end

-- ice spikes
sflat.decoration.register({
	name = "ice_spike",
	chance = 25,
	grows_on = n_dirt_snow,
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			local h = pr:next(4,7)
			for u = -1, 1 do
			for i = -1, 1 do
			local vi = area:index(x + u, y - 1, z + i)
			if data[vi] ~= c_air or data[vi] ~= c_ignore then
				for o = 0, h do
					local vi = area:index(x + u, y + o, z + i)
					data[vi] = c_ice
				end
			end
			end
			end
			local j = h + pr:next(2, 3)
			for u = 0, 1 do
			for i = -1, 0 do
			local vi = area:index(x + u, y - 1, z + i)
			if data[vi] ~= c_air or data[vi] ~= c_ignore then
				for o = h, j do
					local vi = area:index(x + u, y + o, z + i)
					data[vi] = c_ice
				end
			end
			end
			end
			local vi = area:index(x, y + j, z)
			data[vi] = c_ice
		end
	end
})
