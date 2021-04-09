#!/bin/sh

mkdir -p 1deg_30m

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
    CNAME=`./src/set_name $WEST $SOUTH`
    if [ -f ./1deg_10m/${CNAME}.bil ]; then
      echo $WEST $SOUTH

      ./src/upscale_1sec $WEST $SOUTH &
      ./src/wrte_ctl_30m $WEST $SOUTH ${CNAME}.bil ${CNAME}.ctl
      mv -f ${CNAME}.ctl 1deg_30m/
 
      NUM=`ps -U yamadai | grep src/upscale_1sec | wc -l | awk '{print $1}'`
      while [ $NUM -gt 8 ];
      do
        sleep 0.1
        NUM=`ps -U yamadai | grep src/upscale_1sec | wc -l | awk '{print $1}'`
      done
    fi

  SOUTH=`expr $SOUTH + 1`
  done
WEST=`expr $WEST + 1`
done
