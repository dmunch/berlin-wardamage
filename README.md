# Berlin Wardamage

Visualization of second world war structural damages in Berlin.

Project consists of two steps:
- Data pre-treatement: 
-- A script downloading tiled WMS data from Berlin's FIS-Broker (http://fbinter.stadt-berlin.de/fb/berlin/service.jsp?id=gebschaden@senstadt&type=WMS) using GDAL
-- An image processing pipeline using [gmic](http://gmic.eu) to remove noise and prepare raster data for vectorization
-- Vectorize raster data to vector data using [gdal_polygonize.py](http://www.gdal.org/gdal_polygonize.html)

- Serving GeoJSON vector data in VectorTile format for displaying it in Mapbox's [mapbox-gl-js](https://www.mapbox.com/blog/mapbox-gl-js/)
