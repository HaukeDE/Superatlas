# Superatlas
The Superatlas is a combination of the excellent maps of [basemap.de](https://basemap.de) and [OpenStreetMap (OSM) data](https://www.openstreetmap.org) to get the best of both worlds.

The process of creating these maps is:
* Download the OSM data for the relevant region from [Geofrabrik](https://download.geofabrik.de/)
* Use [tilemaker](https://github.com/systemed/tilemaker) to select the relevant OSM data and put them into an mbtiles database file
* Download the basemap.de data (recommended: map data plus contour lines) into additional mbtiles files (e.g. using [QGIS](https://www.qgis.org/)
* Put Gylphs, Sprites, style file and mbtiles into the [OruxMaps](https://www.oruxmaps.com/cs/en/) mpfiles directory and refresh data sources

This respository contains:
* The config.json for the tilemaker process
* The process.lua LUA script for tilemaker OSM data prcessing
* The sprite files - please note that some icons used are published by [BKG](https://www.bkg.bund.de) under [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/) - all other icons are from public domain sources or self-made
* The glyphs, which are based on [Google Fonts](https://fonts.google.com/)
* The Mapbox/Maplibre JSON style file, which is based off and significantly extended from the basemap.de color map and relief style files, published by [BKG](https://www.bkg.bund.de) under [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/)

For usage guidance nd detailed explanations, please read my [blog posts](https://projects.webvoss.de)
