-- (Yet Another) Superflat Map Generator
-- Modify parameter in parameter.lua !

--------------------
-- Internal stuff --
--------------------

sflat = sflat or {}
sflat.options = {
	biome = "",
	decoration = false
}

dofile(minetest.get_modpath("superflat").."/parsetext.lua")
dofile(minetest.get_modpath("superflat").."/parameter.lua")
dofile(minetest.get_modpath("superflat").."/decoration.lua")

minetest.register_on_mapgen_init(function(mgparams)
		minetest.set_mapgen_params({mgname="singlenode"})
end)

-- Superflat's bedrock
minetest.register_node("superflat:bedrock", {
	description = "SUPERFLAT'S BEDROCK",
	tiles ={"superflat_bedrock.png"},
	groups = {unbreakable = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults()
})

local pBLOCKS = sflat.parsetext(sflat.BLOCKS)
local blockcache = {minetest.get_content_id("air")}
for i=1,#pBLOCKS do
	blockcache[i+1] = minetest.get_content_id(pBLOCKS[i])
end

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > sflat.Y_ORIGIN + #pBLOCKS then
		return
	end
	local t1=os.clock()
	print("[superflat]:"..minp.x..","..minp.y..","..minp.z)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local pr = PseudoRandom(seed+1)
	
	--generate layers
	for z = minp.z, maxp.z do
	for x = minp.x, maxp.x do
	for y = minp.y, maxp.y do
		local vi = area:index(x, y, z)
		if (y >= sflat.Y_ORIGIN and y < sflat.Y_ORIGIN + #pBLOCKS) then
			data[vi] = blockcache[y - sflat.Y_ORIGIN + 2]
		else
			data[vi] = blockcache[1] -- air
		end
	end
	end
	end
	
	-- if decoration enabled
	if sflat.options.decoration == true then
		--decorate terrain
		sflat.decoration.generate(minp, maxp, pBLOCKS, data, area, seed, pr)
	end
	
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:update_liquids()
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1)*10000)/10
	print("[superflat]:Done in "..chugent.."ms.")
end)

sflat.bedrock_timer = 0
minetest.register_globalstep(function(dtime)
	sflat.bedrock_timer = sflat.bedrock_timer - dtime
	if sflat.bedrock_timer > 0 then return end
	for k,player in ipairs(minetest.get_connected_players()) do
		sflat.bedrock_timer = 1
		local pos = player:getpos()
		if pos.y < sflat.Y_ORIGIN-1 then
			-- teleport them back to surface
			player:setpos({x=pos.x,y=#pBLOCKS+2,z=pos.z})
			-- build first layers under them
			if minetest.env:get_node({x=pos.x,y=sflat.Y_ORIGIN,z=pos.z}).name == "air" then
				minetest.env:set_node({x=pos.x,y=0,z=pos.z}, {name=pBLOCKS[1]})
			end
		end
	end
end)
