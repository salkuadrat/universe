import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'bounds/fitbounds.dart';
import 'bounds/maxbounds.dart';
import 'circle/custom.dart';
import 'circle/data.dart';
import 'circle/multi.dart';
import 'circle/multidata.dart';
import 'circle/multistyles.dart';
import 'circle/simple.dart';
import 'control/compass.dart';
import 'control/location_indicator.dart';
import 'control/locator.dart';
import 'control/scale.dart';
import 'controller/locate.dart';
import 'controller/move.dart';
import 'controller/rotate.dart';
import 'controller/simple.dart';
import 'controller/zoom.dart';
import 'geolocator/center.dart';
import 'geolocator/finder.dart';
import 'geolocator/move.dart';
import 'home.dart';
import 'live/default.dart';
import 'live/marker.dart';
import 'live/simple.dart';
import 'live/notmove.dart';
import 'map_provider/custom.dart';
import 'map_provider/google.dart';
import 'map_provider/mapbox.dart';
import 'map_provider/osm.dart';
import 'map_provider/multi.dart';
import 'map_provider/open.dart';
import 'map_provider/stadia.dart';
import 'map_provider/thunderforest.dart';
import 'map_provider/hydda.dart';
import 'map_provider/jawg.dart';
import 'map_provider/maptiler.dart';
import 'map_provider/stamen.dart';
import 'map_provider/tomtom.dart';
import 'map_provider/cartodb.dart';
import 'map_provider/esri.dart';
import 'map_provider/basemapat.dart';
import 'map_provider/hikebike.dart';
import 'map_provider/nlmaps.dart';
import 'map_provider/onemapsg.dart';
import 'map_provider/justice.dart';
import 'map_provider/nasagibs.dart';
import 'map_provider/usgs.dart';
import 'map_provider/openweather.dart';
import 'map_provider/trails.dart';
import 'map_provider/geoportail.dart';
import 'map_provider/here.dart';
import 'marker/add.dart';
import 'marker/data.dart';
import 'marker/default.dart';
import 'marker/icon.dart';
import 'marker/image.dart';
import 'marker/multi.dart';
import 'marker/multidata.dart';
import 'marker/multistyles.dart';
import 'marker/svg.dart';
import 'marker/widget.dart';
import 'overlay/image.dart';
import 'overlay/video.dart';
import 'overlay/widget.dart';
import 'polygon/data.dart';
import 'polygon/custom.dart';
import 'polygon/multi.dart';
import 'polygon/multidata.dart';
import 'polygon/multistyles.dart';
import 'polygon/simple.dart';
import 'polyline/custom.dart';
import 'polyline/multi.dart';
import 'polyline/multistyles.dart';
import 'polyline/simple.dart';
import 'rectangle/custom.dart';
import 'rectangle/data.dart';
import 'rectangle/multi.dart';
import 'rectangle/multidata.dart';
import 'rectangle/multistyles.dart';
import 'rectangle/simple.dart';
import 'rotation/disable.dart';
import 'rotation/initial.dart';
import 'static/marker.dart';
import 'static/rotate.dart';
import 'static/simple.dart';
import 'tile_provider/asset.dart';
import 'tile_provider/cached.dart';
import 'tile_provider/network.dart';
import 'tile_provider/retry.dart';

// always use your own MapBox access token you get from https://account.mapbox.com/access-tokens/
const String yourAccessTokenHere =
    'pk.eyJ1Ijoic2Fsa3VhZHJhdCIsImEiOiJja2Z0dDgzd2kwbmM0MnRzOHZsaHdwOGV3In0.9Zi_07TPS8zWlhAvyi-3sQ';

class MenuItem {
  final String name;
  final Function map;

  MenuItem(this.name, {required this.map});
}

