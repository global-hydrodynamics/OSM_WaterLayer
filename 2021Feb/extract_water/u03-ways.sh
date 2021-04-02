#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

### extract waterway & natural-water, relations and ways

PLANET="./osm/planet.osm.pbf"

OUTFILE4="./tag_mod/planet-nat_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways natural=water     --un  --wb $OUTFILE4 &

OUTFILE5="./tag_mod/planet-way_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways waterway=*        --un  --wb $OUTFILE5 &

OUTFILE6="./tag_mod/planet-res_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways landuse=reservoir --un  --wb $OUTFILE6 &

wait

OUTFILE="./tag_mod/only-way.pbf"
osmosis --rbf $OUTFILE4 --rbf $OUTFILE5 --rbf $OUTFILE6 --merge --merge --wb $OUTFILE


OSMFILE="./tag_mod/only-way.pbf"
OUTFILE="./tag_mod/only-way.osm"
osmosis --rbf $OSMFILE --tf reject-nodes --tf reject-relations --wx $OUTFILE

grep "<way" $OUTFILE > ./tag_mod/list_way.txt
