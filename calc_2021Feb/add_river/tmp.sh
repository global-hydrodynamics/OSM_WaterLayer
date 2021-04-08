#!/bin/sh

./s04-osm2shp.sh      -180 180 -60 90
./s05-rasterlize.sh   -180 180 -60 90
