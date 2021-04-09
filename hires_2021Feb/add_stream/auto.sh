#!/bin/sh

## OSM water layer shapefile 
ln -shf ../../calc_2021Feb/add_stream/shp .

./s05-rasterlize.sh 120 155 20 50 
