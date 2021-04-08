#!/bin/sh

./s01-merge_raster.sh  -180 180 -60 90
./s02-add_hdr.sh       -180 180 -60 90 
./s03-gdal.sh          -180 180 -60 90

