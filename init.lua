-- (Yet Another) Superflat Map Generator

---------------
-- Parameter --
---------------

local Y_ORIGIN = 1
local BLOCKS = {
	"superflat:bedrock", -- what i want is real bedrock :(
	"default:dirt",
	"default:dirt",
	"default:dirt_with_grass"
}


--------------------
-- Internal stuff --
--------------------

minetest.register_on_mapgen_init(function(mgparams)
		minetest.set_mapgen_params({mgname="singlenode"})
end)

-- Superflat's bedrock
minetest.register_node("superflat:bedrock", {
	description = "SUPERFLAT'S BEDROCK",
	tiles ={"default_cobble.png"},
	groups = {unbreakable = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_on_generated(function(minp, maxp, seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	if minp.y > Y_ORIGIN + #BLOCKS then
		return
	end
	for z = minp.z, maxp.z do
	for x = minp.x, maxp.x do
		local yy = 1
	for y = minp.y, maxp.y do
		local vi = area:index(x, y, z)
		if (y >= Y_ORIGIN and y < Y_ORIGIN + #BLOCKS) then
			data[vi] = minetest.get_content_id(BLOCKS[yy])
			yy = yy + 1
		else
			data[vi] = minetest.get_content_id("air")
		end
	end
	end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)

local bedrock_timer = 0
minetest.register_globalstep(function(dtime)
	bedrock_timer = bedrock_timer - dtime
	if bedrock_timer > 0 then return end
	for k,player in ipairs(minetest.get_connected_players()) do
		bedrock_timer = 1
		local pos = player:getpos()
		if pos.y < Y_ORIGIN-1 then
			-- teleport them back to surface
			player:setpos({x=pos.x,y=#BLOCKS+2,z=pos.z})
			-- build first layers under them
			if minetest.env:get_node({x=pos.x,y=Y_ORIGIN,z=pos.z}).name == "air" then
				minetest.env:set_node({x=pos.x,y=0,z=pos.z}, {name=BLOCKS[1]})
			end
		end
	end
end)
