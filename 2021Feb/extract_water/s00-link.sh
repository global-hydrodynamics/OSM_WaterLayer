#!/bin/sh

### OSM water poligon (sea mask)
ln -sf ../../OSM_sea/5deg         coast
ln -sf ../../OSM_sea/download     shp_coast

### GDAL OSM configulation file
cp      ../../osmconf_water.ini   .

