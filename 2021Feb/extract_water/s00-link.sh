#!/bin/sh

### OSM water poligon (sea mask)
ln -shf ../../OSM_sea/5deg         coast

### GDAL OSM configulation file
cp      ../../osmconf_water.ini     .
