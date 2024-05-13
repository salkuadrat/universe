import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'bounds/fitbounds.dart';
import 'bounds/maxbounds.dart';
import 'circle/custom.dart';
import 'circle/data.dart';
import 'circle/multi.dart';
import 'circle/multidata.dart';
import 'circle/multistyles.dart';
import 'circle/simple.dart';
import 'control/clean.dart';
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
import 'live/stream.dart';
import 'map_provider/custom.dart';
import 'map_provider/cyclosm.dart';
import 'map_provider/google.dart';
import 'map_provider/mapbox.dart';
import 'map_provider/nlsmap.dart';
import 'map_provider/osm.dart';
import 'map_provider/multi.dart';
import 'map_provider/open.dart';
import 'map_provider/safecast.dart';
import 'map_provider/stadia.dart';
import 'map_provider/thunderforest.dart';
import 'map_provider/jawg.dart';
import 'map_provider/maptiler.dart';
import 'map_provider/stamen.dart';
import 'map_provider/tomtom.dart';
import 'map_provider/cartodb.dart';
import 'map_provider/esri.dart';
import 'map_provider/basemapat.dart';
import 'map_provider/hikebike.dart';
import 'map_provider/nlmaps.dart';
import 'map_provider/nasagibs.dart';
import 'map_provider/usgs.dart';
import 'map_provider/openweather.dart';
import 'map_provider/trails.dart';
import 'map_provider/geoportail.dart';
import 'map_provider/here.dart';
import 'map_provider/wikimedia.dart';
import 'map_provider/wms.dart';
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
  UniqueKey(): MenuItem('Home', map: () => const HomePage()),
  UniqueKey(): MenuItem('MapBox', map: () => const MapBox()),
  UniqueKey(): MenuItem('Open Street Map', map: () => const OpenStreetMap()),
  UniqueKey(): MenuItem('Google Map', map: () => const GoogleMap()),
  UniqueKey():
      MenuItem('Custom Map Provider', map: () => const CustomMapProvider()),
  UniqueKey(): MenuItem('Muti Layers Map', map: () => const MultiLayerMap()),
  //UniqueKey(): MenuItem('Non Geographical Map', map: () => NonGeographicalMap()),
  UniqueKey(): MenuItem('Open Maps', map: () => const OpenMap()),
  UniqueKey(): MenuItem('SafeCast Map', map: () => const SafeCastMap()),
  UniqueKey(): MenuItem('CyclOSM Map', map: () => const CyclOSMMap()),
  UniqueKey(): MenuItem('Stadia Map', map: () => const StadiaMap()),
  UniqueKey():
      MenuItem('Thunderforest Map', map: () => const ThunderforestMap()),
  UniqueKey(): MenuItem('Jawg Map', map: () => const JawgMap()),
  UniqueKey(): MenuItem('Map Tiler', map: () => const MapTiler()),
  UniqueKey(): MenuItem('Stamen Map', map: () => const StamenMap()),
  UniqueKey(): MenuItem('TomTom Map', map: () => const TomTomMap()),
  UniqueKey(): MenuItem('Esri Map', map: () => const EsriMap()),
  UniqueKey(): MenuItem('CartoDB Map', map: () => const CartoDBMap()),
  UniqueKey(): MenuItem('BasemapAT Map', map: () => const BasemapATMap()),
  UniqueKey(): MenuItem('Hike Bike Map', map: () => const HikeBikeMap()),
  UniqueKey(): MenuItem('NL Maps', map: () => const NLMaps()),
  UniqueKey(): MenuItem('NLS Map', map: () => const NLSMap()),
  UniqueKey(): MenuItem('NASA GIBS Map', map: () => const NASAGIBSMap()),
  UniqueKey(): MenuItem('USGS Map', map: () => const USGSMap()),
  UniqueKey(): MenuItem('Open Weather Map', map: () => const OpenWeatherMap()),
  UniqueKey():
      MenuItem('Waymarked Trails Map', map: () => const WaymarkedTrailsMap()),
  UniqueKey():
      MenuItem('Geoportail France Map', map: () => const GeoportailFranceMap()),
  UniqueKey(): MenuItem('Wikimedia Map', map: () => const WikimediaMap()),
  UniqueKey(): MenuItem('HERE Map', map: () => const HereMap()),
  UniqueKey(): MenuItem('WMS Map', map: () => const WmsMap()),
  UniqueKey(): MenuItem('Static Map', map: () => const StaticMap()),
  UniqueKey(): MenuItem('Static Map with Marker',
      map: () => const StaticMapWithMarker()),
  UniqueKey():
      MenuItem('Static Map with Rotation', map: () => const RotateStaticMap()),
  UniqueKey(): MenuItem('Map with Initial Rotation',
      map: () => const InitialRotationMap()),
  UniqueKey(): MenuItem('Map with Disable Rotation',
      map: () => const DisableRotationMap()),
  UniqueKey(): MenuItem('Map with MaxBounds', map: () => const MaxBoundsMap()),
  UniqueKey(): MenuItem('Map with FitBounds', map: () => const FitBoundsMap()),
  UniqueKey(): MenuItem('Marker', map: () => const DefaultMarkerMap()),
  UniqueKey():
      MenuItem('Marker with Data', map: () => const MarkerWithDataMap()),
  UniqueKey(): MenuItem('Multiple Marker', map: () => const MultiMarkerMap()),
  UniqueKey(): MenuItem('Multiple Marker with Different Styles',
      map: () => const MultiMarkerStylesMap()),
  UniqueKey(): MenuItem('Multiple Marker with Data',
      map: () => const MultiMarkerWithDataMap()),
  UniqueKey(): MenuItem('Marker Icon', map: () => const MarkerIconMap()),
  UniqueKey(): MenuItem('Marker Image', map: () => const MarkerImageMap()),
  UniqueKey(): MenuItem('Marker Svg', map: () => const MarkerSvgMap()),
  UniqueKey(): MenuItem('Marker Widget', map: () => const MarkerWidgetMap()),
  UniqueKey(): MenuItem('Tap to Add Marker', map: () => const AddMarkerMap()),
  UniqueKey(): MenuItem('MapController', map: () => const ControllerMap()),
  UniqueKey():
      MenuItem('MapController: Move', map: () => const MoveControllerMap()),
  UniqueKey():
      MenuItem('MapController: Zoom', map: () => const ZoomControllerMap()),
  UniqueKey():
      MenuItem('MapController: Rotate', map: () => const RotateControllerMap()),
  UniqueKey(): MenuItem('MapController: Find Location',
      map: () => const LocateControllerMap()),
  UniqueKey(): MenuItem('Circle', map: () => const CircleMap()),
  UniqueKey(): MenuItem('Custom Circle', map: () => const CustomCircleMap()),
  UniqueKey(): MenuItem('Multiple Circles', map: () => const MultiCircleMap()),
  UniqueKey(): MenuItem('Multiple Circles with Different Styles',
      map: () => const MultiCircleStylesMap()),
  UniqueKey():
      MenuItem('Circle with Data', map: () => const CircleWithDataMap()),
  UniqueKey(): MenuItem('Multiple Circles with Data',
      map: () => const MultiCircleWithDataMap()),
  UniqueKey(): MenuItem('Polyline', map: () => const PolylineMap()),
  UniqueKey():
      MenuItem('Custom Polyline', map: () => const CustomPolylineMap()),
  UniqueKey():
      MenuItem('Multiple Polylines', map: () => const MultiPolylineMap()),
  UniqueKey(): MenuItem('Multiple Polylines with Different Styles',
      map: () => const MultiPolylineStylesMap()),
  UniqueKey(): MenuItem('Polygon', map: () => const PolygonMap()),
  UniqueKey(): MenuItem('Custom Polygon', map: () => const CustomPolygonMap()),
  UniqueKey():
      MenuItem('Multiple Polygons', map: () => const MultiPolygonMap()),
  UniqueKey(): MenuItem('Multiple Polygons with Different Styles',
      map: () => const MultiPolygonStylesMap()),
  UniqueKey():
      MenuItem('Polygon with Data', map: () => const PolygonWithDataMap()),
  UniqueKey(): MenuItem('Multiple Polygons with Data',
      map: () => const MultiPolygonWithDataMap()),
  UniqueKey(): MenuItem('Rectangle', map: () => const RectangleMap()),
  UniqueKey():
      MenuItem('Custom Rectangle', map: () => const CustomRectangleMap()),
  UniqueKey():
      MenuItem('Multiple Rectangles', map: () => const MultiRectangleMap()),
  UniqueKey(): MenuItem('Multiple Rectangles with Different Styles',
      map: () => const MultiRectangleStylesMap()),
  UniqueKey():
      MenuItem('Rectangle with Data', map: () => const RectangleWithDataMap()),
  UniqueKey(): MenuItem('Multiple Rectangles with Data',
      map: () => const MultiRectangleWithDataMap()),
  UniqueKey(): MenuItem('TileProvider: NetworkTileProvider',
      map: () => const NetworkTileMap()),
  UniqueKey(): MenuItem('TileProvider: NetworkRetryTileProvider',
      map: () => const NetworkRetryTileMap()),
  UniqueKey(): MenuItem('TileProvider: CachedNetworkTileProvider',
      map: () => const CachedNetworkTileMap()),
  UniqueKey(): MenuItem('TileProvider: Offline AssetTileProvider',
      map: () => const AssetTileMap()),
  UniqueKey(): MenuItem('Live Map', map: () => const LiveMap()),
  UniqueKey(): MenuItem('Simple Live Map', map: () => const SimpleLiveMap()),
  UniqueKey():
      MenuItem('Live Map with Marker', map: () => const LiveMapWithMarker()),
  UniqueKey(): MenuItem('Live Map without Automoving',
      map: () => const LiveMapWithoutAutoMoving()),
  UniqueKey(): MenuItem('Live Stream Map', map: () => const LiveStreamMap()),
  UniqueKey():
      MenuItem('Clean Map Without Controls', map: () => const CleanMap()),
  UniqueKey(): MenuItem('Custom Compass', map: () => const CustomCompassMap()),
  UniqueKey(): MenuItem('Custom Locator', map: () => const CustomLocatorMap()),
  UniqueKey():
      MenuItem('Custom Scale Indicator', map: () => const CustomScaleMap()),
  UniqueKey(): MenuItem('Custom Location Indicator',
      map: () => const CustomLocationIndicatorMap()),
  UniqueKey():
      MenuItem('Geolocator: Center Map', map: () => const GeolocatorMap()),
  UniqueKey(): MenuItem('Geolocator: Find LatLng Location',
      map: () => const LocationFinderMap()),
  UniqueKey():
      MenuItem('Geolocator: Move Map', map: () => const MoveGeolocatorMap()),
  UniqueKey(): MenuItem('Image Overlay', map: () => const ImageOverlayMap()),
  UniqueKey(): MenuItem('Widget Overlay', map: () => const WidgetOverlayMap()),
  UniqueKey(): MenuItem('Video Overlay', map: () => const VideoOverlayMap()),
};
