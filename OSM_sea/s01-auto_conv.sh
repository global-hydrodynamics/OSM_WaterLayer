#!/bin/sh

WEST=$1
EAST=$2
SOUTH=$3
NORTH=$4

mkdir -p 5deg

LAT=$SOUTH
while [ $LAT -lt $NORTH ];
do
  LON=$WEST
  while [ $LON -lt $EAST ];
  do
    CNAME=`./src/set_name $LON $LAT`
    if [ -e ./DEM/${CNAME}.bin ]; then
      ./t01-auto_gdal.sh $LON $LAT   &
    fi

    NUM=`ps | grep t01-auto_gdal.sh | wc -l | awk '{print $1}'`
    while [ $NUM -ge 10 ];
    do
      sleep 5
      NUM=`ps | grep t01-auto_gdal.sh | wc -l | awk '{print $1}'`
    done

  LON=$(( $LON + 5 ))
  done
LAT=$(( $LAT + 5 ))
done

wait