#!/bin/sh

WEST=$1
EAST=$2
SOUTH=$3
NORTH=$4

mkdir -p coast_1sec

LAT=$SOUTH
while [ $LAT -lt $NORTH ];
do
  LON=$WEST
  while [ $LON -lt $EAST ];
  do
    CNAME=`./src/set_name $LON $LAT`
    if [ -e ./DEM_jpn/${CNAME}.bin ]; then
      ./t02-1sec_gdal.sh $LON $LAT   &
    fi

    NUM=`ps | grep t02-1sec_gdal.sh | wc -l | awk '{print $1}'`
    while [ $NUM -ge 10 ];
    do
      sleep 5
      NUM=`ps | grep t02-1sec_gdal.sh | wc -l | awk '{print $1}'`
    done

  LON=$(( $LON + 1 ))
  done
LAT=$(( $LAT + 1 ))
done

wait