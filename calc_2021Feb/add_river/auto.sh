#!/bin/sh

./s00-link.sh
./s01-extract_water.sh
./s02-divide_lons.sh
./s03-divide_lonlat.sh
./s04-osm2shp.sh      -180 180 -60 90
./s05-rasterlize.sh   -180 180 -60 90
