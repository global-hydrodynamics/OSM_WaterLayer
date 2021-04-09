#!/bin/sh

TAG="v2.0_2021Feb"

INPPBF="../../calc_2021Feb/extract_water/osm/water/planet-all.osm.pbf"
INPTIF="../../calc_2021Feb/merge_water/tif"
INPBIN="../../calc_2021Feb/merge_water/5deg"

mkdir -p $TAG
cd       $TAG

cp    $INPPBF ./OSM_WaterLayer.pbf
cp -r $INPTIF ./OSM_WaterLayer_tif
cp -r $INPBIN ./5deg

tar cvfz OSM_WaterLayer_tif.tar.gz OSM_WaterLayer_tif
tar cvfz 5deg.tar.gz               5deg


