# OSM water layer scripts (HighRes)
Script to generate higher resolution data, using calc_2021Feb intermediate data.

### [1] Pre-processing
Complete OSM PBF -> Shapefile conversion in calc_2021Feb project.

### [2] Extract water
Extract major water body from planet.osm, procedure is same as calc_2021Feb/ project.
1. Goto **extract_water/** directory, edit **auto.sh**, and execute scriptes.
2. Goto **add_river/, add_canal/, add_stream/** directories, **auto.sh**. and execute scriptes.
3. Goto **merge_water/** directory, and execute scriptes.edit **auto.sh**,

### [3] Hires water map output
10m resolution: **merge_water/1deg_10m/**
30m resolution: **merge_water/1deg_30m/** !! upscaled map

#### Water classification in rasterlized data

[High resolution data: 1deg_10m/]
**10m resolution product**
Below values are used in rasterlized data.
0: land
1: ocean
2: large water body (poligon)
3: majopr river
4: canal
5: small stream

[High resolution data: 1deg_30m/]
**30m resolution upscaled product**
10-100: fraction of water treated as polygon
5: water tagged as river (line, without area)
2: water tagged as canal (line, without area)
1: water tagged as stream (line, without area)
