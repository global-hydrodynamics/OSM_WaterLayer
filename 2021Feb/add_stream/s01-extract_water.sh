#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"
mkdir -p java.tmp
mkdir -p osm/stream

### extract waterway & natural-water, relations and ways

INPFILE2="./osm/water/planet-way_r.osm.pbf"
OUTFILE2="./osm/stream/planet-stream_r.osm.pbf"
osmosis  --rbf $INPFILE2 --tf accept-relations waterway=stream,brook,wadi,drystream  --uw --un  --wb $OUTFILE2  &

INPFILE5="./osm/water/planet-way_w.osm.pbf"
OUTFILE5="./osm/stream/planet-stream_w.osm.pbf"
osmosis  --rbf $INPFILE5 --tf reject-relations --tf accept-ways waterway=stream,brook,wadi,drystream --un  --wb $OUTFILE5 &

wait 
### combine all water contents

OUTFILE2="./osm/stream/planet-stream_r.osm.pbf"
OUTFILE5="./osm/stream/planet-stream_w.osm.pbf"

MERGEFILE="./osm/stream/planet-all.osm.pbf"

osmosis --rbf $OUTFILE5 --rbf $OUTFILE2 --merge --wb $MERGEFILE
