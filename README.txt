(Yet Another) Superflat Map Generator [superflat]
=========

# License
MIT License (code) and CC BY-SA 3.0 (media) (see LICENSE file)

# Feature
- Costumize world generation layer by layer
- Decoration (optional)
- If you fall, you will be returned to surface

# How to Modify
1. Open parameter.lua file.
2. Change sflat.Y_ORIGIN to adjust first layer's pos (default: 1).
3. Change sflat.BLOCKS to adjust the composition of the world (code: layers from bottom to top;biome,decoration) (examples available).

## Modify existing world
1. Open superflat.txt file in your world's folder.
2. Do like opening parameter.lua file.

## List of biomes
- Frozen River
- River
- Ice Plains
- Ice Plains Spikes
- Flower Plains
- Plains
- Forest
- Jungle
- Desert

## Presets
Preset
	Code

Example
	"node:name_bottom=amount,node:name_top=amount"
Example (+decoration)
	"node:name_bottom=amount,node:name_top=amount;Biome,decoration"
Example (one layer thick)
	"node:a,node:b=2,node:c=3"

Default
	"superflat:bedrock,default:dirt=2,default:dirt_with_grass"
Forest
	"superflat:bedrock,default:dirt=2,default:dirt_with_grass;Forest,decoration"
Shallow Underground
	"superflat:bedrock,default:stone=230,default:dirt=5,default:dirt_with_grass"
Deep Underground
	"superflat:bedrock,default:stone=920,default:dirt=10,default:dirt_with_grass"
Very Deep Underground
	"superflat:bedrock,default:stone=3680,default:dirt=15,default:dirt_with_grass"
Bottomless Pit
	"default:cobble=2,default:dirt=3,default:dirt_with_grass"
Shallow Sea
	"superflat:bedrock,default:dirt=3,default:water_source=5"
Sea
	"superflat:bedrock,default:dirt=3,default:water_source=10"
Deep Sea
	"superflat:bedrock,default:dirt=3,default:water_source=20"
Water World
	"superflat:bedrock,default:dirt=3,default:water_source=60"
Beach
	"superflat:bedrock,default:sand=3,default:water_source"
Desert Superflat
	"superflat:bedrock,default:desert_sand=3"
Farmer's Dream
	"superflat:bedrock,default:water_source,farming:soil_wet"
You Cannot Escape
	"default:gravel,default:sand,default:gravel"
