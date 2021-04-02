#!/bin/sh
export JAVACMD_OPTIONS="-Xmx4G -Djava.io.tmpdir=./java.tmp"

OSMFILE="./tag_mod/notag-relation.osm"

awk  -F'"'  ' $1=="  <relation id=" || $1=="    <member type=" {print $1, $2, $4, $6}' $OSMFILE > tmp1
cat tmp1 | sed -e 's/<//g' | sed -e 's/id=//g' | sed -e 's/type=//g' | sed -e 's/way//g'        > tmp2
cat tmp2 | awk '$3!=""{print $1, $2, $3}' | grep -v "member relation" | grep -v "member node"   > ./tag_mod/relation-id.txt

awk  -F'"'  '{print $2}' ./tag_mod/list_way.txt > ./tag_mod/way-id.txt

./src/check_relation

./src/add_lake

cat ./tag_mod/water_add-relation.osm | sed -e 's/1970-01-01T00:00:00Z/2015-06-22T00:00:00Z/g' | sed -e 's/version="-1"/version="1"/g' > tmp.osm
osmosis --rx tmp.osm  --sort  --wx  list_modify.osm

rm -f tmp.osm
mv list_modify.osm tag_mod/

## modified relation data: ./tag_mod/list_modify.osm