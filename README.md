(Yet Another) Superflat Map Generator [superflat]
=========

##Feature
- This mod will create layer-based map
- If you're falling, you will be returned to first layer

##How To Use
- Change Y_ORIGIN to adjust where first layer is (default: 1)
- Change BLOCKS to adjust the layer of map (code: from bottom to top)

##Examples for BLOCKS code
###Default superflat
Code:
```lua
{"superflat:bedrock","default:dirt","default:dirt","default:dirt_with_grass"}
```
Layers:
- Dirt with grass
- Dirt
- Dirt
- Superflat's bedrock

###Bottomless Pit (no bedrocks)
Code:
```lua
{"default:cobble","default:cobble","default:dirt","default:dirt","default:dirt","default:dirt_with_grass"}
```

Layers:
- Dirt with grass
- Dirt
- Dirt
- Dirt
- Cobblestone
- Cobblestone

###Farmer's dream
Code:
```lua
{"superflat:bedrock","default:water_source","farming:soil_wet"}
```
Layers:
- Wet Soil
- Water Source
- Superflat's bedrock
