#!/bin/sh

WEST=$1
SOUTH=$2
CNAME5=`./src/set_name $WEST  $SOUTH`

EAST=$(( $WEST + 5 ))
NORTH=$(( SOUTH + 5 ))

RESOL="0.0000925925925  0.0000925925925"

LAT=$SOUTH
while [ $LAT -lt $NORTH ];
do
  LON=$WEST
  while [ $LON -lt $EAST ];
  do
    CNAME1=`./src/set_name $LON  $LAT`
    WINDOW=`./src/set_window $LON $LAT`
    echo $CNAME1 $WINDOW

    WATFILE="${CNAME1}.bil"

    VARS="lines multipolygons"
    for VAR in $VARS
    do
      if [ $VAR = lines ]; then
        FILL="2"
      else
        FILL="3"
      fi
      
      SHPFILE="./shp/${CNAME5}/${VAR}.shp"
      LAYER="$VAR"
      OUTFILE="tmp_${CNAME1}.bil"
      if [ -f $SHPFILE ]; then
        echo $SHPFILE
        rm -f tmp_${CNAME1}.*
        gdal_rasterize $TOUCH -of EHdr -ot Byte -burn $FILL -tr $RESOL -te $WINDOW -l $LAYER $SHPFILE $OUTFILE
        ./src/marge_tmpfile $OUTFILE $WATFILE
      fi
    done

    ./src/wrte_ctl_10m $LON $LAT ${CNAME1}.bil ${CNAME1}.ctl
    mv -f ${CNAME1}.* 1deg_10m
    rm -f tmp_${CNAME1}.*
  
  LON=$(( $LON + 1 ))
  done
LAT=$(( $LAT + 1 ))
done

exit
