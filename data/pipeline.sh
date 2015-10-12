#!/bin/bash

gdal_translate -of gtiff -co "tiled=yes" -outsize 8192 8192 fisbroker_wms_source.xml wardamage.tiff
gmic wardamage.tiff  -split c -keep[0] -denoise_haar 3 -quantize 4,0 -split_colors 0,4,5 -erode 5 -dilate 5 -output wardamage_segmented.tiff

wget https://raw.githubusercontent.com/OSGeo/gdal/trunk/gdal/swig/python/samples/gdalcopyproj.py
python gdalcopyproj.py wardamage_segmented.tiff wardamage_segmented_000002.tiff 
python gdalcopyproj.py wardamage_segmented.tiff wardamage_segmented_000003.tiff 

python /usr/local/bin/gdal_polygonize.py  -b 2 segmented_000002.tiff -f 'GeoJSON' wardamage_01.json
python /usr/local/bin/gdal_polygonize.py  -b 2 segmented_000003.tiff -f 'GeoJSON' wardamage_02.json

ogr2ogr -t_srs WGS84 -f "GeoJSON" wardamage_01_WGS84.json wardamage_01.json -simplify 0.0001
ogr2ogr -t_srs WGS84 -f "GeoJSON" wardamage_02_WGS84.json wardamage_02.json -simplify 0.0001
