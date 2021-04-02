#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G"

mkdir -p ./osm/devide

LON_ORI=-180
LON_END=180
SOUTH=-90
NORTH=90

WEST=${LON_ORI}
while [ $WEST -lt ${LON_END} ];
do
  EAST=`expr $WEST + 30`

  OSMFILE="./osm/bank/planet-all.osm.pbf"
  CNAME=`./src/set_name $WEST 0`
  OUTFILE="./osm/devide/${CNAME}-lon30.osm.pbf"

  BOUND="left=${WEST} right=${EAST} top=${NORTH} bottom=${SOUTH}"
  BBOPT="completeWays=yes completeRelations=yes"

  echo $OUTFILE
  osmosis  --rbf $OSMFILE --bb $BOUND $BBOPT --wb $OUTFILE &

WEST=`expr $WEST + 30`
done
wait



WEST=${LON_ORI}
while [ $WEST -lt ${LON_END} ];
do
  EAST=`expr $WEST + 30`

  CNAME=`./src/set_name $WEST 0`
  OSMFILE="./osm/devide/${CNAME}-lon30.osm.pbf"

  WEST2=$WEST
  while [ $WEST2 -lt $EAST ];
  do
  	EAST2=`expr $WEST2 + 5`

    CNAME=`./src/set_name $WEST2 0`
    OUTFILE="./osm/devide/${CNAME}-lon5.osm.pbf"

    BOUND="left=${WEST2} right=${EAST2} top=${NORTH} bottom=${SOUTH}"
    BBOPT="completeWays=yes completeRelations=yes"

    echo $OUTFILE
    osmosis  --rbf $OSMFILE --bb $BOUND $BBOPT --wb $OUTFILE &
  WEST2=`expr $WEST2 + 5`
  done
  wait
WEST=`expr $WEST + 30`
done
wait
