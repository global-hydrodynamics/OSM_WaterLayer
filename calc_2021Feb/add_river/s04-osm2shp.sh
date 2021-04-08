#!/bin/sh
OPTIONS='-overwrite --config OSM_CONFIG_FILE ./osmconf_water.ini -skipfailures ' 
mkdir -p shp
mkdir -p ./osm/lonlat-tmp

LON_ORI=-180
LON_END=180
LAT_ORI=-60
LAT_END=90

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4


WEST=${LON_ORI}
while [ $WEST -lt ${LON_END} ];
do
  EAST=`expr $WEST + 5`

  SOUTH=${LAT_ORI}
  while [ $SOUTH -lt $LAT_END ];
  do
  	NORTH=`expr $SOUTH + 5`

    CNAME=`./src/set_name $WEST $SOUTH`
    OSMFILE="./osm/lonlat/${CNAME}-water.osm"
    TMPFILE="./osm/lonlat-tmp/${CNAME}-water.osm"

    osmosis --rx $OSMFILE --tf reject-ways tunnel=yes --wx tmp.osm
    mv -f tmp.osm $OSMFILE

    SHPDIR="./shp/${CNAME}"
    mkdir -p $SHPDIR

    WATTAG='<tag k="natural" v="water"/>'
    RESTAG='<tag k="landuse" v="reservoir"/>'

    cat $OSMFILE | sed -e "s#${WATTAG}#TTWAT#" | grep -v '<tag k="natural"' | sed -e "s#TTWAT#${WATTAG}#" | sed -e "s#${RESTAG}#TTRES#" | grep -v '<tag k="landuse"' | sed -e "s#TTRES#${RESTAG}#" > $TMPFILE
    ogr2ogr $OPTIONS -f "ESRI Shapefile" $SHPDIR $TMPFILE


  SOUTH=`expr $SOUTH + 5`
  done
  wait
WEST=`expr $WEST + 5`
done
wait
