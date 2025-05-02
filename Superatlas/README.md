The files in this directory are:
* superatlas.map.json<br />
This file is the offline map style file for Superatlas in OruxMaps.
* superatlasMBT.map.json<br />
The same, but adjusted to use [Mobile Tile Server](https://play.google.com/store/apps/details?id=com.bojko108.mobiletileserver&hl=gsw) to provide data. This is to work around the Webserver-Crash-Bug in OruxMaps.
* superatlasOnline.map.json<br />
Style file that fetches the basemap.de data online - can be used if you have mobile data reception and do not have the current area as offline file on your phone.
* superatlasOnlineMBT.map.json<br />
Same, but this one again using Mobile Tile Server as a workaround - needed for the Superatlas Offline layer.

For more information on the OruxMaps bug and the Mobile Tile Server workaround, refer to [this blog part](https://projects.webvoss.de/2024/08/03/superatlas-goes-vector-part-ii-creating-and-using-the-offline-vector-maps/#Current_Situation_Workaround_needed_for_an_OruxMaps_Bug_Three_Options).
