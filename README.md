# Universe

The easy & flexible way to use interactive maps in Flutter. Inspired by [Leaflet.js](https://leafletjs.com/).

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot.jpg" alt="universe" width="400">

## Getting Started

Add dependency to your flutter project:

```yaml
dependencies:
  universe: ^0.0.4-nullsafety.1
```

```yaml
dependencies:
  universe:
    git: 
      url: git://github.com/salkuadrat/universe.git
```

Then run `flutter pub get`.

## Android Permissions

Add Internet & Location permissions to your AndroidManifest.xml.

```
<manifest xmlns:android...>
  ...
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <application ...
</manifest>
```

## Example Project

There is a complete example project in the `example` folder.\
Check it out to learn the many use cases of using Universe library.

You can also try a working example with [universe.apk](universe.apk).

## Usage

Inspired by the simplicity of Leaflet.js, we can add maps functionality to our flutter project with as simple as adding this lines of code:

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

### Maps Provider

Universe comes with built-in support for 3 maps provider: OpenStreetMap, Google Maps and MapBox.

### OpenStreetMap

```
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.Mapnik,
  zoom: 15,
)
```

```
// List of available OpenStreetMapType

// OSM Mapnik
OpenStreetMapType.Mapnik 
// OSM Germany
OpenStreetMapType.DE
// OSM Switzerland
OpenStreetMapType.CH
// OSM France
OpenStreetMapType.France
// Humanitarian OSM
OpenStreetMapType.HOT
// OSM Breton
OpenStreetMapType.BZH
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


```
// List of available GoogleMapType

GoogleMapType.Street 
GoogleMapType.Satellite
GoogleMapType.Hybrid
GoogleMapType.Terrain
```

[Complete Google Maps example](example/lib/src/map_provider/google.dart)


### MapBox

```
U.MapBox(
  accessToken: yourAccessTokenHere,
  center: [-6.175329, 106.827253],
  type: MapBoxType.Street,
  zoom: 15,
)
```

You can get your own MapBox access token from [here](https://account.mapbox.com/access-tokens/). Please always use your own access token in your projects.

```
// List of available MapBoxType

MapBoxType.Basic
MapBoxType.Street 
MapBoxType.Satellite
MapBoxType.Hybrid
MapBoxType.Outdoors
MapBoxType.Dark
MapBoxType.Light
MapBoxType.Bright
```

[Complete MapBox example](example/lib/src/map_provider/mapbox.dart)

### Custom Map Provider

We can call U.Map directly to use maps with custom map providers. Here is an example of using custom map from OpenTopoMap.

```
U.Map(
  center: [51.555158, -0.108343],
  base: U.TileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    attribution: 'Map data: &copy; OpenStreetMap contributors, SRTM | Map style: &copy; OpenTopoMap',
    maxZoom: 17,
  ),
)
```

[Complete Custom Map example](example/lib/src/map_provider/custom.dart)

### Multi TileLayer Maps

We can create maps with multiple tile layers. Here is an example of using Humanitarian OpenStreetMap combined with map tiles from SafeCast and OpenRailwayMap.

```
U.OpenStreetMap(
  type: OpenStreetMapType.HOT,
  center: [48.858236, 2.294477],
  zoom: 12,
  tiles: [
    // add environmental measurements map layer from SafeCast (http://safecast.org/)
    U.TileLayer(
      'https://s3.amazonaws.com/te512.safecast.org/{z}/{x}/{y}.png', 
      attribution: 'Data: &copy; OpenStreetMap contributors | Style: &copy; SafeCast',
      maxZoom: 16,
    ),
    // add map layer from OpenRailwayMap
    U.TileLayer(
      'https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png', 
      attribution: 'Data: &copy; OpenStreetMap contributors | Style: &copy; OpenRailwayMap',
      maxZoom: 19,
    ),
  ],
)
```

[Multi TileLayer Maps example](example/lib/src/map_provider/multi.dart)

### Markers 

Here is a simple example of adding a marker to universe maps.

```
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  type: OpenStreetMapType.HOT,
  zoom: 15,
  markers: U.MarkerLayer([51.556669, -0.108123]),
)
```

Complete marker examples:

[Simple Marker](example/lib/src/marker/default.dart)\
[Marker with Data](example/lib/src/marker/data.dart)\
[Multiple Marker](example/lib/src/marker/multi.dart)\
[Multiple Marker with Different Styles](example/lib/src/marker/multistyles.dart)\
[Multiple Marker with Data](example/lib/src/marker/multidata.dart)\
[Marker Icon](example/lib/src/marker/icon.dart)\
[Marker Image](example/lib/src/marker/image.dart)\
[Marker SVG](example/lib/src/marker/svg.dart)\
[Marker Widget](example/lib/src/marker/widget.dart)\
[Tap to Add Marker](example/lib/src/marker/add.dart)

### Live Maps

```
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  type: OpenStreetMapType.HOT,
  zoom: 15,
  live: true,
)
```

Complete live maps examples:

[Default Live Map](example/lib/src/live/default.dart)\
[Simple Live Map](example/lib/src/live/simple.dart)\
[Live Map with Location Marker](example/lib/src/live/marker.dart)

### Live Maps Without AutoMoving

The default behavior of Live Map will always move the center of the maps to user's current location. 

If we want to go live (always searching for user's current location and show location indicator to that location), but don't want to move the center of the maps, we can set parameter moveWhenLive to false.

```
U.GoogleMap(
  type: GoogleMapType.Street,
  center: [-6.169976, 106.830979],
  zoom: 16,
  live: true,
  // moveWhenLive: false will make the map live (constantly search for user location),
  // set the location indicator to current user location, but does not 
  // move the center of the maps automatically to that location.

  // moveWhenLive has default value set to true
  moveWhenLive: false,
)
```

[Live Map without Auto Moving](example/lib/src/live/notmove.dart)

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

[Simple Static Map](example/lib/src/static/simple.dart)\
[Static Map with Marker](example/lib/src/static/marker.dart)\
[Static Map with Rotation](example/lib/src/static/rotate.dart)

### Other Examples 

[Complex Map](example/lib/src/home.dart)

[Map with Initial Rotation](example/lib/src/rotation/initial.dart)\
[Map with Disabled Rotation](example/lib/src/rotation/disable.dart)\
[Map with MaxBounds](example/lib/src/bounds/maxbounds.dart)\
[Map with FitBounds](example/lib/src/bounds/fitbounds.dart)

[MapController](example/lib/src/controller/simple.dart)\
[MapController: Move Map](example/lib/src/controller/move.dart)\
[MapController: Zoom Map](example/lib/src/controller/zoom.dart)\
[MapController: Rotate Map](example/lib/src/controller/rotate.dart)\
[MapController: Find Location](example/lib/src/controller/locate.dart)

[Circle](example/lib/src/circle/simple.dart)\
[Custom Circle](example/lib/src/circle/custom.dart)\
[Multiple Circles](example/lib/src/circle/multi.dart)\
[Multiple Circles with Different Styles](example/lib/src/circle/multistyles.dart)\
[Circle with Data](example/lib/src/circle/data.dart)\
[Multiple Circles with Data](example/lib/src/circle/multidata.dart)

[Polyline](example/lib/src/polyline/simple.dart)\
[Custom Polyline](example/lib/src/polyline/custom.dart)\
[Multiple Polylines](example/lib/src/polyline/multi.dart)\
[Multiple Polylines with Different Styles](example/lib/src/polyline/multistyles.dart)

[Polygon](example/lib/src/polygon/simple.dart)\
[Multiple Polygons](example/lib/src/polygon/multi.dart)\
[Multiple Polygons with Diffrent Styles](example/lib/src/polygon/multistyles.dart)\
[Polygon with Data](example/lib/src/polygon/data.dart)\
[Multiple Polygons with Data](example/lib/src/polygon/multidata.dart)

[Rectangle](example/lib/src/rectangle/simple.dart)\
[Custom Rectangle](example/lib/src/rectangle/custom.dart)\
[Multiple Rectangles](example/lib/src/rectangle/multi.dart)\
[Multiple Rectangles with Different Styles](example/lib/src/rectangle/multistyles.dart)\
[Rectangle with Data](example/lib/src/rectangle/data.dart)\
[Multiple Rectangles with Data](example/lib/src/rectangle/multidata.dart)

[Image Overlay](example/lib/src/overlay/image.dart)\
[Widget Overlay](example/lib/src/overlay/widget.dart)\
[Video Overlay](example/lib/src/overlay/video.dart)

[TileProvider: NetworkTileProvider](example/lib/src/tile_provider/network.dart)\
[TileProvider: NetworkRetryTileProvider](example/lib/src/tile_provider/retry.dart)\
[TileProvider: CachedNetworkTileProvider](example/lib/src/tile_provider/cached.dart)\
[TileProvider: Offline AssetTileProvider](example/lib/src/tile_provider/asset.dart)

[Map with Custom Compass](example/lib/src/control/compass.dart)\
[Map with Custom Locator](example/lib/src/control/locator.dart)\
[Map with Custom Scale Indicator](example/lib/src/control/scale.dart)\
[Map with Custom Location Indicator](example/lib/src/control/location_indicator.dart)

[Map Geolocator: Center by Address](example/lib/src/geolocator/center.dart)\
[Map Geolocator: Find LatLng by Address](example/lib/src/geolocator/finder.dart)\
[Map Geolocator: Move by Address](example/lib/src/geolocator/move.dart)