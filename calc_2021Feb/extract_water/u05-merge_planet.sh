#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

INPFILE="./osm/planet.osm.pbf"
ADDFILE="./tag_mod/water_add-relation.osm"
OUTFILE="./osm/planet-mod.osm.pbf"

osmosis --rx $ADDFILE --rbf $INPFILE  --merge  conflictResolutionMethod=lastSource --wb $OUTFILE