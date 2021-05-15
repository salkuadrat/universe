# Universe

The easy way to use interactive maps in Flutter. 
Inspired by [Leaflet.js](https://leafletjs.com/).

## Getting Started

You should add dependency in your flutter project. 

Since the initial version of this library use 3 dependencies from other git repos (the null safety version of their non-null safety packages), at this moment, you can only reference this library from github repo:

```yaml
dependencies:
  universe:
    git: 
      url: git://github.com/salkuadrat/universe.git
```

Then run `flutter pub get`.

## Example Project

There is a complete example project in the `example` folder. 
Check it out to find out the many use cases you can use this library.

You can try a working example with [universe.apk](universe.apk).

## Usage

Inspired by the simplicity of Leaflet.js, you can add maps functionality in your flutter project with as simple as adding this lines of code:

```
import 'package:universe/universe.dart';
```

```
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.HOT,
  zoom: 15,
)
```

Universe comes with built-in support for 3 maps provider: OpenStreetMap, Google Maps and MapBox.

### OpenStreetMap

```
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.Mapnik,
  zoom: 15,
)
```

[Complete OpenStreetMap example](example/lib/src/map_provider/osm.dart)


### Google Maps 

```
U.GoogleMap(
  center: [-6.175329, 106.827253],
  type: GoogleMapType.Street,
  zoom: 15,
)
```

[Complete GoogleMap example](example/lib/src/map_provider/google.dart)


### MapBox

```
U.MapBox(
  accessToken: yourAccessTokenHere,
  center: [-6.175329, 106.827253],
  type: MapBoxType.Street,
  zoom: 15,
)
```

You can get your own MapBox access token from [here](https://account.mapbox.com/access-tokens/). Please always use your own access token for each of your projects.

[Complete MapBox example](example/lib/src/map_provider/mapbox.dart)

### Markers 

You can add marker to your maps as simple as the following code:

```
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  type: OpenStreetMapType.Mapnik,
  zoom: 15,
  markers: U.MarkerLayer([51.556669, -0.108123]),
)
```

Complete marker examples:

[Simple Marker](example/lib/src/marker/default.dart)
[Marker with Data](example/lib/src/marker/data.dart)
[Multiple Marker](example/lib/src/marker/multi.dart)
[Marker Icon](example/lib/src/marker/icon.dart)
[Marker Image](example/lib/src/marker/image.dart)
[Marker SVG](example/lib/src/marker/svg.dart)
[Marker Widget](example/lib/src/marker/widget.dart)
[Tap to Add Marker](example/lib/src/marker/add.dart)
[Marker Icon](example/lib/src/marker/icon.dart)

### Static Maps

```
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  type: OpenStreetMapType.Mapnik,
  zoom: 15,
  interactive: false,
)
```

Complete static maps examples:

[Simple Static Map](example/lib/src/static/simple.dart)
[Static Map with Marker](example/lib/src/static/marker.dart)
[Static Map with Rotation](example/lib/src/static/rotate.dart)

### Other Examples 

[Complex Map](example/lib/src/home.dart)

[Live Map](example/lib/src/live/default.dart)
[Simple Live Map](example/lib/src/live/simple.dart)
[Live Map with Location Marker](example/lib/src/live/marker.dart)

[Map with Initial Rotation](example/lib/src/rotation/initial.dart)
[Map with Disabled Rotation](example/lib/src/rotation/disable.dart)
[Map with MaxBounds](example/lib/src/bounds/maxbounds.dart)
[Map with FitBounds](example/lib/src/bounds/fitbounds.dart)

[MapController](example/lib/src/controller/simple.dart)
[MapController: Move Map](example/lib/src/controller/move.dart)
[MapController: Zoom Map](example/lib/src/controller/zoom.dart)
[MapController: Rotate Map](example/lib/src/controller/rotate.dart)
[MapController: Find Location](example/lib/src/controller/locate.dart)

[Circle](example/lib/src/circle/simple.dart)
[Custom Circle](example/lib/src/circle/custom.dart)
[Multiple Circles](example/lib/src/circle/multi.dart)
[Multiple Circles with Different Styles](example/lib/src/circle/multistyles.dart)
[Circle with Data](example/lib/src/circle/data.dart)
[Multiple Circles with Data](example/lib/src/circle/multidata.dart)

[Polyline](example/lib/src/polyline/simple.dart)
[Custom Polyline](example/lib/src/polyline/custom.dart)
[Multiple Polylines](example/lib/src/polyline/multi.dart)
[Multiple Polylines with Different Styles](example/lib/src/polyline/multistyles.dart)

[Polygon](example/lib/src/polygon/simple.dart)
[Multiple Polygons](example/lib/src/polygon/multi.dart)
[Multiple Polygons with Diffrent Styles](example/lib/src/polygon/multistyles.dart)
[Polygon with Data](example/lib/src/polygon/data.dart)
[Multiple Polygons with Data](example/lib/src/polygon/multidata.dart)

[Rectangle](example/lib/src/rectangle/simple.dart)
[Custom Rectangle](example/lib/src/rectangle/custom.dart)
[Multiple Rectangles](example/lib/src/rectangle/multi.dart)
[Multiple Rectangles with Different Styles](example/lib/src/rectangle/multistyles.dart)
[Rectangle with Data](example/lib/src/rectangle/data.dart)
[Multiple Rectangles with Data](example/lib/src/rectangle/multidata.dart)

[Image Overlay](example/lib/src/overlay/image.dart)
[Widget Overlay](example/lib/src/overlay/widget.dart)
[Video Overlay](example/lib/src/overlay/video.dart)

[TileProvider: NetworkTileProvider](example/lib/src/tile_provider/network.dart)
[TileProvider: NetworkRetryTileProvider](example/lib/src/tile_provider/retry.dart)
[TileProvider: CachedNetworkTileProvider](example/lib/src/tile_provider/cached.dart)
[TileProvider: Offline AssetTileProvider](example/lib/src/tile_provider/asset.dart)

[Map with Custom Compass](example/lib/src/control/compass.dart)
[Map with Custom Locator](example/lib/src/control/locator.dart)
[Map with Custom Scale Indicator](example/lib/src/control/scale.dart)
[Map with Custom Location Indicator](example/lib/src/control/location_indicator.dart)

[Map Geolocator: Center by Address](example/lib/src/geolocator/center.dart)
[Map Geolocator: Find LatLng by Address](example/lib/src/geolocator/finder.dart)
[Map Geolocator: Move by Address](example/lib/src/geolocator/move.dart)