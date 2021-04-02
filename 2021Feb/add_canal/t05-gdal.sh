#!/bin/sh

LON=$1
LAT=$2
CNAME=`./src/set_name $LON  $LAT`
WINDOW=`./src/set_window $LON $LAT`

### Ocean Mask ###

SHPFILE="./shp_coast/water_polygons.shp"
LAYER="water_polygons"
WATFILE="${CNAME}.bil"
rm -f ${CNAME}.bil

echo $WATFILE

if [ -f ./coast/${CNAME}_sea.bil ]; then
  cp ./coast/${CNAME}_sea.bil $WATFILE
else
  gdal_rasterize -of EHdr -ot Byte -burn 1 -tr 0.00083333333333 0.00083333333333 -te $WINDOW -l $LAYER $SHPFILE $WATFILE
fi

###################

VARS="lines multipolygons"
for VAR in $VARS
do
  if [ $VAR = lines ]; then
    FILL=2
  else
    FILL=3
  fi
  
  SHPFILE="./shp/${CNAME}/${VAR}.shp"
  LAYER="$VAR"
  OUTFILE="tmp_${CNAME}.bil"
  if [ -f $SHPFILE ]; then
    echo $SHPFILE
    rm -f tmp_${CNAME}.*
    gdal_rasterize -of EHdr -ot Byte -burn $FILL -tr 0.00083333333333 0.00083333333333 -te $WINDOW -l $LAYER $SHPFILE $OUTFILE
    ./src/marge_tmpfile $OUTFILE $WATFILE
  fi
done

./src/wrte_ctl_5deg $LON $LAT ${CNAME}.bil ${CNAME}.ctl
mv -f ${CNAME}.* 5deg
rm -f tmp_${CNAME}.*

