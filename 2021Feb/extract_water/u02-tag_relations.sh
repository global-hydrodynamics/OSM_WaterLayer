#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

### extract waterway & natural-water, relations and ways

OSMFILE="./tag_mod/only-relation.osm"
OUTFILE="./tag_mod/tag-relation.osm"
osmosis  --fast-read-xml $OSMFILE --tf accept-relations natural=water      --wb tmp1.pbf &
osmosis  --fast-read-xml $OSMFILE --tf accept-relations waterway=*         --wb tmp2.pbf &
osmosis  --fast-read-xml $OSMFILE --tf accept-relations landuse=reservoir  --wb tmp3.pbf &
wait

osmosis  --rbf tmp1.pbf  --rbf tmp2.pbf  --rbf tmp3.pbf  --merge  --merge  --wx $OUTFILE
rm -f tmp?.pbf

OSMFILE="./tag_mod/tag-relation.osm"
cat $OSMFILE | grep 'type="way"' | grep 'role="outer"' | awk -F'"' '{print $4}' > ./tag_mod/way-id2.txt
