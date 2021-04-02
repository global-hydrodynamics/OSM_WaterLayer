# OSM water layer scripts
The scripts to generate OSM Water Layer
http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html

Dai Yamazaki, 2nd April 2021

## Requirement
Install OSMOSIS, GDAL, Fortran.
The scripts are written for MacOS. Modifications might be needed for other environment.

## Procedures
### [1] Prepare "sea mask" from OSM water-polygons
Work in OSM_sea/ directory.
Detailed procedure written in ReadMe.md in OSM_sea/

### [2] Create OSM water layer
Make a project directory (sample 2021Feb/ to process the OSM planet data at that time)
Go to extract_water/ directory.
Make osm/ directory, and download the latest planet.pbf from servers.
Then, follow the instruction in ReadMe.md  in 2021Feb directory.
