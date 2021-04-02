# OSM water layer scripts
The scripts to generate OSM Water Layer

## Requirement
Install OSMOSIS and GDAL.
The scripts are written for MacOS. Modifications might be needed.

## Procedures
### Download the original planet.pbf data
Download the latest planet.pbf data from the official or mirror site.
https://wiki.openstreetmap.org/wiki/Planet.osm

Place the planet.pbf in extract_water/osm directory.

### Compile Fortran codes
Edit Makefile in extract_water/src/ if needed.
Compile all source codes by make all.

### Pre processing of planet.pbf data.
Pre-processing scripts are automatically executed by a01-preser.sh.

First, the planet.pbf file should be modified to generate water layers, by extracting/rejecting some features. Then, some essential ID is modified and the new pbf file planet-mod.pbf is generated

1. u01-notag_relationship.sh
2. u02-tag_relations.sh
3. u03-ways.sh
4. u04-extract-id.sh
5. u05-merge_planet.sh
