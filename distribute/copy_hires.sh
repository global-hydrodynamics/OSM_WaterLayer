#!/bin/sh

TAG="v2.0_2021Feb"

INPBIN="../../hires_2021Feb/merge_water/"

cd $TAG

cp -r $INPBIN/1deg_10m   .
cp -r $INPBIN/1deg_30m   .

tar cvfz 1deg_10m.tar.gz 1deg_10m
tar cvfz 1deg_30m.tar.gz 1deg_30m


###


