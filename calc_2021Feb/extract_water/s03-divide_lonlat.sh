#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

mkdir -p ./osm/lonlat

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

WEST=${LON_ORI}
while [ $WEST -lt ${LON_END} ];
do
  EAST=`expr $WEST + 5`

  SOUTH=${LAT_ORI}
  while [ $SOUTH -lt $LAT_END ];
  do
  	NORTH=`expr $SOUTH + 30`

    CNAMEIN=`./src/set_name $WEST 0`
    OSMFILE="./osm/devide/${CNAMEIN}-lon5.osm.pbf"

    CNAME=`./src/set_name $WEST $SOUTH`
    OUTFILE="./osm/devide/${CNAME}-lon5-lat30.osm.pbf"

#    BOUND="left=${WEST} right=${EAST} top=${NORTH} bottom=${SOUTH}"
    BOUND=`./src/set_bounds $WEST $EAST $SOUTH $NORTH`
    BBOPT="completeWays=yes completeRelations=yes"

    echo $OUTFILE
    osmosis --rbf $OSMFILE --bb $BOUND $BBOPT --wb $OUTFILE &

  SOUTH=`expr $SOUTH + 30`
  done
  wait
WEST=`expr $WEST + 5`
done


WEST=${LON_ORI}
while [ $WEST -lt ${LON_END} ];
do
  EAST=`expr $WEST + 5`

  SOUTH=${LAT_ORI}
  while [ $SOUTH -lt $LAT_END ];
  do
    NORTH=`expr $SOUTH + 30`

    CNAMEIN=`./src/set_name $WEST $SOUTH`
    OSMFILE="./osm/devide/${CNAMEIN}-lon5-lat30.osm.pbf"

    ISOUTH=$SOUTH
    while [ $ISOUTH -lt $NORTH ];
    do
      INORTH=`expr $ISOUTH + 5`

      CNAME=`./src/set_name $WEST $ISOUTH`
      OUTFILE="./osm/lonlat/${CNAME}-water.osm"

#      BOUND="left=${WEST} right=${EAST} top=${INORTH} bottom=${ISOUTH}"
      BOUND=`./src/set_bounds $WEST $EAST $ISOUTH $INORTH`
      BBOPT="completeWays=yes completeRelations=yes"

      echo $OUTFILE
      osmosis --rbf $OSMFILE --bb $BOUND $BBOPT --wx $OUTFILE &
    ISOUTH=`expr $ISOUTH + 5`
    done
    wait

  SOUTH=`expr $SOUTH + 30`
  done
WEST=`expr $WEST + 5`
done
