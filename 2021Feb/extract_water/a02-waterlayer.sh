#!/bin/sh

# link data
./s00-link.sh

# Extract water-related layers
./s01-extract_water.sh                           > log_s01.txt 2> err_s01.txt  

# Devide lon & lat
./s02-divide_lons.sh                             > log_s02.txt 2> err_s02.txt  
./s03-divide_lonlat.sh                           > log_s03.txt 2> err_s03.txt  

# convert to shapefile and rasterlize
./s04-osm2shp.sh        -180 180 -60 90          > log_s04.txt 2> err_s04.txt  
./s05-rasterlize.sh     -180 180 -60 90          > log_s05.txt 2> err_s05.txt  

#cd fig
#./s01-jpg.sh            -180 180 -60 90

mv log_s*.txt ./log/
mv err_s*.txt ./log/