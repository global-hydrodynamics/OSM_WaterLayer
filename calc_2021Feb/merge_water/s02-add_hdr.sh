#!/bin/sh

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

BASE=`pwd`

####################################

SOUTH=$LAT_ORI
while [ $SOUTH -lt $LAT_END ];
do
  WEST=$LON_ORI
  while [ $WEST -lt $LON_END ];
  do
    CNAME=`./src/set_name $WEST $SOUTH`
    if [ -f ./5deg/${CNAME}.bil ]; then
      ./src/wrte_hdr_int1  $WEST $SOUTH ${CNAME}.hdr
      mv ${CNAME}.hdr ./5deg
    
    fi
  WEST=$(( $WEST + 5 ))
  done
SOUTH=$(( $SOUTH + 5 ))  
done
wait

