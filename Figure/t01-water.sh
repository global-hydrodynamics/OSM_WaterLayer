#!/bin/sh

mkdir -p osm2021

WEST=$1
EAST=$(( $WEST + 5 ))
SOUTH=$2
NORTH=$(( $SOUTH + 5 ))

####################################

CNAME=`./src/set_name $WEST $SOUTH`

./src/conv_water $WEST $SOUTH 

if [ -f wat_${CNAME}.bin ]; then
  python ./draw-water.py $WEST $SOUTH $CNAME osm2021 
  rm -f wat_${CNAME}.bin
fi
