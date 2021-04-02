#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

# requires OSMOSIS and GDAL.
# Download latest planet.pbf, and save it in osm/ directoly
# compile the code in src/ in advance.

mkdir -p log

# u01 ~ u05
## To fix bug in OSM file, some "relation" tags should be added.
## planet.osm.pbf is modified to planet-mod.osm.pbf

./u01-notag_relations.sh  > log_u01.txt 2> err_u01.txt  
./u02-tag_relations.sh    > log_u02.txt 2> err_u02.txt
./u03-ways.sh             > log_u03.txt 2> err_u03.txt
./u04-extract-id.sh       > log_u04.txt 2> err_u04.txt
./u05-merge_planet.sh     > log_u05.txt 2> err_u05.txt

mv log_u*.txt ./log/
mv err_u*.txt ./log/