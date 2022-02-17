#!/bin/sh

USER=`whoami`

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

mkdir -p water

####################################

SOUTH=${LAT_ORI}
NORTH=`expr $SOUTH + 5`
while [ $SOUTH -lt ${LAT_END} ];
do
  WEST=${LON_ORI}
  EAST=`expr $WEST + 5`
  while [ $WEST -lt ${LON_END} ];
  do
    CNAME=`./src/set_name $WEST $SOUTH`

    if [ -f ./2021Feb/${CNAME}.bil ]; then

      ./t02-change.sh $WEST $SOUTH  &

      NUM=`ps aux | grep $USER | grep t02-change.sh | wc -l | awk '{print $1}'`
      while [ $NUM -gt 16 ];
      do
        sleep 1
        NUM=`ps aux | grep $USER | grep t02-change.sh | wc -l | awk '{print $1}'`
      done
    fi
  
  WEST=`expr $WEST + 5`
  EAST=`expr $WEST + 5`
  done
SOUTH=`expr $SOUTH + 5`
NORTH=`expr $SOUTH + 5`
done
wait

