#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

mkdir -p java.tmp
mkdir -p osm/water

### extract waterway & natural-water, relations and ways

PLANET="./osm/planet-mod.osm.pbf"

OUTFILE1="./osm/water/planet-nat_r.osm.pbf"
osmosis  --rbf $PLANET --tf accept-relations natural=water     --uw --un  --wb $OUTFILE1 &

OUTFILE2="./osm/water/planet-way_r.osm.pbf"
osmosis  --rbf $PLANET --tf accept-relations waterway=*        --uw --un  --wb $OUTFILE2 &

OUTFILE3="./osm/water/planet-res_r.osm.pbf"
osmosis  --rbf $PLANET --tf accept-relations landuse=reservoir --uw --un  --wb $OUTFILE3 &


OUTFILE4="./osm/water/planet-nat_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways natural=water     --un  --wb $OUTFILE4 &

OUTFILE5="./osm/water/planet-way_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways waterway=*        --un  --wb $OUTFILE5 &

OUTFILE6="./osm/water/planet-res_w.osm.pbf"
osmosis  --rbf $PLANET --tf reject-relations --tf accept-ways landuse=reservoir --un  --wb $OUTFILE6 &

wait

### combine all water contents

OUTFILE1="./osm/water/planet-nat_w.osm.pbf"
OUTFILE2="./osm/water/planet-way_w.osm.pbf"
OUTFILE3="./osm/water/planet-res_w.osm.pbf"
OUTFILE4="./osm/water/planet-nat_r.osm.pbf"
OUTFILE5="./osm/water/planet-way_r.osm.pbf"
OUTFILE6="./osm/water/planet-res_r.osm.pbf"
MERGEFILE="./osm/water/planet-all.osm.pbf"
TMPFILE="./osm/water/tmp_merge.osm.pbf"

osmosis --rbf $OUTFILE3 --rbf $OUTFILE2 --rbf $OUTFILE1                --merge --merge         --wb $TMPFILE
osmosis --rbf $OUTFILE6 --rbf $OUTFILE5 --rbf $OUTFILE4 --rbf $TMPFILE --merge --merge --merge --wb $MERGEFILE
