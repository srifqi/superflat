(Yet Another) Superflat Map Generator [superflat]
=========

# License
CC 1.0 Universal (see LICENSE file)

# Feature
- This mod will create customizable world's layers' world
- Decoration (optional)
- If you're falling, you will be returned to surface

# How To Modify
1. Open parameter.lua file.
2. Change `sflat.Y_ORIGIN` to adjust where first layer is (default: 1).
3. Change `sflat.BLOCKS` to adjust the layer of map (code: from bottom to top;biome,decoration) (examples available).

## Modify existed world
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

# `sflat.BLOCKS` code's Built-in Preset
|Preset|Code
|------|----
|Example|`"node:name_bottom=amount,node:name_top=amount"`
|Example (+decoration)|`"node:name_bottom=amount,node:name_top=amount;Biome,decoration"`
|Forest|`"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1;Forest,decoration"`
|Default superflat|`"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"`
|Shallow Underground|`"superflat:bedrock=1,default:stone=230,default:dirt=5,default:dirt_with_grass=1"`
|Deep Underground|`"superflat:bedrock=1,default:stone=920,default:dirt=10,default:dirt_with_grass=1"`
|Very Deep Underground|`"superflat:bedrock=1,default:stone=3680,default:dirt=15,default:dirt_with_grass=1"`
|Bottomless Pit|`"default:cobble=2,default:dirt=3,default:dirt_with_grass=1"`
|Shallow Sea|`"superflat:bedrock=1,default:dirt=3,default:water_source=5"`
|Sea|`"superflat:bedrock=1,default:dirt=3,default:water_source=10"`
|Deep Sea|`"superflat:bedrock=1,default:dirt=3,default:water_source=20"`
|Water World|`"superflat:bedrock=1,default:dirt=3,default:water_source=60"`
|Beach|`"superflat:bedrock=1,default:sand=3,default:water_source=1"`
|Desert superflat|`"superflat:bedrock=1,default:desert_sand=3"`
|Farmer's dream|`"superflat:bedrock=1,default:water_source=1,farming:soil_wet=1"`
|You cannot escape|`"default:gravel=1,default:sand=1,default:gravel=1"`
