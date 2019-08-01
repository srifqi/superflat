---------------------------
--       Parameter       --
-- Modify parameter here --
---------------------------

-- Only applies to new world
-- For existing world, edit superflat.txt file in your world's folder.

-- Start of the superflat layers
sflat.Y_ORIGIN = 1
-- Composition (layer by layer)
sflat.BLOCKS = "superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"

--[[

-- EXAMPLE
	"node:name_bottom=amount,node:name_top=amount"
	"node:name_bottom=amount,node:name_top=amount;Biome,decoration" (with decoration)

-- DEFAULT SUPERFLAT
	"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"

-- SUPERFLAT: Forest
	"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1;Forest,decoration"

-- SUPERFLAT: Shallow Underground
	"superflat:bedrock=1,default:stone=230,default:dirt=5,default:dirt_with_grass=1"

-- SUPERFLAT: Deep Underground
	"superflat:bedrock=1,default:stone=920,default:dirt=10,default:dirt_with_grass=1"

-- SUPERFLAT: Very Deep Underground
	"superflat:bedrock=1,default:stone=3680,default:dirt=15,default:dirt_with_grass=1"

-- SUPERFLAT: Bottomless Pit
	"default:cobble=2,default:dirt=3,default:dirt_with_grass=1"

-- SUPERFLAT: Shallow Sea
	"superflat:bedrock=1,default:dirt=3,default:water_source=5"

-- SUPERFLAT: Sea
	"superflat:bedrock=1,default:dirt=3,default:water_source=10"

-- SUPERFLAT: Deep Sea
	"superflat:bedrock=1,default:dirt=3,default:water_source=20"

-- SUPERFLAT: Water World
	"superflat:bedrock=1,default:dirt=3,default:water_source=60"

-- SUPERFLAT: Beach
	"superflat:bedrock=1,default:sand=3,default:water_source=1"

-- DESERT SUPERFLAT
	"superflat:bedrock,default:desert_sand=3"

-- SUPERFLAT: Farmer's dream
	"superflat:bedrock=1,default:water_source=1,farming:soil_wet=1"
	
-- SUPERFLAT: You cannot escape
	"default:gravel=1,default:sand=1,default:gravel=1"

--]]
