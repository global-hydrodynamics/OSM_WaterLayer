#!/bin/sh

export GDAL_CACHEMAX=512

LON=$1
LAT=$2

CNAME=`./src/set_name $LON $LAT`

OUTFILE="${CNAME}_sea.bil"
CTLFILE="${CNAME}_sea.ctl"

SHPFILE="./download/water_polygons.shp"
LAYER="water_polygons"

rm -f $OUTFILE

WINDOW=`./src/set_window $LON $LAT`
gdal_rasterize -of EHdr -ot Byte -burn 1 -tr 0.00083333333333 0.00083333333333 -te $WINDOW -l $LAYER $SHPFILE $OUTFILE 

./src/wrte_ctl_5deg $LON $LAT $OUTFILE $CTLFILE

mv ${CNAME}_sea.* 5deg
