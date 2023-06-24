(Yet Another) Superflat Map Generator [superflat]
=========

# License
MIT License (code) and CC BY-SA 3.0 (media) (see LICENSE file)

# Features
- Customize world generation layer by layer
- Decoration (optional)
- If you fall, you will be returned to the surface

# How to Modify
1. Open `parameter.lua` file.
2. Change `sflat.Y_ORIGIN` to adjust first layer's y-level (default: 1).
3. Change `sflat.BLOCKS` to adjust the composition of the world (examples below).

Note: If the specified node does not exist, the Air node will be used.

## Modify an Existing World
1. Open `superflat.txt` file in your world's folder.
2. Do like editing `parameter.lua` file.

## List of Biomes
Below is a list of biome decorations:
- Ice Plains Spikes
- Flower Plains
- Plains
- Forest
- Jungle
- Desert

## Examples
|Code|Explanation
|----|-----------
|`"node:name_bottom=amount,node:name_top=amount"`|The list starts from bottom and goes upwards.
|`"node:a=amount,node:b=amount;Biome,decoration"`|You can add biome decorations by setting `Biome` to the list above.
|`"node:a,node:b=2,node:c=3"`|You can omit its amount to set it as one block layer.

### Development Test
Supported biome decorations: `Forest` and `Jungle` (without grasses, flowers, papyruses)

|Name|Code
|----|----
|Default|`"superflat:bedrock,basenodes:dirt=2,basenodes:dirt_with_grass"`
|Forest|`"superflat:bedrock,basenodes:dirt=2,basenodes:dirt_with_grass;Forest,decoration"`
|Shallow Underground|`"superflat:bedrock,basenodes:stone=230,basenodes:dirt=5,basenodes:dirt_with_grass"`
|Deep Underground|`"superflat:bedrock,basenodes:stone=920,basenodes:dirt=10,basenodes:dirt_with_grass"`
|Very Deep Underground|`"superflat:bedrock,basenodes:stone=3680,basenodes:dirt=15,basenodes:dirt_with_grass"`
|Bottomless Pit|`"basenodes:cobble=2,basenodes:dirt=3,basenodes:dirt_with_grass"`
|Shallow Sea|`"superflat:bedrock,basenodes:dirt=3,basenodes:water_source=5"`
|Sea|`"superflat:bedrock,basenodes:dirt=3,basenodes:water_source=10"`
|Deep Sea|`"superflat:bedrock,basenodes:dirt=3,basenodes:water_source=20"`
|Water World|`"superflat:bedrock,basenodes:dirt=3,basenodes:water_source=60"`
|Ice World|`"superflat:bedrock,basenodes:dirt=2,basenodes:dirt_with_snow;Ice Plains Spikes,decoration"`
|Beach|`"superflat:bedrock,basenodes:sand=3,basenodes:water_source"`
|Desert Superflat|`"superflat:bedrock,basenodes:desert_sand=3"`
|You Cannot Escape|`"basenodes:gravel,basenodes:sand,basenodes:gravel"`

### Minetest Game
These codes below works on these games:
- Minetest Game
- Asuna
- Dreambuilder Game
- Survivetest
- Voxelgarden

All biome decorations listed above are _not_ supported in this game:
- Dreambuilder Game

|Name|Code
|----|----
|Default|`"superflat:bedrock,default:dirt=2,default:dirt_with_grass"`
|Forest|`"superflat:bedrock,default:dirt=2,default:dirt_with_grass;Forest,decoration"`
|Flower Garden|`"superflat:bedrock,default:dirt=2,default:dirt_with_grass;Flower Plains,decoration"`
|Shallow Underground|`"superflat:bedrock,default:stone=230,default:dirt=5,default:dirt_with_grass"`
|Deep Underground|`"superflat:bedrock,default:stone=920,default:dirt=10,default:dirt_with_grass"`
|Very Deep Underground|`"superflat:bedrock,default:stone=3680,default:dirt=15,default:dirt_with_grass"`
|Bottomless Pit|`"default:cobble=2,default:dirt=3,default:dirt_with_grass"`
|Shallow Sea|`"superflat:bedrock,default:dirt=3,default:water_source=5"`
|Sea|`"superflat:bedrock,default:dirt=3,default:water_source=10"`
|Deep Sea|`"superflat:bedrock,default:dirt=3,default:water_source=20"`
|Water World|`"superflat:bedrock,default:dirt=3,default:water_source=60"`
|Ice World|`"superflat:bedrock,default:dirt=2,default:dirt_with_snow;Ice Plains Spikes,decoration"`
|Beach|`"superflat:bedrock,default:sand=3,default:water_source"`
|Desert Superflat|`"superflat:bedrock,default:desert_sand=3"`
|Farmer's Dream|`"superflat:bedrock,default:water_source,farming:soil_wet"`
|You Cannot Escape|`"default:gravel,default:sand,default:gravel"`

