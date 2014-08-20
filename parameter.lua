------------------------
--      Parameter     --
-- Modify layers here --
------------------------

sflat.Y_ORIGIN = 1
sflat.BLOCKS = "superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"

--[[

-- EXAMPLE
	"node:name_bottom=amount,node:name_top=amount"

-- DEFAULT SUPERFLAT
	"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"

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

--]]