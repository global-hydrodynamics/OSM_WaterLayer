#!/bin/sh

WEST=$1
EAST=$(( $WEST + 5 ))
SOUTH=$2
NORTH=$(( $SOUTH + 5 ))

####################################

CNAME=`./src/set_name $WEST $SOUTH`

./src/conv_form $WEST $SOUTH

python ./draw.py $WEST $EAST $SOUTH $NORTH $CNAME width

rm -f var_${CNAME}.bin

