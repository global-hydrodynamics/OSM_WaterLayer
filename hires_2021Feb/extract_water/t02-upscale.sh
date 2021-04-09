#!/bin/sh

LON=$1
LAT=$2
CNAME=`./src/set_name $LON  $LAT`

./src/upscale_1sec $LON $LAT
./src/wrte_ctl_30m $LON $LAT ${CNAME}.bil ${CNAME}.ctl
mv -f ${CNAME}.* 1deg_30m
  
