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
* The glyphs, which are based on [Google Fonts](https://fonts.google.com/) and the [Deja Vu font project](https://dejavu-fonts.github.io/)
* The [Mapbox](https://www.mapbox.com/)/[Maplibre](https://maplibre.org/) JSON style file, which is based off and significantly extended from the basemap.de [color map](https://sgx.geodatenzentrum.de/gdz_basemapde_vektor/styles/bm_web_col.json) and [relief](https://sgx.geodatenzentrum.de/gdz_basemapde_vektor/styles/bm_web_top.json) style files, published by [BKG](https://www.bkg.bund.de) under [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/)

For usage guidance and detailed explanations, please read my [blog posts](https://projects.webvoss.de/2024/08/03/next-generation-perfect-offline-hiking-maps-superatlas-goes-vector-part-i-introduction/)

# Detailed licensing/copyright information
The work published here contains data under the following copyrights:
* Style files and sprite (parts):
  * © GeoBasis-DE / [BKG](https://www.bkg.bund.de) (2025) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) - see also [BKG Nutzungsbedingungen](https://sgx.geodatenzentrum.de/web_public/gdz/lizenz/deu/Nutzungsbedingungen_basemapde.pdf)
  * © GeoBasis-DE / [BKG](https://www.bkg.bund.de) (2025) [dl-de/by-2-0](https://www.govdata.de/dl-de/by-2-0)
  * Map icons [CC-0](https://creativecommons.org/publicdomain/zero/1.0/) from [SJJB Management](https://www.sjjb.co.uk/mapicons/)
* Fonts:
  * Deja Vu fonts are under [free licensing according to the Bitstream Vera Font licensing and Tavmjong Bah Glyph licensing](https://dejavu-fonts.github.io/License.html) - Copyright (c) 2003 by Bitstream, Inc. All Rights Reserved. Bitstream Vera is a trademark of Bitstream, Inc., and Copyright (c) 2006 by Tavmjong Bah. All Rights Reserved. All changes made by the DejaVu project are [public domain](https://dejavu-fonts.github.io/License.html).
  * Noto fonts are under [SIL Open Font license 1.1](https://github.com/notofonts/noto-fonts/blob/main/LICENSE) - full information on Open Font license can be found [here](https://openfontlicense.org/)
  * Roboto fonts are (dependent on version) either under [Apache License 2.0](https://github.com/googlefonts/roboto-2/blob/main/LICENSE) (see also [Apache's licensing page](https://www.apache.org/licenses/)), or under [SIL Open Font license 1.1](https://fonts.google.com/specimen/Roboto/license).
* Tilemaker config file and process.lua are based on the examples given by the [Tilemaker project](https://tilemaker.org/) under [FTWPL](https://en.wikipedia.org/wiki/WTFPL) - see also [here](https://github.com/systemed/tilemaker)
* My own creations, which I declare public domain [CC-0](https://creativecommons.org/publicdomain/zero/1.0/). If you use or distribute my work, or distrubute follow-up work based on mine, I kindly ask you to give me credit by mentioning my name and/or link to my blog with URL https://projects.webvoss.de - or specifically to the Superatlas blog post with URL https://projects.webvoss.de/2024/08/03/next-generation-perfect-offline-hiking-maps-superatlas-goes-vector-part-i-introduction/
  
