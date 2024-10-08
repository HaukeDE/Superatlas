# Superatlas
The Superatlas is a combination of the excellent maps of [basemap.de](https://basemap.de) and [OpenStreetMap (OSM) data](https://www.openstreetmap.org) to get the best of both worlds. The map is intended to be used as an offline map on a smartphone with [OruxMaps](https://www.oruxmaps.com/cs/en/).

The process of creating these maps is:
* Download the OSM data for the relevant region from [Geofrabrik](https://download.geofabrik.de/)
* Use [tilemaker](https://github.com/systemed/tilemaker) to select the relevant OSM data and put them into an mbtiles database file
* Download the basemap.de data (recommended: map data plus contour lines) into additional mbtiles files (e.g. using [QGIS](https://www.qgis.org/))
* Put Gylphs, Sprites, style file and mbtiles into the [OruxMaps](https://www.oruxmaps.com/cs/en/) mapfiles directory and refresh data sources

This respository contains:
* The config.json for the tilemaker process
* The process.lua LUA script for tilemaker OSM data prcessing
* The sprite files - please note that some icons used are published by [BKG](https://www.bkg.bund.de) under [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/) - all other icons are from public domain sources or self-made
* The glyphs, which are based on [Google Fonts](https://fonts.google.com/)
* The [Mapbox](https://www.mapbox.com/)/[Maplibre](https://maplibre.org/) JSON style file, which is based off and significantly extended from the basemap.de [color map](https://sgx.geodatenzentrum.de/gdz_basemapde_vektor/styles/bm_web_col.json) and [relief](https://sgx.geodatenzentrum.de/gdz_basemapde_vektor/styles/bm_web_top.json) style files, published by [BKG](https://www.bkg.bund.de) under [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/)

For usage guidance and detailed explanations, please read my [blog posts](https://projects.webvoss.de/2024/08/03/next-generation-perfect-offline-hiking-maps-superatlas-goes-vector-part-i-introduction/)
