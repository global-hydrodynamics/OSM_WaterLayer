#!/bin/sh

mkdir -p dif_2021-2015

WEST=$1
EAST=$(( $WEST + 5 ))
SOUTH=$2
NORTH=$(( $SOUTH + 5 ))

####################################

CNAME=`./src/set_name $WEST $SOUTH`

./src/conv_change $WEST $SOUTH 

if [ -f dif_${CNAME}.bin ]; then
  python ./draw-change.py $WEST $SOUTH $CNAME dif_2021-2015
  rm -f dif_${CNAME}.bin
fi
