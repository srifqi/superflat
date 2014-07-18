(Yet Another) Superflat Map Generator [superflat]
=========

##License
CC 1.0 Universal (see LICENSE file)

##Feature
- This mod will create layer-based map
- If you're falling, you will be returned to first layer

##How To Modify
- Open parameter.lua file
- Change ```sflat.Y_ORIGIN``` to adjust where first layer is (default: 1)
- Change ```sflat.BLOCKS``` to adjust the layer of map (code: from bottom to top) (examples available)

##BLOCKS code Built-in Preset
|Preset|Code
|------|----
|Default superflat|`"superflat:bedrock=1,default:dirt=2,default:dirt_with_grass=1"`
|Shallow Underground|`"superflat:bedrock=1,default:stone=230,default:dirt=5,default:dirt_with_grass=1"`
|Deep Underground|`"superflat:bedrock=1,default:stone=920,default:dirt=10,default:dirt_with_grass=1"`
|Very Deep Underground|`"superflat:bedrock=1,default:stone=3680,default:dirt=15,default:dirt_with_grass=1"`
|Bottomless Pit|`"default:cobble=2,default:dirt=3,default:dirt_with_grass=1"`
|Desert superflat|`"superflat:bedrock,default:desert_sand=3"`
|Farmer's dream|`"superflat:bedrock=1,default:water_source=1,farming:soil_wet=1"`
