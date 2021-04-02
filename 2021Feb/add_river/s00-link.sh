#!/bin/sh

ln -sf ../../OSM_sea/5deg   coast

ln -sf ../extract_water/coast
ln -sf ../extract_water/shp_coast


mkdir -p osm
cd osm
  ln -sf ../../extract_water/osm/water .
cd ..

