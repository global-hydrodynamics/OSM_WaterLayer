#!/bin/sh

export GDAL_CACHEMAX=512

LON=$1
LAT=$2

CNAME=`./src/set_name $LON $LAT`

OUTFILE="${CNAME}.bin"
CTLFILE="${CNAME}.ctl"

SHPFILE="./download/water_polygons.shp"
LAYER="water_polygons"

rm -f $OUTFILE

WINDOW=`./src/set_window_1sec $LON $LAT`
gdal_rasterize -of EHdr -ot Byte -burn 1 -at -tr 0.00027777777778 0.00027777777778 -te $WINDOW -l $LAYER $SHPFILE $OUTFILE 

mv ${CNAME}.* coast_1sec/
