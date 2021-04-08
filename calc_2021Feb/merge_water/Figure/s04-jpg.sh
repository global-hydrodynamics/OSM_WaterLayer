#!/bin/sh
USER=`whoami`

#link base topography data
ln -sf ~yamadai/work/data/DEM/MERIT_DEM/v11     MERIT_DEM
ln -sf ~yamadai/work/data/WaterMask/G3WBM/5deg  G3WBM

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

####################################

mkdir -p fig

SOUTH=${LAT_ORI}
NORTH=`expr $SOUTH + 5`
while [ $SOUTH -lt ${LAT_END} ];
do
  WEST=${LON_ORI}
  EAST=`expr $WEST + 5`
  while [ $WEST -lt ${LON_END} ];
  do
    CNAME=`./src/set_name $WEST $SOUTH`
    if [ -f ./MERIT_DEM/${CNAME}.bin ]; then
      ./t04-draw.sh $WEST $SOUTH &

      NUM=`ps aux | grep $USER | grep ./t04-draw.sh | wc -l | awk '{print $1}'`
      while [ $NUM -gt 8 ];
      do
        sleep 1
        NUM=`ps aux | grep $USER | grep ./t04-draw.sh | wc -l | awk '{print $1}'`
      done

    fi
  WEST=`expr $WEST + 5`
  EAST=`expr $WEST + 5`
  done
SOUTH=`expr $SOUTH + 5`
NORTH=`expr $SOUTH + 5`
done
wait

