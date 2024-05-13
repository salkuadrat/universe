## [2.0.1] - 13 May 2024

* Refactor StatefulWidget classes
* Reformat all files

## [2.0.0] - 12 May 2024

* Update all dependencies
* Add supports for all platforms (web, windows, linux, mac)
* Refactor null safety

## [1.1.3-nullsafety] - 12 January 2022

* Update all dependencies

## [1.1.2-nullsafety] - 01 November 2021 

* Update all dependencies

## [1.1.1-nullsafety] - 09 September 2021

* Use background location for live map stream
* Change package for geocoding findLocation from flutter_geocoder to geocode
* Update dependency extended_image to version 4.2.1
* Update dependency cached_network_image to version 3.1.0
* Update dependency video_player to version 2.1.15
* Update dependency provider to version 6.0.0
* Update dependency flutter_image to version 4.1.0
* Fixing Mercator Projection

## [1.1.0-nullsafety] - 17 August 2021

* Improving tile layer rendering by:
  - Change default tile provider to NetworkRetryTileProvider
  - Change default tileFadeInCurveDef to Curves.easeOutQuint
  - Clearing unnecessary sort computation in TileLayer
  - Improving calculations of _setZoomTransforms
  - Clearing unnecessary double call to _setZoomTransforms
  - Improving calculations inside didUpdateWidget

* Fixing bugs on WMSTileLayer rendering
* Improving documentation

## [1.0.8-nullsafety] - 17 July 2021

* Fixing "flashed" marker & overlay image into gapless playback.

## [1.0.7-nullsafety] - 26 June 2021

* add live stream to always listen to user's current location when live

## [1.0.6-nullsafety] - 18 June 2021

* pruning deprecated (unavailable) map providers

## [1.0.5-nullsafety] - 08 June 2021

* Fixing animation dispose at MapState

## [1.0.4-nullsafety] - 08 June 2021

* Fix MapState dispose

## [1.0.3-nullsafety] - 08 June 2021

* Fix centerMarker & locationMarker

## [1.0.2-nullsafety] - 08 June 2021

* Smoothing tile layer

## [1.0.1-nullsafety] - 08 June 2021

* change image downloader at TileLayer from extended_image to cached_network_image

## [1.0.0-nullsafety] - 08 June 2021

* turn off logs

## [0.0.8-nullsafety] - 08 June 2021

* add dispose to MapController
* change MapStates into MapState
* fixing multipe heroes problem caused by Compass & Locator
* call MapState dispose properly
* Fixing some leaks at TileLayer

## [0.0.7-nullsafety] - 29 May 2021

* Change into plugin to force support for ios

## [0.0.6-nullsafety] - 20 May 2021

* reorganize assets

## [0.0.5-nullsafety.6] - 20 May 2021

* change default margin of compass and scale

## [0.0.5-nullsafety.5] - 19 May 2021

* try setting the flutter version environment to ">=1.24.0-10.2.pre" (hopefully it can change the multiple platform supports score)

## [0.0.5-nullsafety.4] - 19 May 2021

* remove environment flutter from pubspec to support all platforms

## [0.0.5-nullsafety.3] - 19 May 2021

* format all

## [0.0.5-nullsafety.2] - 19 May 2021

* remove module android-X to support all platforms

## [0.0.5-nullsafety.1] - 19 May 2021

* explicitly add path_provider dependency to support all platforms

## [0.0.5-nullsafety] - 19 May 2021

* change caching image from cache_network_image to extended_image
* import both material & cupertino

## [0.0.4-nullsafety.3] - 18 May 2021

* format all

## [0.0.4-nullsafety.2] - 18 May 2021

* update examples
* update documentation

## [0.0.4-nullsafety.1] - 17 May 2021

* fix attribution
* add HERE map providers

## [0.0.4-nullsafety] - 17 May 2021

* adding & restructuring map providers

## [0.0.3-nullsafety] - 16 May 2021

* support multi tile layers maps

## [0.0.2-nullsafety.2] - 16 May 2021

* format all .dart files

## [0.0.2-nullsafety.1] - 16 May 2021

* Change dependency cached_network_image to version 3.1.0-alpha.1
* Add Live Map Without Automoving example
* Add Custom Map Provider example

## [0.0.2-nullsafety] - 16 May 2021

* Fixing non null safety dependencies

## [0.0.2] - 15 May 2021

* Change from Cubit to Provider
* Migrate to null safety

## [0.0.1] - Mar 2021

* Initial version of Universe (still using Cubit)