### Hades Revisited
Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,hades_core:dirt=2,hades_core:dirt_with_grass"`
|Shallow Underground|`"superflat:bedrock,hades_core:stone=230,hades_core:dirt=5,hades_core:dirt_with_grass"`
|Deep Underground|`"superflat:bedrock,hades_core:stone=920,hades_core:dirt=10,hades_core:dirt_with_grass"`
|Very Deep Underground|`"superflat:bedrock,hades_core:stone=3680,hades_core:dirt=15,hades_core:dirt_with_grass"`
|Bottomless Pit|`"hades_core:cobble=2,hades_core:dirt=3,hades_core:dirt_with_grass"`
|Shallow Lava Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:lava_source=5"`
|Lava Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:lava_source=10"`
|Deep Lava Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:lava_source=20"`
|Lava World|`"superflat:bedrock,hades_core:dirt=3,hades_core:lava_source=60"`
|Shallow Water Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:water_source=5"`
|Water Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:water_source=10"`
|Deep Water Sea|`"superflat:bedrock,hades_core:dirt=3,hades_core:water_source=20"`
|Water World|`"superflat:bedrock,hades_core:dirt=3,hades_core:water_source=60"`

### KSurvive 2
This game is also known as KSurvive Revived. Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,ks_terrain:mulchy_soil=2,ks_terrain:mulchy_soil_with_grass"`

### Loria
Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,loria:cinnabar,loria:mercury_oxide,loria:red_mercury_oxide"`
|Redland|`"superflat:bedrock,loria:mercury_oxide=2,loria:red_mercury_oxide"`
|Reptile House|`"superflat:bedrock,loria:chromium_fluoride=2,loria:nickel_nitrate"`
|Acidic Landscapes|`"superflat:bedrock,loria:chromia=2,loria:sodium_peroxide"`
|Azure|`"superflat:bedrock,loria:cobalt_blue=2,loria:copper_sulfate"`
|Purple Swamp|`"superflat:bedrock,loria:ammonium_manganese_pyrophosphate=3"`

### MineClone 2
These codes below works on these games:
- MineClone 2
- Mineclonia

All biome decorations listed above are supported.

|Name|Code
|----|----
|Default|`"mcl_core:bedrock,mcl_core:dirt=2,mcl_core:dirt_with_grass"`
|Forest|`"mcl_core:bedrock,mcl_core:dirt=2,mcl_core:dirt_with_grass;Forest,decoration"`
|Flower Garden|`"mcl_core:bedrock,mcl_core:dirt=2,mcl_core:dirt_with_grass;Flower Plains,decoration"`
|Shallow Underground|`"mcl_core:bedrock,mcl_core:stone=230,mcl_core:dirt=5,mcl_core:dirt_with_grass"`
|Deep Underground|`"mcl_core:bedrock,mcl_core:stone=920,mcl_core:dirt=10,mcl_core:dirt_with_grass"`
|Very Deep Underground|`"mcl_core:bedrock,mcl_core:stone=3680,mcl_core:dirt=15,mcl_core:dirt_with_grass"`
|Bottomless Pit|`"mcl_core:cobble=2,mcl_core:dirt=3,mcl_core:dirt_with_grass"`
|Shallow Sea|`"mcl_core:bedrock,mcl_core:dirt=3,mcl_core:water_source=5"`
|Sea|`"mcl_core:bedrock,mcl_core:dirt=3,mcl_core:water_source=10"`
|Deep Sea|`"mcl_core:bedrock,mcl_core:dirt=3,mcl_core:water_source=20"`
|Water World|`"mcl_core:bedrock,mcl_core:dirt=3,mcl_core:water_source=60"`
|Ice World|`"superflat:bedrock,mcl_core:dirt=2,mcl_core:dirt_with_grass_snow;Ice Plains Spikes,decoration"`
|Beach|`"mcl_core:bedrock,mcl_core:sand=3,mcl_core:water_source"`
|You Cannot Escape|`"mcl_core:gravel,mcl_core:sand,mcl_core:gravel"`

