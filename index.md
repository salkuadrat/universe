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

## Getting Started

Add dependency to your flutter project:

```yaml
dependencies:
  universe: ^0.0.4-nullsafety.2
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

```xml
<manifest xmlns:android...>
  ...
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <application ...
</manifest>
```

### OpenStreetMap

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

[Safecast Map](example/lib/src/map_provider/safecast.dart)\
[Cycl OSM Map](example/lib/src/map_provider/cyclosm.dart)\
[Freemap SK Map](example/lib/src/map_provider/freemapsk.dart)\
[MtbMap](example/lib/src/map_provider/mtbmap.dart)\
[NLS Map](example/lib/src/map_provider/nlsmap.dart)\
[Wikimedia Map](example/lib/src/map_provider/wikimedia.dart)\
[Open Maps](example/lib/src/map_provider/open.dart)\
[Stadia Map](example/lib/src/map_provider/stadia.dart)\
[Thunderforest Map](example/lib/src/map_provider/thunderforest.dart) (Need API Key)\
[Hydda Map](example/lib/src/map_provider/hydda.dart)\
[Jawg Map](example/lib/src/map_provider/jawg.dart) (Need Access Token)\
[MapTiler Map](example/lib/src/map_provider/maptiler.dart) (Need API Key)\
[Stamen Map](example/lib/src/map_provider/stamen.dart)\
[TomTom Map](example/lib/src/map_provider/tomtom.dart) (Need API Key)\
[ESRI Map](example/lib/src/map_provider/esri.dart)\
[CartoDB Map](example/lib/src/map_provider/cartodb.dart)\
[BasemapAT Map](example/lib/src/map_provider/basemapat.dart)\
[HikeBike Map](example/lib/src/map_provider/hikebike.dart)\
[NLMaps](example/lib/src/map_provider/nlmaps.dart)\
[OneMapSG](example/lib/src/map_provider/onemapsg.dart)\
[NASA GIBS Map](example/lib/src/map_provider/nasagibs.dart)\
[USGS Map](example/lib/src/map_provider/usgs.dart)\
[Waymarked Trails Map](example/lib/src/map_provider/waymarkedtrails.dart)\
[Geoportail France Map](example/lib/src/map_provider/geoportail.dart) (Need API Key)\
[HERE Map](example/lib/src/map_provider/here.dart) (Need App ID & Credentials Code)

### Markers 

Here is a simple example of adding a marker to universe maps.

```dart
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

The default behavior of Live Map will always move the center of the maps to user's current location. 

If we want to go live (always searching for user's current location and show location indicator to that location), but don't want to move the center of the maps, we can set parameter moveWhenLive to false.

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

And use the controller to listen the positionStream to get current position and current zoom of our map. We can also programmatically move, zoom, rotate or find location using the map controller.

```dart
// listen everytime the map data changes (move or zoom)
_mapController.positionStream?.listen((data) {
  // current center of the map
  // print(data.center); 
  // current zoom level of the map
  // print(data.zoom);
});
```

[MapController](example/lib/src/controller/simple.dart)\
[Move Map example](example/lib/src/controller/move.dart)\
[Zoom Map example](example/lib/src/controller/zoom.dart)\
[Rotate Map example](example/lib/src/controller/rotate.dart)\
[Find Location example](example/lib/src/controller/locate.dart)

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

[Circle](example/lib/src/circle/simple.dart)\
[Custom Circle](example/lib/src/circle/custom.dart)\
[Multiple Circles](example/lib/src/circle/multi.dart)\
[Multiple Circles with Different Styles](example/lib/src/circle/multistyles.dart)\
[Circle with Data](example/lib/src/circle/data.dart)\
[Multiple Circles with Data](example/lib/src/circle/multidata.dart)

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

[Polyline](example/lib/src/polyline/simple.dart)\
[Custom Polyline](example/lib/src/polyline/custom.dart)\
[Multiple Polylines](example/lib/src/polyline/multi.dart)\
[Multiple Polylines with Different Styles](example/lib/src/polyline/multistyles.dart)

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

[Polygon](example/lib/src/polygon/simple.dart)\
[Custom Polygon](example/lib/src/polygon/custom.dart)\
[Multiple Polygons](example/lib/src/polygon/multi.dart)\
[Multiple Polygons with Diffrent Styles](example/lib/src/polygon/multistyles.dart)\
[Polygon with Data](example/lib/src/polygon/data.dart)\
[Multiple Polygons with Data](example/lib/src/polygon/multidata.dart)

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

[Rectangle](example/lib/src/rectangle/simple.dart)\
[Custom Rectangle](example/lib/src/rectangle/custom.dart)\
[Multiple Rectangles](example/lib/src/rectangle/multi.dart)\
[Multiple Rectangles with Different Styles](example/lib/src/rectangle/multistyles.dart)\
[Rectangle with Data](example/lib/src/rectangle/data.dart)\
[Multiple Rectangles with Data](example/lib/src/rectangle/multidata.dart)

### Image Overlay

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

[Clean Map without Controls](example/lib/src/control/clean.dart)\
[Map with Custom Compass](example/lib/src/control/compass.dart)\
[Map with Custom Locator](example/lib/src/control/locator.dart)\
[Map with Custom Scale Indicator](example/lib/src/control/scale.dart)\
[Map with Custom Location Indicator](example/lib/src/control/location_indicator.dart)

### Custom TileProvider

[NetworkTileProvider](example/lib/src/tile_provider/network.dart)\
[NetworkRetryTileProvider](example/lib/src/tile_provider/retry.dart)\
[CachedNetworkTileProvider](example/lib/src/tile_provider/cached.dart)\
[Offline AssetTileProvider](example/lib/src/tile_provider/asset.dart)

### Geolocator

We can use geolocator to find position latlng from address string.

[Map Geolocator: Center by Address](example/lib/src/geolocator/center.dart)\
[Map Geolocator: Find LatLng by Address](example/lib/src/geolocator/finder.dart)\
[Map Geolocator: Move by Address](example/lib/src/geolocator/move.dart)

### Other Examples 

[Complex Map](example/lib/src/home.dart)

[Map with Initial Rotation](example/lib/src/rotation/initial.dart)\
[Map with Disabled Rotation](example/lib/src/rotation/disable.dart)\
[Map with MaxBounds](example/lib/src/bounds/maxbounds.dart)\
[Map with FitBounds](example/lib/src/bounds/fitbounds.dart)
