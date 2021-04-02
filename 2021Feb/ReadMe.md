# OSM water layer scripts
The scripts to generate OSM Water Layer
http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html

## [2] Create OSM water layer
Make a project directory (sample 2021Feb/ to process the OSM planet data at that time)

### [2.0] Download planet.pbf file
Go to extract_water/ directory.
Make osm/ directory, and download the latest **planet.pbf** from OSM servers

### [2.1] Pre-processing
As planet.pbf contains errornous data, pre-processing is needed.
1. Goto extract_water/directory
2. Compile codes in src/ by Makefile
3. Execute a01-preset.sh

Then, **osm/planet-mod.osm.pbf** will be outputed as pre-proccessed planet data.

### [2.2] Extract water
Extract major water body from planet.osm
1. Goto extrat_water/ directory.
2. edit s00-link directory if needed.
3. Execute a02-waterlayer.sh script.
- s01: First, water-related components are extracted from planet-mod.pbf.
- s02, s03: Planet.pbf is divided into small parts corresponding to 5deg tiles.
- s04: conversion from osm to shp format
- s05: rasterlize at 3sec.

### [2.3] Add river/canal/stream
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

### [2.4] Merge water maps
Merge the water mask extracted in [2.2] and [2.3]
1. Goto merge_water/ directory
2. Compile Fortran codes in src/
3. execute auto.sh
- s01: merge raster file (extracted water, river, canal, stream)
- s02, s03: create GeoTiff file.
- s04: Visualize water map 


