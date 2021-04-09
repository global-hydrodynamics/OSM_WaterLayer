#!/bin/sh

## OSM water layer shapefile 
ln -sf ../../calc_2021Feb/add_river/shp .

./s01-rasterlize.sh  120 155 20 50 

