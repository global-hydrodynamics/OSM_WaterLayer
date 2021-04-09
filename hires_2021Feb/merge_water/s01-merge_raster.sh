#!/bin/sh

mkdir -p 1deg_10m

LON_ORI=120
LON_END=150
LAT_ORI=20
LAT_END=50

WEST=$LON_ORI
while [ $WEST -lt $LON_END ];
do
  SOUTH=$LAT_ORI
  while [ $SOUTH -lt $LAT_END ];
  do
    echo $WEST $SOUTH
    CNAME=`./src/set_name $WEST $SOUTH`
    if [ -f ../extract_water/1deg_10m/${CNAME}.bil ]; then
      ./src/merge_mask    $CNAME &
      ./src/wrte_ctl_10m $WEST $SOUTH ${CNAME}.bil ${CNAME}.ctl
      mv ${CNAME}.ctl 1deg_10m
    fi
  SOUTH=`expr $SOUTH + 1`
  done
  wait
WEST=`expr $WEST + 1`
done