### NewPlanet
Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,default:dirt=2,default:dirt_with_grass"`
|Nuclear Wasteland|`"superflat:bedrock,newhorizons:DarkstoneCracked=2,newhorizons:Darkstone"`
|Fungi Forest|`"superflat:bedrock,newhorizons:Bluestone=2,newhorizons:BlueDirtWithGrass"`
|Colorless Forest|`"superflat:bedrock,newhorizons:Lightstone=2,newhorizons:WhiteGrass"`
|Redscape|`"superflat:bedrock,newhorizons:Redstone=2,newhorizons:RedDirt"`
|Alien Plains|`"superflat:bedrock,newplanet:AlienStone1=2,newplanet:AlienGrass"`
|Alien Swamp|`"superflat:bedrock,newplanet:PurpleStone=2,newplanet:PurpleGrass"`
|Fire Fields|`"superflat:bedrock,newplanet:FireStone=2,newplanet:FireDirt"`

### NodeCore
Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,nc_terrain:dirt=2,nc_terrain:dirt_with_grass"`
|Shallow Underground|`"superflat:bedrock,nc_terrain:stone=230,nc_terrain:dirt=5,nc_terrain:dirt_with_grass"`
|Deep Underground|`"superflat:bedrock,nc_terrain:stone=920,nc_terrain:dirt=10,nc_terrain:dirt_with_grass"`
|Very Deep Underground|`"superflat:bedrock,nc_terrain:stone=3680,nc_terrain:dirt=15,nc_terrain:dirt_with_grass"`
|Bottomless Pit|`"nc_terrain:cobble=2,nc_terrain:dirt=3,nc_terrain:dirt_with_grass"`
|Shallow Sea|`"superflat:bedrock,nc_terrain:dirt=3,nc_terrain:water_source=5"`
|Sea|`"superflat:bedrock,nc_terrain:dirt=3,nc_terrain:water_source=10"`
|Deep Sea|`"superflat:bedrock,nc_terrain:dirt=3,nc_terrain:water_source=20"`
|Water World|`"superflat:bedrock,nc_terrain:dirt=3,nc_terrain:water_source=60"`
|Beach|`"superflat:bedrock,nc_terrain:sand=3,nc_terrain:water_source"`
|You Cannot Escape|`"nc_terrain:gravel,nc_terrain:sand,nc_terrain:gravel"`

### Repixture
Supported biome decorations: `Plains`, `Forest`, and `Desert` (without flowers and papyruses)

|Name|Code
|----|----
|Default|`"superflat:bedrock,rp_default:dirt=2,rp_default:dirt_with_grass"`
|Forest|`"superflat:bedrock,rp_default:dirt=2,rp_default:dirt_with_grass;Forest,decoration"`
|Shallow Underground|`"superflat:bedrock,rp_default:stone=230,rp_default:dirt=5,rp_default:dirt_with_grass"`
|Deep Underground|`"superflat:bedrock,rp_default:stone=920,rp_default:dirt=10,rp_default:dirt_with_grass"`
|Very Deep Underground|`"superflat:bedrock,rp_default:stone=3680,rp_default:dirt=15,rp_default:dirt_with_grass"`
|Bottomless Pit|`"rp_default:cobble=2,rp_default:dirt=3,rp_default:dirt_with_grass"`
|Shallow Sea|`"superflat:bedrock,rp_default:dirt=3,rp_default:water_source=5"`
|Sea|`"superflat:bedrock,rp_default:dirt=3,rp_default:water_source=10"`
|Deep Sea|`"superflat:bedrock,rp_default:dirt=3,rp_default:water_source=20"`
|Water World|`"superflat:bedrock,rp_default:dirt=3,rp_default:water_source=60"`
|Beach|`"superflat:bedrock,rp_default:sand=3,rp_default:water_source"`
|Desert Plains|`"superflat:bedrock,rp_default:sand=3;Desert,decoration"`
|You Cannot Escape|`"rp_default:gravel,rp_default:sand,rp_default:gravel"`

### Void - An empty game
Biome decorations are not supported.

|Name|Code
|----|----
|Default|`"superflat:bedrock,void_essential:stone=3"`

## Not Supported Games
Below is a list of known not-supported games:
- Cave Game
- Exile
- Mesecraft
