# OSM water layer scripts
The scripts to generate OSM Water Layer
http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html

Dai Yamazaki

## Detailed procedure to create OSM water layer
Make a project directory (sample 2021Feb/ to process the OSM planet data at that time)

### [0] Download planet.pbf file
Go to extract_water/ directory.
Make osm/ directory, and download the latest **planet.pbf** from OSM servers

### [1] Pre-processing
As planet.pbf contains errornous data, pre-processing is needed.
1. Goto extract_water/directory
2. Compile codes in src/ by Makefile
3. Execute a01-preset.sh

Then, **osm/planet-mod.osm.pbf** will be outputed as pre-proccessed planet data.

### [2] Extract water
Extract major water body from planet.osm
1. Goto extrat_water/ directory.
2. edit s00-link directory if needed.
3. Execute a02-waterlayer.sh script.
- s01: First, water-related components are extracted from planet-mod.pbf.
- s02, s03: Planet.pbf is divided into small parts corresponding to 5deg tiles.
- s04: conversion from osm to shp format
- s05: rasterlize at 3sec.

### [3] Add river/canal/stream
Extract river-related water body from planet.osm (which might be missed in [2.2])
1. Goto add_river/ directory.
2. edit s00-link directory if needed.
3. Compile Fortran code in src/
4. Execute auto.sh script.
- s01: First, water-related components are extracted from planet-mod.pbf.
- s02, s03: Planet.pbf is divided into small parts corresponding to 5deg tiles.
- s04: conversion from osm to shp format
- s05: rasterlize at 3sec.

5. Follow the same proedures for canal and stream in add_canal/ and add_stream/ directory.

### [4] Merge water maps
Merge the water mask extracted in [2.2] and [2.3]
1. Goto merge_water/ directory
2. Compile Fortran codes in src/
3. execute auto.sh
- s01: merge raster file (extracted water, river, canal, stream)
- s02, s03: create GeoTiff file.

4. Visualize water map
- goto Figure directory
- compile codes in src/
- execute s04 script to make quick look figures.
  (MERIT DEM and G3WBM should be linked)

## Important output data
### OpenStreetMap PBF file:
PBF file distributed as OSM Water Layer is **extract_water/osm/water/planet-all.osm.pbf**
This is "derived data" and thus should be distributed under ODbL 1.0 license.

### Rasterized data at 3sec resolution in 5deg tile
Plain binary: **merge_water/5deg/**
GeoTiff: **merge_water/tif/**
These data are "creative works"(not derived data) according to the OpenStreetMap guideline. So we can put any license. Now this is distributed under CC-BY 4.0.

#### Water classification in rasterlized data
Below values are used in rasterlized data.
0: land
1: ocean
2: large water body (poligon)
3: majopr river
4: canal
5: small stream
