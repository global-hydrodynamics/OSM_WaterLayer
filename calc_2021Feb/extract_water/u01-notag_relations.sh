#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

mkdir -p java.tmp
mkdir -p tag_mod

### extract waterway & natural-water, relations and ways

OSMFILE="./osm/planet.osm.pbf"
OUTFILE="./tag_mod/only-relation.osm"
osmosis --rbf $OSMFILE --tf reject-ways --tf reject-nodes --wx $OUTFILE

OSMFILE="./tag_mod/only-relation.osm"
OUTFILE="./tag_mod/notag-relation.osm"
osmosis --fast-read-xml $OSMFILE --tf accept-relations type=multipolygon --tf reject-relations natural=* --tf reject-relations waterway=* --tf reject-relations building=* --tf reject-relations landuse=* --tf reject-relations amenity=* --tf reject-relations highway=* --tf reject-relations boundary=* --tf reject-relations place=* --tf reject-relations aeroway=* --tf reject-relations tourism=* --tf reject-relations railway=* --tf reject-relations barrier=* --tf reject-relations shop=* --tf reject-relations wood=* --tf reject-relations FIXME=* --tf reject-relations fixme=* --tf reject-relations building:part=* --tf reject-relations area:highway=* --tf reject-relations leisure=* --wx $OUTFILE

OSMFILE="./tag_mod/notag-relation.osm"

# for additional edditing
#osmosis --fast-read-xml $OSMFILE --tf reject-relations FIXME=* --wx tmp.osm
#mv tmp.osm $OSMFILE

grep "<relation" $OSMFILE | wc -l 

grep tag $OSMFILE | grep -v multipolygon | grep -v name | grep -v created_by | grep -v source | grep -v note > tmp1 
grep -v addr tmp1 | grep -v GeoBase > tmp.txt

rm -f tmp1
