#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"
mkdir -p java.tmp
mkdir -p osm/bank

### extract waterway & natural-water, relations and ways

INPFILE2="./osm/water/planet-way_r.osm.pbf"
OUTFILE2="./osm/bank/planet-bank_r.osm.pbf"
osmosis  --rbf $INPFILE2 --tf accept-relations waterway=riverbank,river  --uw --un  --wb $OUTFILE2  &

INPFILE5="./osm/water/planet-way_w.osm.pbf"
OUTFILE5="./osm/bank/planet-bank_w.osm.pbf"
osmosis  --rbf $INPFILE5 --tf reject-relations --tf accept-ways waterway=riverbank,river --un  --wb $OUTFILE5 &

wait 
### combine all water contents

OUTFILE2="./osm/bank/planet-bank_r.osm.pbf"
OUTFILE5="./osm/bank/planet-bank_w.osm.pbf"

MERGEFILE="./osm/bank/planet-all.osm.pbf"

osmosis --rbf $OUTFILE5 --rbf $OUTFILE2 --merge --wb $MERGEFILE