Map<Key, MenuItem> menus = {
  UniqueKey(): MenuItem('Home', map: () => HomePage()),
  UniqueKey(): MenuItem('MapBox', map: () => MapBox()),
  UniqueKey(): MenuItem('Open Street Map', map: () => OpenStreetMap()),
  UniqueKey(): MenuItem('Google Map', map: () => GoogleMap()),
  UniqueKey(): MenuItem('Custom Map Provider', map: () => CustomMapProvider()),
  UniqueKey(): MenuItem('Muti Layers Map', map: () => MultiLayerMap()),
  //UniqueKey(): MenuItem('Non Geographical Map', map: () => NonGeographicalMap()),
  UniqueKey(): MenuItem('Open Maps', map: () => OpenMap()),
  UniqueKey(): MenuItem('Stadia Map', map: () => StadiaMap()),
  UniqueKey(): MenuItem('Thunderforest Map', map: () => ThunderforestMap()),
  UniqueKey(): MenuItem('Hydda Map', map: () => HyddaMap()),
  UniqueKey(): MenuItem('Jawg Map', map: () => JawgMap()),
  UniqueKey(): MenuItem('Map Tiler', map: () => MapTiler()),
  UniqueKey(): MenuItem('Stamen Map', map: () => StamenMap()),
  UniqueKey(): MenuItem('TomTom Map', map: () => TomTomMap()),
  UniqueKey(): MenuItem('Esri Map', map: () => EsriMap()),
  UniqueKey(): MenuItem('CartoDB Map', map: () => CartoDBMap()),
  UniqueKey(): MenuItem('BasemapAT Map', map: () => BasemapATMap()),
  UniqueKey(): MenuItem('Hike Bike Map', map: () => HikeBikeMap()),
  UniqueKey(): MenuItem('NL Maps', map: () => NLMaps()),
  UniqueKey(): MenuItem('One Map SG', map: () => OneMapSG()),
  UniqueKey(): MenuItem('Justice Map', map: () => JusticeMap()),
  UniqueKey(): MenuItem('NASA GIBS Map', map: () => NASAGIBSMap()),
  UniqueKey(): MenuItem('USGS Map', map: () => USGSMap()),
  UniqueKey(): MenuItem('Open Weather Map', map: () => OpenWeatherMap()),
  UniqueKey():
      MenuItem('Waymarked Trails Map', map: () => WaymarkedTrailsMap()),
  UniqueKey():
      MenuItem('Geoportail France Map', map: () => GeoportailFranceMap()),
  UniqueKey(): MenuItem('HERE Map', map: () => HereMap()),
  UniqueKey(): MenuItem('Static Map', map: () => StaticMap()),
  UniqueKey():
      MenuItem('Static Map with Marker', map: () => StaticMapWithMarker()),
  UniqueKey():
      MenuItem('Static Map with Rotation', map: () => RotateStaticMap()),
  UniqueKey():
      MenuItem('Map with Initial Rotation', map: () => InitialRotationMap()),
  UniqueKey():
      MenuItem('Map with Disable Rotation', map: () => DisableRotationMap()),
  UniqueKey(): MenuItem('Map with MaxBounds', map: () => MaxBoundsMap()),
  UniqueKey(): MenuItem('Map with FitBounds', map: () => FitBoundsMap()),
  UniqueKey(): MenuItem('Marker', map: () => DefaultMarkerMap()),
  UniqueKey(): MenuItem('Marker with Data', map: () => MarkerWithDataMap()),
  UniqueKey(): MenuItem('Multiple Marker', map: () => MultiMarkerMap()),
  UniqueKey(): MenuItem('Multiple Marker with Different Styles',
      map: () => MultiMarkerStylesMap()),
  UniqueKey(): MenuItem('Multiple Marker with Data',
      map: () => MultiMarkerWithDataMap()),
  UniqueKey(): MenuItem('Marker Icon', map: () => MarkerIconMap()),
  UniqueKey(): MenuItem('Marker Image', map: () => MarkerImageMap()),
  UniqueKey(): MenuItem('Marker Svg', map: () => MarkerSvgMap()),
  UniqueKey(): MenuItem('Marker Widget', map: () => MarkerWidgetMap()),
  UniqueKey(): MenuItem('Tap to Add Marker', map: () => AddMarkerMap()),
  UniqueKey(): MenuItem('MapController', map: () => ControllerMap()),
  UniqueKey(): MenuItem('MapController: Move', map: () => MoveControllerMap()),
  UniqueKey(): MenuItem('MapController: Zoom', map: () => ZoomControllerMap()),
  UniqueKey():
      MenuItem('MapController: Rotate', map: () => RotateControllerMap()),
  UniqueKey(): MenuItem('MapController: Find Location',
      map: () => LocateControllerMap()),
  UniqueKey(): MenuItem('Circle', map: () => CircleMap()),
  UniqueKey(): MenuItem('Custom Circle', map: () => CustomCircleMap()),
  UniqueKey(): MenuItem('Multiple Circles', map: () => MultiCircleMap()),
  UniqueKey(): MenuItem('Multiple Circles with Different Styles',
      map: () => MultiCircleStylesMap()),
  UniqueKey(): MenuItem('Circle with Data', map: () => CircleWithDataMap()),
  UniqueKey(): MenuItem('Multiple Circles with Data',
      map: () => MultiCircleWithDataMap()),
  UniqueKey(): MenuItem('Polyline', map: () => PolylineMap()),
  UniqueKey(): MenuItem('Custom Polyline', map: () => CustomPolylineMap()),
  UniqueKey(): MenuItem('Multiple Polylines', map: () => MultiPolylineMap()),
  UniqueKey(): MenuItem('Multiple Polylines with Different Styles',
      map: () => MultiPolylineStylesMap()),
  UniqueKey(): MenuItem('Polygon', map: () => PolygonMap()),
  UniqueKey(): MenuItem('Custom Polygon', map: () => CustomPolygonMap()),
  UniqueKey(): MenuItem('Multiple Polygons', map: () => MultiPolygonMap()),
  UniqueKey(): MenuItem('Multiple Polygons with Different Styles',
      map: () => MultiPolygonStylesMap()),
  UniqueKey(): MenuItem('Polygon with Data', map: () => PolygonWithDataMap()),
  UniqueKey(): MenuItem('Multiple Polygons with Data',
      map: () => MultiPolygonWithDataMap()),
  UniqueKey(): MenuItem('Rectangle', map: () => RectangleMap()),
  UniqueKey(): MenuItem('Custom Rectangle', map: () => CustomRectangleMap()),
  UniqueKey(): MenuItem('Multiple Rectangles', map: () => MultiRectangleMap()),
  UniqueKey(): MenuItem('Multiple Rectangles with Different Styles',
      map: () => MultiRectangleStylesMap()),
  UniqueKey():
      MenuItem('Rectangle with Data', map: () => RectangleWithDataMap()),
  UniqueKey(): MenuItem('Multiple Rectangles with Data',
      map: () => MultiRectangleWithDataMap()),
  UniqueKey(): MenuItem('TileProvider: NetworkTileProvider',
      map: () => NetworkTileMap()),
  UniqueKey(): MenuItem('TileProvider: NetworkRetryTileProvider',
      map: () => NetworkRetryTileMap()),
  UniqueKey(): MenuItem('TileProvider: CachedNetworkTileProvider',
      map: () => CachedNetworkTileMap()),
  UniqueKey(): MenuItem('TileProvider: Offline AssetTileProvider',
      map: () => AssetTileMap()),
  UniqueKey(): MenuItem('Live Map', map: () => LiveMap()),
  UniqueKey(): MenuItem('Simple Live Map', map: () => SimpleLiveMap()),
  UniqueKey(): MenuItem('Live Map with Marker', map: () => LiveMapWithMarker()),
  UniqueKey(): MenuItem('Live Map without Automoving',
      map: () => LiveMapWithoutAutoMoving()),
  UniqueKey(): MenuItem('Custom Compass', map: () => CustomCompassMap()),
  UniqueKey(): MenuItem('Custom Locator', map: () => CustomLocatorMap()),
  UniqueKey(): MenuItem('Custom Scale Indicator', map: () => CustomScaleMap()),
  UniqueKey(): MenuItem('Custom Location Indicator',
      map: () => CustomLocationIndicatorMap()),
  UniqueKey(): MenuItem('Geolocator: Center Map', map: () => GeolocatorMap()),
  UniqueKey(): MenuItem('Geolocator: Find LatLng Location',
      map: () => LocationFinderMap()),
  UniqueKey(): MenuItem('Geolocator: Move Map', map: () => MoveGeolocatorMap()),
  UniqueKey(): MenuItem('Image Overlay', map: () => ImageOverlayMap()),
  UniqueKey(): MenuItem('Widget Overlay', map: () => WidgetOverlayMap()),
  UniqueKey(): MenuItem('Video Overlay', map: () => VideoOverlayMap()),
};
