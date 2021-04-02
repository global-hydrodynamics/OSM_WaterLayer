# OSM water layer scripts
The scripts to generate OSM Water Layer
http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html

## [1] Prepare "sea mask" from OSM water-polygons
Work in OSM_sea/ directory.

### Download OSM water polygons
Download water-polygons-split-4326.zip from https://osmdata.openstreetmap.de/data/water-polygons.html.
Put the zip file in download/ directory, and extract the data.

### Rasterlize at 5deg tile (3sec resolution) and 1deg tile (1sec resolution for Japan)
s00-link.sh: Link MERIT DEM elevation and J-FlwDir elevation as reference to the tile with land.
s01-auto_conv.sh: script to convert water-polygons shapefile to 5deg raster tile.
s02-conv_1sec: script to convert water-polygons shapefile to 5deg raster tile (Japan use)

