--------------------------------
--         Parameter          --
-- Modify the parameters here --
--------------------------------

-- These parameters only apply to new world.
-- For an existing world, edit superflat.txt file in its folder.

-- Start of the superflat layers
sflat.Y_ORIGIN = 1
-- Composition (layer by layer)
sflat.BLOCKS = "superflat:bedrock,default:dirt=2,default:dirt_with_grass"

--[[

-- FORMAT
	"node:name_bottom=amount,node:name_top=amount"
	"node:a=amount,node:b=amount;Biome,decoration" (with decoration)
	"node:a,node:b=2,node:c=3" (no amount means one block thick)

-- Read README for examples

--]]
