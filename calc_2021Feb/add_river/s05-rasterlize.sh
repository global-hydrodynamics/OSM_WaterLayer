#!/bin/sh

mkdir -p 5deg

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

WEST=$LON_ORI
while [ $WEST -lt $LON_END ];
do
  SOUTH=$LAT_ORI
  while [ $SOUTH -lt $LAT_END ];
  do
    echo $WEST $SOUTH
    ./t05-gdal.sh $WEST $SOUTH &

    NUM=`ps aux | grep $USER | grep t05-gdal.sh | wc -l | awk '{print $1}'`
    while [ $NUM -gt 18 ];
    do
      sleep 1
      NUM=`ps aux | grep $USER | grep t05-gdal.sh | wc -l | awk '{print $1}'`
    done

  SOUTH=`expr $SOUTH + 5`
  done
WEST=`expr $WEST + 5`
done
wait
