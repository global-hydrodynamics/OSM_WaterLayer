#!/bin/sh

USER=`whoami`

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

BASE=`pwd`

mkdir -p tif

####################################

SOUTH=$LAT_ORI
while [ $SOUTH -lt $LAT_END ];
do
  WEST=$LON_ORI
  while [ $WEST -lt $LON_END ];
  do
    CNAME=`./src/set_name $WEST $SOUTH`
    if [ -f ./5deg/${CNAME}.bil ]; then

      IFILE="./5deg/${CNAME}.bil"
      OFILE="./tif/${CNAME}.tif"
      PROJ="-s_srs EPSG:4326 -t_srs EPSG:4326"
      COMP="-co compress=deflate"
      rm -f $OFILE
      gdalwarp $PROJ $COMP   $IFILE $OFILE &
  
      NUM=`ps aux | grep $USER  | grep gdalwarp  | wc -l | awk '{print $1}'`
      while [ $NUM -gt 16 ];
      do
        sleep 2
        NUM=`ps aux | grep $USER  | grep gdalwarp | wc -l | awk '{print $1}'`
      done
    
    fi
  WEST=$(( $WEST + 5 ))
  done
SOUTH=$(( $SOUTH + 5 ))  
done
wait

