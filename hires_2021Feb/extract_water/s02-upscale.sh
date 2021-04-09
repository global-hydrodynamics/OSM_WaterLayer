#!/bin/sh
USER=`whoami`

mkdir -p 1deg_30m

LON_ORI=120
LON_END=155
LAT_ORI=20
LAT_END=50

WEST=$LON_ORI
while [ $WEST -lt $LON_END ];
do
  SOUTH=$LAT_ORI
  while [ $SOUTH -lt $LAT_END ];
  do
  	echo $WEST $SOUTH
    ./t02-upscale.sh $WEST $SOUTH &

      NUM=`ps aux | grep $USER | grep t02-upscale.sh | wc -l | awk '{print $1}'`
      while [ $NUM -gt 8 ];
      do
        sleep 0.1
        NUM=`ps aux | grep $USER | grep t02-upscale.sh | wc -l | awk '{print $1}'`
      done

  SOUTH=`expr $SOUTH + 1`
  done
WEST=`expr $WEST + 1`
done
