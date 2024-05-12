# Universe

The easy & flexible way to use interactive maps in Flutter.\
Supports OpenStreetMap, Google Maps, MapBox and more.

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/universe.png" width="300" alt="universe">

[Demo Universe.apk](https://mega.nz/file/fx1EwBjY#uf2nM-z8ZpU_gD4fuRsSWHLotsnR7VIne5c0V-Eo4LM)

[Starting](#starting)\
[Configuration](#configuration)\
[Complete Examples](#complete-examples)\
[Usage](#usage)
- [Open Street Map](#openstreetmap)
- [Google Maps](#google-maps)
- [MapBox](#mapbox)
- [Custom Map Provider](#custom-map-provider)
- [Multi TileLayer Maps](#multi-tilelayer-maps)
- [Other Map Providers](#other-map-providers)
- [Marker](#markers)
- [Live Maps](#live-maps)
- [Live Stream Maps](#live-stream-maps)
- [Static Maps](#static-maps)
- [MapController](#mapcontroller)
- [MapController Move](#mapcontroller)
- [MapController Zoom](#mapcontroller)
- [MapController Rotate](#mapcontroller)
- [MapController Find Location](#mapcontroller)
- [Circle](#circle)
- [Polyline](#polyline)
- [Polygon](#polygon)
- [Rectangle](#rectangle)
- [Image Overlay](#image-overlay)
- [Video Overlay](#video-overlay)
- [Custom Widget Overlay](#custom-widget-overlay)
- [Clean Map Without Controls](#custom-controls)
- [Custom Compass](#custom-controls)
- [Custom Locator](#custom-controls)
- [Custom Scale Indicator](#custom-controls)
- [Custom Location Indicator](#custom-controls)
- [Custom Tile Provider](#custom-tileprovider)
- [Geolocator: Center by Address](#geolocator)
- [Geolocator: Find LatLng of Address](#geolocator)
- [Geolocator: Move to Address](#geolocator)
- [Others](#other-examples)

## Starting

```
$ flutter pub add universe
```

## Configuration

Add permissions to your android AndroidManifest.xml.

```xml
<manifest xmlns:android...>
  ...
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
  <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
  <uses-permission android:name="android.permission.INTERNET"/>
  <application ...
</manifest>
```

## Complete Examples

Learn complete examples in this [folder](example) for many use cases of using Universe. Or install the example apk and try it on your device: [universe.apk](https://github.com/salkuadrat/universe/raw/master/universe.apk).

## Usage

Inspired by the simplicity of Leaflet.js, we can integrate maps in our flutter project with as simple as adding these lines of code.

```dart
import 'package:universe/universe.dart';

U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.HOT,
  zoom: 15,
)
```

### OpenStreetMap

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/osm.png" width="200" alt="OpenStreetMap">

```dart
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.Mapnik,
  zoom: 15,
)
```

```dart
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

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/gmaps.png" width="200" alt="Google Maps">

```dart
U.GoogleMap(
  center: [-6.175329, 106.827253],
  type: GoogleMapType.Street,
  zoom: 15,
)
```

```dart
// List of available GoogleMapType

GoogleMapType.Street 
GoogleMapType.Satellite
GoogleMapType.Hybrid
GoogleMapType.Terrain
```

[Complete Google Maps example](example/lib/src/map_provider/google.dart)


### MapBox

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/mapbox.png" width="200" alt="MapBox">

```dart
U.MapBox(
  // get your access token from https://account.mapbox.com/access-tokens/
  accessToken: '',
  center: [-6.175329, 106.827253],
  type: MapBoxType.Street,
  zoom: 15,
)
```

You can get your own MapBox access token from [here](https://account.mapbox.com/access-tokens/). Please always use your own access token in your projects.

```dart
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

```dart
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

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/multilayer.png" width="200" alt="Multi TileLayer">

We can create maps with multiple tile layers. Here is an example of using Humanitarian OpenStreetMap combined with map tiles from SafeCast and OpenRailwayMap.

```dart
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

### Other Map Providers

[Open Maps](example/lib/src/map_provider/open.dart)\
[Safecast Map](example/lib/src/map_provider/safecast.dart)\
[CyclOSM Map](example/lib/src/map_provider/cyclosm.dart)\
[Stadia Map](example/lib/src/map_provider/stadia.dart) (Need API Key)\
[Thunderforest Map](example/lib/src/map_provider/thunderforest.dart) (Need API Key)\
[Jawg Map](example/lib/src/map_provider/jawg.dart) (Need Access Token)\
[MapTiler Map](example/lib/src/map_provider/maptiler.dart) (Need API Key)\
[Stamen Map](example/lib/src/map_provider/stamen.dart)\
[TomTom Map](example/lib/src/map_provider/tomtom.dart) (Need API Key)\
[ESRI Map](example/lib/src/map_provider/esri.dart)\
[CartoDB Map](example/lib/src/map_provider/cartodb.dart)\
[BasemapAT Map](example/lib/src/map_provider/basemapat.dart)\
[HikeBike Map](example/lib/src/map_provider/hikebike.dart)\
[NLMaps](example/lib/src/map_provider/nlmaps.dart)\
[NLS Map](example/lib/src/map_provider/nlsmap.dart)\
[NASA GIBS Map](example/lib/src/map_provider/nasagibs.dart)\
[USGS Map](example/lib/src/map_provider/usgs.dart)\
[Waymarked Trails Map](example/lib/src/map_provider/waymarkedtrails.dart)\
[Geoportail France Map](example/lib/src/map_provider/geoportail.dart) (Need API Key)\
[Wikimedia Map](example/lib/src/map_provider/wikimedia.dart)\
[HERE Map](example/lib/src/map_provider/here.dart) (Need App ID & Credentials Code)

### Markers 

Here is a simple way of adding marker to universe maps.

```dart
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  type: OpenStreetMapType.HOT,
  zoom: 15,
  markers: U.MarkerLayer([51.556669, -0.108123]),
)
```

Complete marker examples:

[Simple Marker](example/lib/src/marker/default.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/marker.png" width="200" alt="Simple Marker">

[Marker with Data](example/lib/src/marker/data.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markerdata.png" width="200" alt="Marker with Data">

[Multiple Marker](example/lib/src/marker/multi.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markermulti.png" width="200" alt="Multiple Marker">

[Multiple Marker with Different Styles](example/lib/src/marker/multistyles.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markermultistyles.png" width="200" alt="Multiple Marker Styles">

[Multiple Marker with Data](example/lib/src/marker/multidata.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markermultidata.png" width="200" alt="Multiple Marker with Data">

[Marker Icon](example/lib/src/marker/icon.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markericon.png" width="200" alt="Marker Icon">

[Marker Image](example/lib/src/marker/image.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markerimage.png" width="200" alt="Marker Image">

[Marker SVG](example/lib/src/marker/svg.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markersvg.png" width="200" alt="Marker SVG">

[Marker Widget](example/lib/src/marker/widget.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markerwidget.png" width="200" alt="Marker Widget">

[Tap to Add Marker](example/lib/src/marker/add.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/markeradd.png" width="200" alt="Tap to Add Marker">

### Live Maps

```dart
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

The default behavior of Live Map is always move the center of the maps to user's current location. 

If you want to go live (always searching for user's current location and show location indicator to that location), but don't want to move the center of the maps, you can set parameter moveWhenLive to false.

```dart
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

### Live Stream Maps 

We can let the map live while also listening to current user's location by subscribing to `liveStream` of `MapController`.

```dart
_liveSubs = _mapController.liveStream?.listen((latlng) { 
  print('Current location: $latlng');
});
```

See the complete example at [Live Stream Map](example/lib/src/live/stream.dart)

### Static Maps

```dart
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

### MapController

We can use custom controller in our universe maps.

```dart
final _mapController = MapController();
```

```dart
U.OpenStreetMap(
  controller: _mapController,
  center: [51.555158, -0.108343],
  zoom: 15,
)
```

And use that controller to listen the positionStream to get current position and current zoom of our map. We can also programmatically move, zoom, rotate or find location using the map controller.

```dart
// listen everytime the map data changes (move or zoom)
_mapController.positionStream?.listen((data) {
  // current center of the map
  // print(data.center); 
  // current zoom level of the map
  // print(data.zoom);
});
```

[MapController](example/lib/src/controller/simple.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/controller.png" width="200" alt="MapController">

[Move Map example](example/lib/src/controller/move.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/controllermove.png" width="200" alt="MapController Move">

[Zoom Map example](example/lib/src/controller/zoom.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/controllerzoom.png" width="200" alt="MapController Zoom">

[Rotate Map example](example/lib/src/controller/rotate.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/controllerrotate.png" width="200" alt="MapController Rotate">

[Find Location example](example/lib/src/controller/locate.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/controllerlocate.png" width="200" alt="MapController Find Location">

### Circle

Here is a simple example of painting a circle to universe maps.

```dart
U.OpenStreetMap(
  center: [-6.170039, 106.8241],
  zoom: 15,
  // by default, CircleLayer will use style from theme primaryColor
  circles: U.CircleLayer(
    [-6.170039, 106.8241],
    radius: 160,
  ),
)
```

Complete circle examples:

[Simple Circle](example/lib/src/circle/simple.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circle.png" width="200" alt="Simple Circle">

[Custom Circle](example/lib/src/circle/custom.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circlecustom.png" width="200" alt="Custom Circle">

[Multiple Circles](example/lib/src/circle/multi.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circlemulti.png" width="200" alt="Multiple Circle">

[Multiple Circles with Different Styles](example/lib/src/circle/multistyles.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circlemultistyles.png" width="200" alt="Multiple Circle Styles">

[Circle with Data](example/lib/src/circle/data.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circledata.png" width="200" alt="Circle Data">

[Multiple Circles with Data](example/lib/src/circle/multidata.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/circlemultidata.png" width="200" alt="Multiple Circle Data">

### Polyline

Here is a simple example of painting a polyline to universe maps.

```dart
U.OpenStreetMap(
  center: [51.555015, -0.108331],
  zoom: 16,
  // by default, PolylineLayer will use style from theme primaryColor
  polylines: U.PolylineLayer(
    [
      [51.556650, -0.108170],
      [51.554508, -0.109983],
      [51.553968, -0.109650],
      [51.554081, -0.107097],
      [51.556203, -0.107762],
    ],
  ),
)
```

Complete polyline examples:

[Polyline](example/lib/src/polyline/simple.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polyline.png" width="200" alt="Polyline">

[Custom Polyline](example/lib/src/polyline/custom.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polylinecustom.png" width="200" alt="Custom Polyline">

[Multiple Polylines](example/lib/src/polyline/multi.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polylinemulti.png" width="200" alt="Multiple Polyline">

[Multiple Polylines with Different Styles](example/lib/src/polyline/multistyles.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polylinemultistyles.png" width="200" alt="Multiple Polyline Styles">

### Polygon

Here is a simple example of painting a polygon to universe maps.

```dart
U.OpenStreetMap(
  center: [51.555158, -0.108343],
  zoom: 15,
  // by default, PolygonLayer will use style from theme primaryColor
  polygons: U.PolygonLayer(
    [
      [51.556550, -0.108717],
      [51.555936, -0.109532],
      [51.555796, -0.109715],
      [51.555469, -0.110004],
      [51.555422, -0.109961],
      [51.555162, -0.110251],
      [51.555135, -0.110219],
      [51.554909, -0.110444],
      [51.554855, -0.110380],
      [51.554688, -0.110509],
      [51.554635, -0.110326],
      [51.554582, -0.110326],
      [51.554235, -0.109801],
      [51.554101, -0.110026],
      [51.553968, -0.109833],
      [51.553908, -0.109919],
      [51.553888, -0.109897],
      [51.553781, -0.109886],
      [51.553748, -0.108234],
      [51.553981, -0.107011],
      [51.553895, -0.106807],
      [51.553834, -0.106754],
      [51.553968, -0.106593],
      [51.554048, -0.106732],
      [51.554375, -0.106861],
      [51.555015, -0.106850],
      [51.555369, -0.106936],
      [51.555616, -0.107033],
      [51.555782, -0.107140],
      [51.555996, -0.107333],
      [51.556236, -0.107494],
      [51.556543, -0.107666],
      [51.556603, -0.107698],
    ],
  ),
)
```

Complete polygon examples:

[Polygon](example/lib/src/polygon/simple.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygon.png" width="200" alt="Polygon">

[Custom Polygon](example/lib/src/polygon/custom.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygoncustom.png" width="200" alt="Custom Polygon">

[Multiple Polygons](example/lib/src/polygon/multi.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygonmulti.png" width="200" alt="Multiple Polygon">

[Multiple Polygons with Diffrent Styles](example/lib/src/polygon/multistyles.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygonmultistyles.png" width="200" alt="Multiple Polygon">

[Polygon with Data](example/lib/src/polygon/data.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygondata.png" width="200" alt="Polygon Data">

[Multiple Polygons with Data](example/lib/src/polygon/multidata.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/polygonmultidata.png" width="200" alt="Multiple Polygon Data">

### Rectangle

Here is a simple example of painting a rectangle to universe maps.

```dart
U.OpenStreetMap(
  center: [51.555015, -0.108331],
  zoom: 16,
  // by default, RectangleLayer will use style from theme primaryColor
  rectangles: U.RectangleLayer(
    [
      [51.554488, -0.108964], // latlng of bottom left corner
      [51.555682, -0.107580], // latlng of top right corner
    ],
  ),
)
```

Complete rectangle examples:

[Rectangle](example/lib/src/rectangle/simple.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectangle.png" width="200" alt="Rectangle">

[Custom Rectangle](example/lib/src/rectangle/custom.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectanglecustom.png" width="200" alt="Custom Rectangle">

[Multiple Rectangles](example/lib/src/rectangle/multi.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectanglemulti.png" width="200" alt="Multiple Rectangle">

[Multiple Rectangles with Different Styles](example/lib/src/rectangle/multistyles.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectanglemultistyles.png" width="200" alt="Multiple Rectangle Styles">

[Rectangle with Data](example/lib/src/rectangle/data.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectangledata.png" width="200" alt="Rectangle Data">

[Multiple Rectangles with Data](example/lib/src/rectangle/multidata.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/rectanglemultidata.png" width="200" alt="Multiple Rectangle Data">

### Image Overlay

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/overlayimage.png" width="200" alt="Image Overlay">

Here is an example of painting an image overlay to universe maps.

```dart
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  zoom: 15,
  images: [
    U.ImageOverlay(
      // from url
      'http://img.freeflagicons.com/thumb/background_with_square_parts/indonesia/indonesia_640.png',
      // can use bounds from all 4 corners
      bounds: [
        [-6.180143, 106.823504],
        [-6.180344, 106.828948],
        [-6.17162, 106.82938],
        [-6.171958, 106.823674],
      ],
      fit: BoxFit.cover,
    ),
    U.ImageOverlay(
      // from assets
      'assets/startrek.png', 
      // can use bounds from only 2 corners 
      bounds: [
        [-6.17098, 106.825514], // latlng of bottom left corner
        [-6.167775, 106.822867], // latlng of top right corner
      ],
    )
  ],
)
```

[Image Overlay example](example/lib/src/overlay/image.dart)

### Video Overlay

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/overlayvideo.png" width="200" alt="Video Overlay">

Here is an example of painting a video overlay to universe maps.

```dart
U.GoogleMap(
  type: GoogleMapType.Satellite,
  center: [23.358295, -114.351456],
  zoom: 4,
  videos: [
    U.VideoOverlay(
      'https://www.mapbox.com/bites/00188/patricia_nasa.mp4',
      bounds: [
        [32, -130],
        [13, -100]
      ],
    ),
  ],
)
```

[Video Overlay example](example/lib/src/overlay/video.dart)

### Custom Widget Overlay

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/overlaywidget.png" width="200" alt="Widget Overlay">

Here is an example of painting a custom widget overlay to universe maps.

```dart
U.OpenStreetMap(
  center: [-6.170039, 106.8241],
  zoom: 16,
  layers: [
    U.WidgetOverlay(
      bounds: [
        [-6.17098, 106.825514], // latlng of bottom left corner
        [-6.167775, 106.822867], // latlng of top right corner
      ],
      // custom widget, we can be creative and use any widget we want
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            'Wanna bicycle?',
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
      ),
    )
  ],
)
```

[Custom Widget Overlay example](example/lib/src/overlay/widget.dart)

### Custom Controls

Universe maps come with default controls: compass, locator, scale and location indicator. But we can override this controls with our own controls to make it align with our app theme.

[Clean Map without Controls](example/lib/src/control/clean.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/clean.png" width="200" alt="Clean Map">

[Map with Custom Compass](example/lib/src/control/compass.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/compass.png" width="200" alt="Custom Compass">

[Map with Custom Locator](example/lib/src/control/locator.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/locator.png" width="200" alt="Custom Locator">

[Map with Custom Scale Indicator](example/lib/src/control/scale.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/scale.png" width="200" alt="Custom Scale Indicator">

[Map with Custom Location Indicator](example/lib/src/control/location_indicator.dart)

### Custom TileProvider

[NetworkTileProvider](example/lib/src/tile_provider/network.dart)\
[NetworkRetryTileProvider](example/lib/src/tile_provider/retry.dart)\
[CachedNetworkTileProvider](example/lib/src/tile_provider/cached.dart)\
[Offline AssetTileProvider](example/lib/src/tile_provider/asset.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/offline.png" width="200" alt="Offline AssetTileProvider">

### Geolocator

We can use geolocator to find position latlng from address string.

[Map Geolocator: Center by Address](example/lib/src/geolocator/center.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/geocenter.png" width="200" alt="Geolocator Center">

[Map Geolocator: Find LatLng of Address](example/lib/src/geolocator/finder.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/geolocate.png" width="200" alt="Geolocator Finder">

[Map Geolocator: Move to Address](example/lib/src/geolocator/move.dart)

<img src="https://github.com/salkuadrat/universe/raw/master/screenshot/geomove.png" width="200" alt="Geolocator Move">

### Other Examples 

[Complex Map](example/lib/src/home.dart)

[Map with Initial Rotation](example/lib/src/rotation/initial.dart)\
[Map with Disabled Rotation](example/lib/src/rotation/disable.dart)\
[Map with MaxBounds](example/lib/src/bounds/maxbounds.dart)\
[Map with FitBounds](example/lib/src/bounds/fitbounds.dart)