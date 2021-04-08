#!/bin/sh

### GDAL OSM configulation file
cp      ../../osmconf_water.ini   .

### OSM water poligon (sea mask)
ln -sf ../extract_water/coast
ln -sf ../extract_water/shp_coast

mkdir -p osm
cd osm
  ln -sf ../../extract_water/osm/water .
cd ..

