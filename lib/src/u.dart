// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import 'control/control.dart';
import 'core/core.dart';
import 'layer/layer.dart' as L;
import 'map/controller/controller.dart' as C;
import 'map/map.dart';
import 'shared.dart';
import 'tiles/basemapat.dart';
import 'tiles/cartodb.dart';
import 'tiles/cyclosm.dart';
import 'tiles/esri.dart';
import 'tiles/geoportail.dart';
import 'tiles/goole.dart';
import 'tiles/here.dart';
import 'tiles/herev3.dart';
import 'tiles/hikebike.dart';
import 'tiles/jawg.dart';
import 'tiles/mapbox.dart';
import 'tiles/maptiler.dart';
import 'tiles/mtbmap.dart';
import 'tiles/nasagibs.dart';
import 'tiles/nlmaps.dart';
import 'tiles/nls.dart';
import 'tiles/open.dart';
import 'tiles/openweather.dart';
import 'tiles/osm.dart';
import 'tiles/safecast.dart';
import 'tiles/stadia.dart';
import 'tiles/stamen.dart';
import 'tiles/thunderforest.dart';
import 'tiles/tomtom.dart';
import 'tiles/usgs.dart';
import 'tiles/waymarkedtrails.dart';
import 'tiles/wikimedia.dart';
import 'type.dart';

/// The easy & flexible way to use interactive maps in Flutter.
///
/// U class is the starting point of universe.
///
class U {
  // ignore: non_constant_identifier_names
  static C.MapController MapController() => C.MapController();

  /// The central point of Universe API.
  /// It is used to create and manipulate a map on the screen.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe Map({
    Key? key,
    required dynamic center,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? zoomDelta,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? showCenterMarker,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? live,
    bool? moveWhenLive,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Image? locatorImage,
    Alignment? locatorAlignment,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    MapOptions options = MapOptions(
      crs: crs ?? CRS.EPSG3857,
      size: size,
      center: center,
      zoomOptions: ZoomOptions(
        zoom: zoom ?? zoomDef,
        minZoom: minZoom ?? minZoomDef,
        maxZoom: maxZoom ?? maxZoomDef,
        zoomDelta: zoomDelta ?? zoomDeltaDef,
      ),
      rotation: rotation ?? rotationDef,
      disableRotation: disableRotation ?? disableRotationDef,
      showCenterMarker: showCenterMarker ?? showCenterMarkerDef,
      centerMarker: centerMarker ?? markerDef,
      centerMarkerSize: centerMarkerSize ?? markerSizeDef,
      locationMarker: locationMarker ?? markerDef,
      locationMarkerSize: locationMarkerSize ?? markerSizeDef,
      live: live ?? liveDef,
      moveWhenLive: moveWhenLive ?? moveWhenLiveDef,
      locator: locator ?? const Locator(),
      showLocator: showLocator ?? showLocatorDef,
      locationIndicator: locationIndicator ?? const L.LocationIndicator(),
      showLocationIndicator: showLocationIndicator ??
          showLocator ??
          live ??
          showLocationIndicatorDef,
      showLocationMarker: showLocationMarker ?? showLocationMarkerDef,
      compass: compass ?? const Compass(),
      showCompass: showCompass ?? showCompassDef,
      showScale: showScale ?? showScaleDef,
      scale: scale ?? Scale(),
      interactive: interactive ?? interactiveDef,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions ?? const FitBoundsOptions(),
      slideOnBoundaries: slideOnBoundaries ?? slideOnBoundariesDef,
      adaptiveBoundaries: adaptiveBoundaries ?? adaptiveBoundariesDef,
      hideAttribution: hideAttribution ?? hideAttributionDef,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
    );

    return Universe(
      key: key ?? UniqueKey(),
      controller: controller,
      options: options,
      background: background ?? const Color(0xFFDEDEDE),
      base: base,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
    );
  }

  /// Used to display map with base TileLayer from GoogleMap servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.GoogleMap(
  ///   type: GoogleMapType.Hybrid,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: type
  ///
  /// enum to define the type of GoogleMap tiles to load.
  /// Default value: [GoogleMapType.Street].
  ///
  /// Available values:
  /// [GoogleMapType.Street]
  /// [GoogleMapType.Satellite]
  /// [GoogleMapType.Hybrid]
  /// [GoogleMapType.Terrain]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.GoogleMap(
  ///   type: GoogleMapType.Hybrid,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.GoogleMap(
  ///   type: GoogleMapType.Hybrid,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.GoogleMap(
  ///   type: GoogleMapType.Hybrid,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe GoogleMap({
    Key? key,
    required dynamic center,
    GoogleMapType type = GoogleMapType.Street,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    if (type == GoogleMapType.Satellite || type == GoogleMapType.Hybrid) {
      background ??= const Color(0xFF888888);
    } else {
      background ??= const Color(0xFFDEDEDE);
    }

    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: GoogleMapTileLayer(type: type, options: options),
    );
  }

  /// Used to display map with base TileLayer from MapBox.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MapBox(
  ///   type: MapBoxType.Street,
  ///   accessToken: putYourAccessTokenHere,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of MapBox tiles to load.
  /// Default value: [MapBoxType.Street].
  ///
  /// Available values:
  /// [MapBoxType.Basic]
  /// [MapBoxType.Street]
  /// [MapBoxType.Satellite]
  /// [MapBoxType.Hybrid]
  /// [MapBoxType.Outdoors]
  /// [MapBoxType.Dark]
  /// [MapBoxType.Light]
  /// [MapBoxType.Bright]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.MapBox(
  ///   type: MapBoxType.Street,
  ///   accessToken: putYourAccessTokenHere,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.MapBox(
  ///   type: MapBoxType.Street,
  ///   accessToken: putYourAccessTokenHere,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.MapBox(
  ///   type: MapBoxType.Street,
  ///   accessToken: putYourAccessTokenHere,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe MapBox({
    Key? key,
    MapBoxType type = MapBoxType.Street,
    required String accessToken,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    if (type == MapBoxType.Dark) {
      background ??= const Color(0xFF555555);
    } else if (type == MapBoxType.Satellite || type == MapBoxType.Hybrid) {
      background ??= const Color(0xFF888888);
    } else {
      background ??= const Color(0xFFDEDEDE);
    }

    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: MapBoxTileLayer(type: type, accessToken: accessToken),
    );
  }

  /// Used to display map with base TileLayer from OpenStreetMap.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.OpenStreetMap(
  ///   type: OpenStreetMapType.HOT,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of OpenStreetMap tiles to load.
  /// Default value: [OpenStreetMapType.HOT]
  ///
  /// Available values:
  /// [OpenStreetMapType.Mapnik]
  /// [OpenStreetMapType.DE]
  /// [OpenStreetMapType.CH]
  /// [OpenStreetMapType.France]
  /// [OpenStreetMapType.HOT]
  /// [OpenStreetMapType.BZH]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.OpenStreetMap(
  ///   type: OpenStreetMapType.HOT,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.OpenStreetMap(
  ///   type: OpenStreetMapType.HOT,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.OpenStreetMap(
  ///   type: OpenStreetMapType.HOT,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe OpenStreetMap({
    Key? key,
    required dynamic center,
    OpenStreetMapType type = OpenStreetMapType.HOT,
    String apikey = '',
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: OpenStreetMapLayer(
        type: type,
        options: options,
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with base TileLayer from SafeCast.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.SafeCastMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.SafeCastMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.SafeCastMap(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.SafeCastMap(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  /* static Universe SafeCastMap({
    Key? key,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: SafeCastTileLayer(options: options ?? L.TileLayerOptions()),
    );
  } */

  /// Used to display map with base TileLayer from CyclOSM.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.CyclOSMMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.CyclOSMMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.CyclOSMMap(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.CyclOSMMap(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe CyclOSMMap({
    Key? key,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: CyclOSMTileLayer(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to display map with base TileLayer from MtbMap.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MtbMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.MtbMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.MtbMap(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.MtbMap(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe MtbMap({
    Key? key,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: MtbMapTileLayer(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to display map with base TileLayer from NLS Map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.NLSMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.NLSMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.NLSMap(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.NLSMap(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe NLSMap({
    Key? key,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: NLSTileLayer(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to display map with base TileLayer from Wikimedia.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.WikimediaMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.WikimediaMap(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.WikimediaMap(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.WikimediaMap(
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe WikimediaMap({
    Key? key,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: WikimediaTileLayer(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to display map with base TileLayer from Open Map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.OpenMap(
  ///   type: OpenType.OpenSeaMap,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Open Map tiles to load.
  ///
  /// Available values:
  /// [OpenType.OpenSeaMap]
  /// [OpenType.OpenPtMap]
  /// [OpenType.OpenTopoMap]
  /// [OpenType.OpenRailwayMap]
  /// [OpenType.OpenFireMap]
  /// [OpenType.OpenSnowMap]
  /// [OpenType.OpenAIP]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.OpenMap(
  ///   type: OpenType.OpenSeaMap,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.OpenMap(
  ///   type: OpenType.OpenSeaMap,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.OpenMap(
  ///   type: OpenType.OpenSeaMap,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  /* static Universe OpenMap({
    Key? key,
    required OpenType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: OpenTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  } */

  /// Used to display map with base TileLayer from Stadia.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.StadiaMap(
  ///   type: StadiaType.AlidadeSmooth,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Stadia Map tiles to load.
  ///
  /// Available values:
  /// [StadiaType.AlidadeSmooth]
  /// [StadiaType.AlidadeSmoothDark]
  /// [StadiaType.OSMBright]
  /// [StadiaType.OSMOutdoors]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.StadiaMap(
  ///   type: StadiaType.AlidadeSmooth,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.StadiaMap(
  ///   type: StadiaType.AlidadeSmooth,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.StadiaMap(
  ///   type: StadiaType.AlidadeSmooth,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe StadiaMap({
    Key? key,
    required StadiaType type,
    required String apikey,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: StadiaTileLayer(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from Thunderforest.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.ThunderforestMap(
  ///   type: ThunderforestType.Outdoors,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Thunderforest Map tiles to load.
  ///
  /// Available values:
  /// [ThunderforestType.Cycle]
  /// [ThunderforestType.Transport]
  /// [ThunderforestType.TransportDark]
  /// [ThunderforestType.Spinal]
  /// [ThunderforestType.Landscape]
  /// [ThunderforestType.Outdoors]
  /// [ThunderforestType.Pioneer]
  /// [ThunderforestType.MobileAtlas]
  /// [ThunderforestType.Neighbourhood]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.ThunderforestMap(
  ///   type: ThunderforestType.Outdoors,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.ThunderforestMap(
  ///   type: ThunderforestType.Outdoors,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.ThunderforestMap(
  ///   type: ThunderforestType.Outdoors,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe ThunderforestMap({
    Key? key,
    required ThunderforestType type,
    required String apikey,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: ThunderforestTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with base TileLayer from Jawg Map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.JawgMap(
  ///   type: JawgType.Streets,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Jawg Map tiles to load.
  ///
  /// Available values:
  /// [JawgType.Streets]
  /// [JawgType.Terrain]
  /// [JawgType.Sunny]
  /// [JawgType.Dark]
  /// [JawgType.Light]
  /// [JawgType.Matrix]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.JawgMap(
  ///   type: JawgType.Streets,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.JawgMap(
  ///   type: JawgType.Streets,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.JawgMap(
  ///   type: JawgType.Streets,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe JawgMap({
    Key? key,
    required JawgType type,
    required String accessToken,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: JawgTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        accessToken: accessToken,
      ),
    );
  }

  /// Used to display map with base TileLayer from MapTiler.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MapTiler(
  ///   type: MapTilerType.Streets,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of MapTiler tiles to load.
  ///
  /// Available values:
  /// [MapTilerType.Default]
  /// [MapTilerType.Streets]
  /// [MapTilerType.Basic]
  /// [MapTilerType.Bright]
  /// [MapTilerType.Pastel]
  /// [MapTilerType.Positron]
  /// [MapTilerType.Hybrid]
  /// [MapTilerType.Toner]
  /// [MapTilerType.Topo]
  /// [MapTilerType.Voyager]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.MapTiler(
  ///   type: MapTilerType.Streets,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.MapTiler(
  ///   type: MapTilerType.Streets,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.MapTiler(
  ///   type: MapTilerType.Streets,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe MapTiler({
    Key? key,
    MapTilerType type = MapTilerType.Default,
    required String apikey,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: MapTilerTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with base TileLayer from TomTom Map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.TomTomMap(
  ///   type: TomTomType.Hybrid,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of TomTom Map tiles to load.
  ///
  /// Available values:
  /// [TomTomType.Basic]
  /// [TomTomType.Hybrid]
  /// [TomTomType.Labels]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.TomTomMap(
  ///   type: TomTomType.Hybrid,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.TomTomMap(
  ///   type: TomTomType.Hybrid,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.TomTomMap(
  ///   type: TomTomType.Hybrid,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe TomTomMap({
    Key? key,
    required TomTomType type,
    required String apikey,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: TomTomTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with base TileLayer from Esri.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.EsriMap(
  ///   type: EsriType.WorldStreetMap,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Esri Map tiles to load.
  ///
  /// Available values:
  /// [EsriType.WorldStreetMap]
  /// [EsriType.WorldImagery]
  /// [EsriType.WorldTopoMap]
  /// [EsriType.WorldTerrain]
  /// [EsriType.WorldShadedRelief]
  /// [EsriType.WorldPhysical]
  /// [EsriType.WorldGray]
  /// [EsriType.DeLorme]
  /// [EsriType.OceanBasemap]
  /// [EsriType.NatGeoWorldMap]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.EsriMap(
  ///   type: EsriType.WorldStreetMap,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.EsriMap(
  ///   type: EsriType.WorldStreetMap,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.EsriMap(
  ///   type: EsriType.WorldStreetMap,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe EsriMap({
    Key? key,
    required EsriType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: EsriTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from CartoDB.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.CartoDBMap(
  ///   type: CartoDBType.Positron,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of CartoDB Map tiles to load.
  ///
  /// Available values:
  /// [CartoDBType.Positron]
  /// [CartoDBType.PositronNoLabels]
  /// [CartoDBType.PositronOnlyLabels]
  /// [CartoDBType.DarkMatter]
  /// [CartoDBType.DarkMatterNoLabels]
  /// [CartoDBType.DarkMatterOnlyLabels]
  /// [CartoDBType.Voyager]
  /// [CartoDBType.VoyagerNoLabels]
  /// [CartoDBType.VoyagerOnlyLabels]
  /// [CartoDBType.VoyagerLabelsUnder]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.CartoDBMap(
  ///   type: CartoDBType.Positron,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.CartoDBMap(
  ///   type: CartoDBType.Positron,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.CartoDBMap(
  ///   type: CartoDBType.Positron,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe CartoDBMap({
    Key? key,
    required CartoDBType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: CartoDBTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from BasemapAT.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.BasemapATMap(
  ///   type: BasemapATType.Terrain,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of BasemapAT Map tiles to load.
  ///
  /// Available values:
  /// [BasemapATType.Default]
  /// [BasemapATType.Grau]
  /// [BasemapATType.Overlay]
  /// [BasemapATType.Terrain]
  /// [BasemapATType.Surface]
  /// [BasemapATType.Hdpi]
  /// [BasemapATType.Orthofoto]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.BasemapATMap(
  ///   type: BasemapATType.Terrain,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.BasemapATMap(
  ///   type: BasemapATType.Terrain,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.BasemapATMap(
  ///   type: BasemapATType.Terrain,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe BasemapATMap({
    Key? key,
    BasemapATType type = BasemapATType.Default,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: BasemapATTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from NLMaps.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.NLMaps(
  ///   type: NLMapsType.Pastel,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of NLMaps tiles to load.
  ///
  /// Available values:
  /// [NLMapsType.Default]
  /// [NLMapsType.Pastel]
  /// [NLMapsType.Grijs]
  /// [NLMapsType.Luchtfoto]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.NLMaps(
  ///   type: NLMapsType.Pastel,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.NLMaps(
  ///   type: NLMapsType.Pastel,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.NLMaps(
  ///   type: NLMapsType.Pastel,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe NLMaps({
    Key? key,
    NLMapsType type = NLMapsType.Default,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: NLMapsTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from Geoportail France.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.GeoportailFranceMap(
  ///   type: GeoportailFranceType.Hybrid,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Geoportail
  /// France Map tiles to load.
  ///
  /// Available values:
  /// [GeoportailFranceType.Plan]
  /// [GeoportailFranceType.Parcels]
  /// [GeoportailFranceType.Orthos]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.GeoportailFranceMap(
  ///   type: GeoportailFranceType.Plan,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.GeoportailFranceMap(
  ///   type: GeoportailFranceType.Plan,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.GeoportailFranceMap(
  ///   type: GeoportailFranceType.Plan,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe GeoportailFranceMap({
    Key? key,
    required GeoportailFranceType type,
    required String apikey,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: GeoportailFranceTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with base TileLayer from USGS.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.USGSMap(
  ///   type: USGSType.ImageryTopo,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of USGS Map tiles to load.
  ///
  /// Available values:
  /// [USGSType.Topo]
  /// [USGSType.Imagery]
  /// [USGSType.ImageryTopo]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.USGSMap(
  ///   type: USGSType.ImageryTopo,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.USGSMap(
  ///   type: USGSType.ImageryTopo,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.USGSMap(
  ///   type: USGSType.ImageryTopo,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe USGSMap({
    Key? key,
    required USGSType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: USGSTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from Waymarked Trails.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.WaymarkedTrailsMap(
  ///   type: WaymarkedTrailsType.Cycling,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Waymarked Trails Map tiles to load.
  ///
  /// Available values:
  /// [WaymarkedTrailsType.Hiking]
  /// [WaymarkedTrailsType.Cycling]
  /// [WaymarkedTrailsType.MTB]
  /// [WaymarkedTrailsType.Slopes]
  /// [WaymarkedTrailsType.Riding]
  /// [WaymarkedTrailsType.Skating]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.WaymarkedTrailsMap(
  ///   type: WaymarkedTrailsType.Cycling,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.WaymarkedTrailsMap(
  ///   type: WaymarkedTrailsType.Cycling,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.WaymarkedTrailsMap(
  ///   type: WaymarkedTrailsType.Cycling,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe WaymarkedTrailsMap({
    Key? key,
    required WaymarkedTrailsType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: WaymarkedTrailsTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display map with base TileLayer from HERE Map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.HereMap(
  ///   appId: '',
  ///   appCode: '',
  ///   type: HereType.NormalDay,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of HERE Map tiles to load.
  ///
  /// Available values:
  /// [HereType.NormalDay]
  /// [HereType.NormalDayCustom]
  /// [HereType.NormalDayGrey]
  /// [HereType.NormalDayMobile]
  /// [HereType.NormalDayGreyMobile]
  /// [HereType.NormalDayTransit]
  /// [HereType.NormalDayTransitMobile]
  /// [HereType.NormalDayTraffic]
  /// [HereType.NormalNight]
  /// [HereType.NormalNightMobile]
  /// [HereType.NormalNightGrey]
  /// [HereType.NormalNightGreyMobile]
  /// [HereType.NormalNightTransit]
  /// [HereType.NormalNightTransitMobile]
  /// [HereType.ReducedDay]
  /// [HereType.ReducedNight]
  /// [HereType.BasicMap]
  /// [HereType.MapLabels]
  /// [HereType.TrafficFlow]
  /// [HereType.CarnavDayGrey]
  /// [HereType.HybridDay]
  /// [HereType.HybridDayMobile]
  /// [HereType.HybridDayTransit]
  /// [HereType.HybridDayGrey]
  /// [HereType.HybridDayTraffic]
  /// [HereType.PedestrianDay]
  /// [HereType.PedestrianNight]
  /// [HereType.SatelliteDay]
  /// [HereType.TerrainDay]
  /// [HereType.TerrainDayMobile]
  ///
  /// @param: [center]
  ///
  /// Used to define center latlng position of the map.
  /// It can accept many types of value:
  ///
  /// A list of two (or three) values
  /// that represents latitude and longitude (and altitude).
  ///
  /// ```dart
  /// U.HereMap(
  ///   appId: '',
  ///   appCode: '',
  ///   type: HereType.NormalDay,
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or an instance of LatLng object:
  ///
  /// ```dart
  /// U.HereMap(
  ///   appId: '',
  ///   appCode: '',
  ///   type: HereType.NormalDay,
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or location name.
  ///
  /// The built-in GeoCoder inside will automatically
  /// convert it to latlng position for you.
  ///
  /// Default to LatLng(0.0, 0.0) if your location is not found.
  ///
  /// ```dart
  /// U.HereMap(
  ///   appId: '',
  ///   appCode: '',
  ///   type: HereType.NormalDay,
  ///   controller: MapController(),
  ///   center: 'Emirates Stadium',
  ///   zoom: 15,
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static Universe HereMap({
    Key? key,
    required String appId,
    required String appCode,
    String version = 'v3',
    required HereType type,
    required dynamic center,
    L.TileLayerOptions? options,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? disableRotation,
    Color? background,
    C.MapController? controller,
    L.TileLayer? base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.TileLayer> tiles = const [],
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? live,
    bool? moveWhenLive,
    dynamic centerMarker,
    dynamic locationMarker,
    num? centerMarkerSize,
    num? locationMarkerSize,
    bool? showCenterMarker,
    bool? showLocator,
    Locator? locator,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    L.LocationIndicator? locationIndicator,
    bool? showCompass,
    Compass? compass,
    bool? showScale,
    Scale? scale,
    bool? interactive,
    LatLngBounds? maxBounds,
    LatLngBounds? fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    bool? slideOnBoundaries,
    bool? adaptiveBoundaries,
    bool? hideAttribution,
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
  }) {
    return U.Map(
      key: key,
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      rotation: rotation,
      disableRotation: disableRotation,
      background: background,
      controller: controller,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      tiles: tiles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
      crs: crs,
      size: size,
      live: live,
      moveWhenLive: moveWhenLive,
      centerMarker: centerMarker,
      locationMarker: locationMarker,
      centerMarkerSize: centerMarkerSize,
      locationMarkerSize: locationMarkerSize,
      showCenterMarker: showCenterMarker,
      showLocator: showLocator,
      locator: locator,
      showLocationMarker: showLocationMarker,
      showLocationIndicator: showLocationIndicator,
      locationIndicator: locationIndicator,
      showCompass: showCompass,
      compass: compass,
      showScale: showScale,
      scale: scale,
      interactive: interactive,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      hideAttribution: hideAttribution,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      onReady: onReady,
      base: HereTileLayer(
        type: type,
        options: options ?? L.TileLayerOptions(),
        appId: appId,
        appCode: appCode,
        version: version,
      ),
    );
  }

  /// Used to load and display tile layers on the map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.TileLayer(
  ///   templateUrl: 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
  ///   subdomains: ['mt0','mt1','mt2','mt3'],
  ///   attribution: 'Map Data &copy; Google',
  ///   updateInterval: 100,
  ///   maxZoom: 20,
  ///   minZoom: 0,
  /// )
  /// ```
  ///
  /// Alias: TileLayer
  ///
  /// Example:
  ///
  /// ```dart
  /// TileLayer(
  ///   options: TileLayerOptions(
  ///     templateUrl: 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
  ///     subdomains: ['mt0','mt1','mt2','mt3'],
  ///     attribution: 'Map Data &copy; Google',
  ///     updateInterval: 100,
  ///     maxZoom: 20,
  ///     minZoom: 0,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: templateUrl
  ///
  /// A string of the following form:
  ///
  /// ```
  /// 'http://{s}.somemap.com/blabla/{z}/{x}/{y}{r}.png'
  /// ```
  ///
  /// `{s}` means one of the available subdomains (used sequentially to help
  /// with browser parallel requests per domain limitation.
  ///
  /// subdomain values are specified in options (`a`, `b` or `c` by default, can be omitted),
  /// `{z}` — zoom level, `{x}` and `{y}` — tile coordinates.
  /// `{r}` can be used to add "@2x" to the URL to load retina tiles.
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer TileLayer(
    String templateUrl, {
    dynamic subdomains = subdomainsDef,
    LatLngBounds? bounds,
    double minZoom = minZoomDef,
    double maxZoom = maxZoomDef,
    double? minNativeZoom,
    double? maxNativeZoom,
    double zoomOffset = zoomOffsetDef,
    bool zoomReverse = false,
    bool crossOrigin = false,
    dynamic tileSize = tileSizeDef,
    double opacity = tileOpacityDef,
    String errorTileUrl = '',
    bool updateWhenZooming = true,
    int updateInterval = updateTileIntervalDef,
    L.TileProvider tileProvider = tileProviderDef,
    int keepBuffer = keepBufferDef,
    bool tms = tmsDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    dynamic additionalOptions = const <String, dynamic>{},
  }) {
    return L.TileLayer(
      options: L.TileLayerOptions(
        templateUrl: templateUrl,
        subdomains: subdomains,
        minZoom: minZoom,
        maxZoom: maxZoom,
        zoomOffset: zoomOffset,
        zoomReverse: zoomReverse,
        tileSize: tileSize,
        opacity: opacity,
        updateInterval: updateInterval,
        minNativeZoom: minNativeZoom,
        maxNativeZoom: maxNativeZoom,
        tileProvider: tileProvider,
        tms: tms,
        keepBuffer: keepBuffer,
        interactive: interactive,
        attribution: attribution,
        additionalOptions: additionalOptions,
      ),
    );
  }

  /// Used to display [WMS](https://en.wikipedia.org/wiki/Web_Map_Service)
  /// services as tile layers on the map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.WMSTileLayer(
  ///   'http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi',
  ///   attribution: 'Weather data &copy; 2012 IEM Nexrad',
  ///   layers: 'nexrad-n0r-900913',
  ///   format: 'image/png',
  ///   transparent: true,
  /// )
  /// ```
  ///
  /// Alias: TileLayer with WMSTileLayerOptions as options
  ///
  /// Example:
  ///
  /// ```dart
  /// TileLayer(
  ///   options: WMSTileLayerOptions(
  ///     templateUrl: 'http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi',
  ///     attribution: 'Weather data &copy; 2012 IEM Nexrad',
  ///     layers: 'nexrad-n0r-900913',
  ///     format: 'image/png',
  ///     transparent: true,
  ///   ),
  /// )
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer WMSTileLayer(
    String templateUrl, {
    dynamic subdomains = subdomainsDef,
    LatLngBounds? bounds,
    double minZoom = minZoomDef,
    double maxZoom = maxZoomDef,
    double? minNativeZoom,
    double? maxNativeZoom,
    double zoomOffset = zoomOffsetDef,
    bool zoomReverse = false,
    bool crossOrigin = false,
    dynamic tileSize = tileSizeDef,
    double opacity = tileOpacityDef,
    String errorTileUrl = '',
    bool updateWhenZooming = true,
    int updateInterval = updateTileIntervalDef,
    int tileFadeInDuration = tileFadeInDurationDef,
    L.TileProvider tileProvider = tileProviderDef,
    int keepBuffer = keepBufferDef,
    bool tms = tmsDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    Crs? crs,
    dynamic layers = '',
    dynamic styles = '',
    String format = 'image/jpeg',
    String version = '1.1.1',
    bool transparent = false,
    bool uppercase = false,
    dynamic additionalOptions = const <String, dynamic>{},
  }) {
    return L.TileLayer(
      options: L.WMSTileLayerOptions(
        templateUrl: templateUrl,
        subdomains: subdomains,
        minZoom: minZoom,
        maxZoom: maxZoom,
        zoomOffset: zoomOffset,
        zoomReverse: zoomReverse,
        tileSize: tileSize,
        opacity: opacity,
        updateInterval: updateInterval,
        tileFadeInDuration: tileFadeInDuration,
        minNativeZoom: minNativeZoom,
        maxNativeZoom: maxNativeZoom,
        tileProvider: tileProvider,
        tms: tms,
        keepBuffer: keepBuffer,
        interactive: interactive,
        attribution: attribution,
        crs: crs,
        layers: layers,
        styles: styles,
        format: format,
        version: version,
        transparent: transparent,
        uppercase: uppercase,
        additionalOptions: additionalOptions,
      ),
    );
  }

  /// Used to load and display tile layers from GoogleMap servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.GoogleMapLayer(
  ///   type: GoogleMapType.Hybrid,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: type
  ///
  /// enum to define the type of GoogleMap tiles to load.
  /// Default value: [GoogleMapType.Street].
  ///
  /// Available values:
  /// [GoogleMapType.Street]
  /// [GoogleMapType.Satellite]
  /// [GoogleMapType.Hybrid]
  /// [GoogleMapType.Terrain]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer GoogleMapTileLayer({
    GoogleMapType type = GoogleMapType.Street,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: google(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from MapBox servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MapBoxLayer(
  ///   type: MapBoxType.Satellite,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [accessToken]
  ///
  /// Your access token to load tiles from MapBox.
  /// Required.
  ///
  /// @param: [type]
  ///
  /// enum to define the type of MapBox tiles to load.
  /// Default value: [MapBoxType.Street].
  ///
  /// Available values:
  /// [MapBoxType.Basic]
  /// [MapBoxType.Street]
  /// [MapBoxType.Satellite]
  /// [MapBoxType.Hybrid]
  /// [MapBoxType.Outdoors]
  /// [MapBoxType.Dark]
  /// [MapBoxType.Light]
  /// [MapBoxType.Bright]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer MapBoxTileLayer({
    required String accessToken,
    MapBoxType type = MapBoxType.Street,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: mapbox(
        type: type,
        accessToken: accessToken,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from OpenStreetMap servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.OpenStreetMapLayer(
  ///   type: OpenStreetMapType.HOT,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of OpenStreetMap tiles to load.
  /// Default value: [OpenStreetMapType.HOT]
  ///
  /// Available values:
  /// [OpenStreetMapType.Mapnik]
  /// [OpenStreetMapType.DE]
  /// [OpenStreetMapType.CH]
  /// [OpenStreetMapType.France]
  /// [OpenStreetMapType.HOT]
  /// [OpenStreetMapType.BZH]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer OpenStreetMapLayer({
    OpenStreetMapType type = OpenStreetMapType.HOT,
    L.TileLayerOptions? options,
    String apikey = '',
  }) {
    return L.TileLayer(
      options: osm(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from SafeCast servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.SafeCastTileLayer(
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer SafeCastTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: safecast(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from CyclOSM servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.CyclOSMTileLayer(
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer CyclOSMTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: cyclosm(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from MtbMap servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MtbMapTileLayer(
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer MtbMapTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: mtbmap(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from NLS servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.NLSTileLayer(
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer NLSTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: nls(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from Wikimedia servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.WikimediaTileLayer(
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer WikimediaTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: wikimedia(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from Open Map servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.OpenTileLayer(
  ///   type: OpenType.OpenSeaMap,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Open Map tiles to load.
  ///
  /// Available values:
  /// [OpenType.OpenSeaMap]
  /// [OpenType.OpenPtMap]
  /// [OpenType.OpenTopoMap]
  /// [OpenType.OpenRailwayMap]
  /// [OpenType.OpenFireMap]
  /// [OpenType.OpenSnowMap]
  /// [OpenType.OpenAIP]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer OpenTileLayer({
    required OpenType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: open(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Stadia servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.StadiaTileLayer(
  ///   type: StadiaType.OSMOutdoors,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Stadia Map tiles to load.
  ///
  /// Available values:
  /// [StadiaType.AlidadeSmooth]
  /// [StadiaType.AlidadeSmoothDark]
  /// [StadiaType.OSMBright]
  /// [StadiaType.OSMOutdoors]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer StadiaTileLayer({
    required StadiaType type,
    required String apikey,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: stadia(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Thunderforest servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.ThunderforestTileLayer(
  ///   type: ThunderforestType.Outdoors,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Thunderforest Map tiles to load.
  ///
  /// Available values:
  /// [ThunderforestType.Cycle]
  /// [ThunderforestType.Transport]
  /// [ThunderforestType.TransportDark]
  /// [ThunderforestType.Spinal]
  /// [ThunderforestType.Landscape]
  /// [ThunderforestType.Outdoors]
  /// [ThunderforestType.Pioneer]
  /// [ThunderforestType.MobileAtlas]
  /// [ThunderforestType.Neighbourhood]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer ThunderforestTileLayer({
    required ThunderforestType type,
    L.TileLayerOptions? options,
    required String apikey,
  }) {
    return L.TileLayer(
      options: thunderforest(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Jawg servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.JawgTileLayer(
  ///   type: JawgType.Streets,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Jawg Map tiles to load.
  ///
  /// Available values:
  /// [JawgType.Streets]
  /// [JawgType.Terrain]
  /// [JawgType.Sunny]
  /// [JawgType.Dark]
  /// [JawgType.Light]
  /// [JawgType.Matrix]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer JawgTileLayer({
    required JawgType type,
    L.TileLayerOptions? options,
    required String accessToken,
  }) {
    return L.TileLayer(
      options: jawg(
        type: type,
        accessToken: accessToken,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from MapTiler servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MapTilerTileLayer(
  ///   type: JawgType.Default,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of MapTiler tiles to load.
  ///
  /// Available values:
  /// [MapTilerType.Default]
  /// [MapTilerType.Streets]
  /// [MapTilerType.Basic]
  /// [MapTilerType.Bright]
  /// [MapTilerType.Pastel]
  /// [MapTilerType.Positron]
  /// [MapTilerType.Hybrid]
  /// [MapTilerType.Toner]
  /// [MapTilerType.Topo]
  /// [MapTilerType.Voyager]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer MapTilerTileLayer({
    MapTilerType type = MapTilerType.Default,
    L.TileLayerOptions? options,
    required String apikey,
  }) {
    return L.TileLayer(
      options: maptiler(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Stamen servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.StamenTileLayer(
  ///   type: StamenType.Toner,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Stamen Map tiles to load.
  ///
  /// Available values:
  /// [StamenType.Toner]
  /// [StamenType.TonerBackground]
  /// [StamenType.TonerHybrid]
  /// [StamenType.TonerLines]
  /// [StamenType.TonerLabels]
  /// [StamenType.TonerLite]
  /// [StamenType.Watercolor]
  /// [StamenType.Terrain]
  /// [StamenType.TerrainBackground]
  /// [StamenType.TerrainLabels]
  /// [StamenType.Relief]
  /// [StamenType.TopOSMRelief]
  /// [StamenType.TopOSMFeatures]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer StamenTileLayer({
    required StamenType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: stamen(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from TomTom Map servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.TomTomTileLayer(
  ///   type: TomTomType.Basic,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of TomTom Map tiles to load.
  ///
  /// Available values:
  /// [TomTomType.Basic]
  /// [TomTomType.Hybrid]
  /// [TomTomType.Labels]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer TomTomTileLayer({
    required TomTomType type,
    L.TileLayerOptions? options,
    required String apikey,
  }) {
    return L.TileLayer(
      options: tomtom(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Esri servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.EsriTileLayer(
  ///   type: EsriType.WorldStreetMap,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Esri Map tiles to load.
  ///
  /// Available values:
  /// [EsriType.WorldStreetMap]
  /// [EsriType.WorldImagery]
  /// [EsriType.WorldTopoMap]
  /// [EsriType.WorldTerrain]
  /// [EsriType.WorldShadedRelief]
  /// [EsriType.WorldPhysical]
  /// [EsriType.WorldGray]
  /// [EsriType.DeLorme]
  /// [EsriType.OceanBasemap]
  /// [EsriType.NatGeoWorldMap]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer EsriTileLayer({
    required EsriType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: esri(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from CartoDB servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.CartoDBTileLayer(
  ///   type: CartoDBType.Positron,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of CartoDB Map tiles to load.
  ///
  /// Available values:
  /// [CartoDBType.Positron]
  /// [CartoDBType.PositronNoLabels]
  /// [CartoDBType.PositronOnlyLabels]
  /// [CartoDBType.DarkMatter]
  /// [CartoDBType.DarkMatterNoLabels]
  /// [CartoDBType.DarkMatterOnlyLabels]
  /// [CartoDBType.Voyager]
  /// [CartoDBType.VoyagerNoLabels]
  /// [CartoDBType.VoyagerOnlyLabels]
  /// [CartoDBType.VoyagerLabelsUnder]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer CartoDBTileLayer({
    required CartoDBType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: cartodb(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from BasemapAT servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.BasemapATTileLayer(
  ///   type: BasemapATType.Default,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of BasemapAT Map tiles to load.
  ///
  /// Available values:
  /// [BasemapATType.Default]
  /// [BasemapATType.Grau]
  /// [BasemapATType.Overlay]
  /// [BasemapATType.Terrain]
  /// [BasemapATType.Surface]
  /// [BasemapATType.Hdpi]
  /// [BasemapATType.Orthofoto]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer BasemapATTileLayer({
    BasemapATType type = BasemapATType.Default,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: basemapat(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from HikeBike servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.HikeBikeTileLayer(
  ///   type: HikeBikeType.Default,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of HikeBike Map tiles to load.
  ///
  /// Available values:
  /// [HikeBikeType.Default]
  /// [HikeBikeType.Hill]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer HikeBikeTileLayer({
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: hikebike(options: options ?? L.TileLayerOptions()),
    );
  }

  /// Used to load and display tile layers from NLMaps servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.NLMapsTileLayer(
  ///   type: NLMapsType.Default,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of NLMaps tiles to load.
  ///
  /// Available values:
  /// [NLMapsType.Default]
  /// [NLMapsType.Pastel]
  /// [NLMapsType.Grijs]
  /// [NLMapsType.Luchtfoto]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer NLMapsTileLayer({
    NLMapsType type = NLMapsType.Default,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: nlmaps(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Geoportail France Map servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.GeoportailFranceTileLayer(
  ///   type: GeoportailFranceType.Plan,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Geoportail France Map tiles to load.
  ///
  /// Available values:
  /// [GeoportailFranceType.Plan]
  /// [GeoportailFranceType.Parcels]
  /// [GeoportailFranceType.Orthos]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer GeoportailFranceTileLayer({
    required GeoportailFranceType type,
    L.TileLayerOptions? options,
    required String apikey,
  }) {
    return L.TileLayer(
      options: geoportail(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Open Weather Map servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.OpenWeatherMapTileLayer(
  ///   type: OpenWeatherMapType.Clouds,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Open Weather Map tiles to load.
  ///
  /// Available values:
  /// [OpenWeatherMapType.Clouds]
  /// [OpenWeatherMapType.CloudsClassic]
  /// [OpenWeatherMapType.Precipitation]
  /// [OpenWeatherMapType.PrecipitationClassic]
  /// [OpenWeatherMapType.Rain]
  /// [OpenWeatherMapType.RainClassic]
  /// [OpenWeatherMapType.Pressure]
  /// [OpenWeatherMapType.PressureContour]
  /// [OpenWeatherMapType.Wind]
  /// [OpenWeatherMapType.Temperature]
  /// [OpenWeatherMapType.Snow]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer OpenWeatherMapTileLayer({
    required OpenWeatherMapType type,
    L.TileLayerOptions? options,
    required String apikey,
  }) {
    return L.TileLayer(
      options: openweather(
        type: type,
        apikey: apikey,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from NASA GIBS servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.NASAGIBSTileLayer(
  ///   type: NASAGIBSType.ModisTerraTrueColorCR,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of NASA GIBS tiles to load.
  ///
  /// Available values:
  /// [NASAGIBSType.ModisTerraTrueColorCR]
  /// [NASAGIBSType.ModisTerraBands367CR]
  /// [NASAGIBSType.ViirsEarthAtNight2012]
  /// [NASAGIBSType.ModisTerraLSTDay]
  /// [NASAGIBSType.ModisTerraSnowCover]
  /// [NASAGIBSType.ModisTerraAOD]
  /// [NASAGIBSType.ModisTerraChlorophyll]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer NASAGIBSTileLayer({
    required NASAGIBSType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: nasagibs(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from USGS servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.USGSTileLayer(
  ///   type: USGSType.Topo,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of USGS Map tiles to load.
  ///
  /// Available values:
  /// [USGSType.Topo]
  /// [USGSType.Imagery]
  /// [USGSType.ImageryTopo]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer USGSTileLayer({
    required USGSType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: usgs(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from Waymarked Trails servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.WaymarkedTrailsTileLayer(
  ///   type: WaymarkedTrailsType.Hiking,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of Waymarked Trails Map tiles to load.
  ///
  /// Available values:
  /// [WaymarkedTrailsType.Hiking]
  /// [WaymarkedTrailsType.Cycling]
  /// [WaymarkedTrailsType.MTB]
  /// [WaymarkedTrailsType.Slopes]
  /// [WaymarkedTrailsType.Riding]
  /// [WaymarkedTrailsType.Skating]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer WaymarkedTrailsTileLayer({
    required WaymarkedTrailsType type,
    L.TileLayerOptions? options,
  }) {
    return L.TileLayer(
      options: waymarkedtrails(
        type: type,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to load and display tile layers from HERE Map servers.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.HereTileLayer(
  ///   appId: '',
  ///   appCode: '',
  ///   type: HereType.NormalDay,
  ///   options: TileLayerOptions(
  ///     opacity: 0.9,
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [type]
  ///
  /// enum to define the type of HERE Map tiles to load.
  ///
  /// Available values:
  /// [HereType.NormalDay]
  /// [HereType.NormalDayCustom]
  /// [HereType.NormalDayGrey]
  /// [HereType.NormalDayMobile]
  /// [HereType.NormalDayGreyMobile]
  /// [HereType.NormalDayTransit]
  /// [HereType.NormalDayTransitMobile]
  /// [HereType.NormalDayTraffic]
  /// [HereType.NormalNight]
  /// [HereType.NormalNightMobile]
  /// [HereType.NormalNightGrey]
  /// [HereType.NormalNightGreyMobile]
  /// [HereType.NormalNightTransit]
  /// [HereType.NormalNightTransitMobile]
  /// [HereType.ReducedDay]
  /// [HereType.ReducedNight]
  /// [HereType.BasicMap]
  /// [HereType.MapLabels]
  /// [HereType.TrafficFlow]
  /// [HereType.CarnavDayGrey]
  /// [HereType.HybridDay]
  /// [HereType.HybridDayMobile]
  /// [HereType.HybridDayTransit]
  /// [HereType.HybridDayGrey]
  /// [HereType.HybridDayTraffic]
  /// [HereType.PedestrianDay]
  /// [HereType.PedestrianNight]
  /// [HereType.SatelliteDay]
  /// [HereType.TerrainDay]
  /// [HereType.TerrainDayMobile]
  ///
  /// @param: [options]
  ///
  /// Parameter to override the default value of TileLayerOptions
  /// Default value: [TileLayerOptions()]
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer HereTileLayer({
    required HereType type,
    L.TileLayerOptions? options,
    required String appId,
    required String appCode,
    String version = 'v3',
  }) {
    if (version == 'v3') {
      return L.TileLayer(
        options: herev3(
          type: type,
          appId: appId,
          appCode: appCode,
          options: options ?? L.TileLayerOptions(),
        ),
      );
    }

    return L.TileLayer(
      options: here(
        type: type,
        appId: appId,
        appCode: appCode,
        options: options ?? L.TileLayerOptions(),
      ),
    );
  }

  /// Used to display marker(s) at specified locations on map.
  ///
  /// @param: [marker]
  ///
  /// This param can accept any type of inputs for
  /// a single marker or multiple markers.
  ///
  /// Example:
  ///
  /// Single Marker
  ///
  /// ```dart
  /// U.MarkerLayer([-6.175329, 106.827253], ...)
  /// ```
  ///
  /// ```dart
  /// U.MarkerLayer(LatLng(-6.175329, 106.827253), ...)
  /// ```
  ///
  /// ```dart
  /// U.MarkerLayer(U.Marker([-6.175329, 106.827253]), ...)
  /// ```
  ///
  /// Multiple Markers
  ///
  /// ```dart
  /// U.MarkerLayer([
  ///   [-6.175329, 106.827253],
  ///   [-6.181883, 106.826933],
  /// ], ...)
  /// ```
  ///
  /// ```dart
  /// U.MarkerLayer([
  ///   LatLng(-6.175329, 106.827253),
  ///   LatLng(-6.181883, 106.826933),
  /// ], ...)
  /// ```
  ///
  /// ```dart
  /// U.MarkerLayer([
  ///   U.Marker([-6.175329, 106.827253]),
  ///   U.Marker([-6.181883, 106.826933]),
  /// ], ...)
  /// ```
  ///
  ///
  /// @param: [widget]
  ///
  /// Used to define the widget to show as Marker.
  ///
  /// Available values:
  /// [MarkerIcon]
  /// [MarkerImage]
  /// [MarkerSvg]
  /// [MarkerWidget]
  ///
  /// Default:
  /// ```dart
  /// MarkerSvg('packages/universe/assets/marker2.svg')
  /// ```
  ///
  // ignore: non_constant_identifier_names
  static L.MarkerLayer MarkerLayer(
    dynamic marker, {
    dynamic widget = markerDef,
    double opacity = opacityDef,
    double size = markerSizeDef,
    double width = markerSizeDef,
    double height = markerSizeDef,
    L.MarkerAlignment align = markerAlignDef,
    L.MarkerOffset? offset,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
    dynamic data,
  }) {
    bool isMarker = marker is L.Marker;
    bool isLatLng = marker is LatLng;
    bool isList = (marker is List &&
        marker.isNotEmpty &&
        (marker.first is int || marker.first is double));

    List<dynamic> items = (isMarker || isLatLng || isList) ? [marker] : marker;

    return L.MarkerLayer(
      items
          .map((value) => L.Marker.from(
                value,
                size: size,
                width: width,
                height: height,
                widget: widget,
                data: data,
              ))
          .toList(),
      options: L.MarkerLayerOptions(
        opacity: opacity,
        align: align,
        offset: offset,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  /// Used to create Marker object to be passed to MarkerLayer.
  ///
  /// @param: [latlng]
  ///
  /// Coordinates position to place the Marker on the map.
  ///
  /// Example:
  ///
  /// ```dart
  /// U.MarkerLayer(
  ///   U.Marker(
  ///     [-6.175329, 106.827253],
  ///   ),
  /// )
  /// ```
  ///
  /// or use LatLng to define marker position:
  ///
  /// ```dart
  /// U.MarkerLayer(
  ///   U.Marker(
  ///     LatLng(-6.175329, 106.827253),
  ///   ),
  /// )
  /// ```
  ///
  /// @param: [widget]
  ///
  /// Used to define the type of widget to show as Marker.
  ///
  /// Available values:
  /// [MarkerIcon]
  /// [MarkerImage]
  /// [MarkerSvg]
  /// [MarkerWidget]
  ///
  // ignore: non_constant_identifier_names
  static L.Marker Marker(
    dynamic latlng, {
    Key? key,
    dynamic widget,
    double opacity = opacityDef,
    double size = markerSizeDef,
    double width = markerSizeDef,
    double height = markerSizeDef,
    L.MarkerAlignment align = markerAlignDef,
    L.MarkerOffset? offset,
    dynamic data,
  }) {
    return L.Marker.from(
      latlng,
      key: key,
      size: size,
      width: width,
      height: height,
      opacity: opacity,
      align: align,
      offset: offset,
      widget: widget,
      data: data,
    );
  }

  // ignore: non_constant_identifier_names
  static L.CircleLayer CircleLayer(
    dynamic circle, {
    double? radius,
    L.RadiusUnit radiusUnit = L.RadiusUnit.METER,
    bool stroke = strokeDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthCircleDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = fillCircleDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    bool interactive = interactiveDef,
    dynamic data,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    bool isCircle = circle is L.Circle;
    bool isLatLng = circle is List &&
        circle.isNotEmpty &&
        (circle.first is int || circle.first is double);
    List<dynamic> items = (isCircle || isLatLng) ? [circle] : circle;

    return L.CircleLayer(
      items
          .map((value) => L.Circle.from(
                value,
                radius: radius,
                radiusUnit: radiusUnit,
                data: data,
              ))
          .toList(),
      options: L.CircleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fill: fill,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        interactive: interactive,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.Circle Circle(
    dynamic circle, {
    double? radius,
    L.RadiusUnit radiusUnit = L.RadiusUnit.METER,
    bool stroke = strokeDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthCircleDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = fillCircleDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    dynamic data,
  }) {
    return L.Circle.from(
      circle,
      radius: radius,
      radiusUnit: radiusUnit,
      stroke: stroke,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      fill: fill,
      fillColor: fillColor ?? strokeColor,
      fillOpacity: fillOpacity,
      data: data,
    );
  }

  // ignore: non_constant_identifier_names
  static L.PolylineLayer PolylineLayer(
    dynamic polyline, {
    Color? strokeColor,
    double strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
    dynamic data,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    bool isPolyline = polyline is L.Polyline;
    bool isLatLngs = polyline is List &&
        polyline.isNotEmpty &&
        polyline.first is List &&
        (polyline.first.first is int || polyline.first.first is double);

    List<dynamic> items = (isPolyline || isLatLngs) ? [polyline] : polyline;

    return L.PolylineLayer(
      items.map((value) => L.Polyline.from(value, data: data)).toList(),
      options: L.PolylineLayerOptions(
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        pathFillType: pathFillType,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        isDotted: isDotted,
        culling: culling,
        interactive: interactive,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.Polyline Polyline(
    dynamic latlngs, {
    bool stroke = strokeDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    dynamic data,
  }) {
    return L.Polyline.from(
      latlngs,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      pathFillType: pathFillType,
      gradientStrokeColors: gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops,
      isDotted: isDotted,
      data: data,
    );
  }

  // ignore: non_constant_identifier_names
  static L.PolygonLayer PolygonLayer(
    dynamic polygon, {
    bool stroke = strokePolygonDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthPolygonDef,
    double strokeOpacity = strokeOpacityPolygonDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    double smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
    dynamic data,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    bool isPolygon = polygon is L.Polygon;
    bool isLatLngs = polygon is List &&
        polygon.isNotEmpty &&
        polygon.first is List &&
        (polygon.first.first is int || polygon.first.first is double);

    List<dynamic> items = (isPolygon || isLatLngs) ? [polygon] : polygon;

    return L.PolygonLayer(
      items.map((value) => L.Polygon.from(value, data: data)).toList(),
      options: L.PolygonLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor ?? fillColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        pathFillType: pathFillType,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.Polygon Polygon(
    List<dynamic> latlngs, {
    bool stroke = strokePolygonDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthPolygonDef,
    double strokeOpacity = strokeOpacityPolygonDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    dynamic data,
  }) {
    return L.Polygon.from(
      latlngs,
      stroke: stroke,
      strokeColor: strokeColor ?? fillColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
      pathFillType: pathFillType,
      gradientStrokeColors: gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops,
      gradientFillColors: gradientFillColors,
      gradientFillStops: gradientFillStops,
      isDotted: isDotted,
      data: data,
    );
  }

  // ignore: non_constant_identifier_names
  static L.RectangleLayer RectangleLayer(
    dynamic rectangle, {
    bool stroke = strokeRectangleDef,
    Color? strokeColor,
    double strokeWidth = strokeWidthRectangleDef,
    double strokeOpacity = strokeOpacityRectangleDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    double smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
    dynamic data,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    bool isRectangle = rectangle is L.Rectangle;
    bool isLatLngs = rectangle is List &&
        rectangle.isNotEmpty &&
        rectangle.first is List &&
        (rectangle.first.first is int || rectangle.first.first is double);

    List<dynamic> items = (isRectangle || isLatLngs) ? [rectangle] : rectangle;

    return L.RectangleLayer(
      items.map((value) => L.Rectangle.from(value, data: data)).toList(),
      options: L.RectangleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor ?? fillColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        pathFillType: pathFillType,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.Rectangle Rectangle(
    List<dynamic> latlngs, {
    bool? stroke,
    Color? strokeColor,
    double strokeWidth = strokeWidthRectangleDef,
    double strokeOpacity = strokeOpacityRectangleDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    Color? fillColor,
    double fillOpacity = fillOpacityDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    dynamic data,
  }) {
    return L.Rectangle.from(
      latlngs,
      stroke: stroke,
      strokeColor: strokeColor ?? fillColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      pathFillType: pathFillType,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
      gradientStrokeColors: gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops,
      gradientFillColors: gradientFillColors,
      gradientFillStops: gradientFillStops,
      isDotted: isDotted,
      data: data,
    );
  }

  // ignore: non_constant_identifier_names
  static L.GroupLayer GroupLayer({
    required List<L.MapLayer> layers,
    double opacity = opacityDef,
    double rotation = 0.0,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    return L.GroupLayer(
      layers: layers,
      options: L.GroupLayerOptions(
        opacity: opacity,
        rotation: rotation,
        interactive: interactive,
        attribution: attribution,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.ImageOverlay ImageOverlay(
    dynamic image, {
    dynamic bounds,
    ImageProvider? imageError,
    double opacity = overlayOpacityDef,
    double rotation = overlayRotationDef,
    BoxFit fit = overlayFitDef,
    bool gaplessPlayback = overlayGaplessPlaybackDef,
    dynamic data,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    return L.ImageOverlay(
      image,
      bounds: bounds,
      imageError: imageError,
      opacity: opacity,
      rotation: rotation,
      fit: fit,
      gaplessPlayback: gaplessPlayback,
      data: data,
      options: L.InteractiveLayerOptions(
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.VideoOverlay VideoOverlay(
    String videoUrl, {
    dynamic bounds,
    dynamic data,
    bool looping = loopingVideoDef,
    Function(VideoPlayerController?)? onReady,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    return L.VideoOverlay(
      videoUrl,
      bounds: bounds,
      looping: looping,
      data: data,
      onReady: onReady,
      options: L.InteractiveLayerOptions(
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static L.WidgetOverlay WidgetOverlay({
    Widget? child,
    required dynamic bounds,
    dynamic data,
    bool looping = loopingVideoDef,
    double opacity = opacityDef,
    L.TapLayerCallback? onTap,
    L.TapUpLayerCallback? onTapUp,
    L.TapDownLayerCallback? onTapDown,
    L.TapLayerCallback? onTapCancel,
    L.TapLayerCallback? onSecondaryTap,
    L.TapDownLayerCallback? onSecondaryTapDown,
    L.TapUpLayerCallback? onSecondaryTapUp,
    L.TapLayerCallback? onSecondaryTapCancel,
    L.DoubleTapLayerCallback? onDoubleTap,
    L.LongPressLayerCallback? onLongPress,
    L.LongPressStartLayerCallback? onLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onLongPressUp,
    L.LongPressEndLayerCallback? onLongPressEnd,
    L.LongPressLayerCallback? onSecondaryLongPress,
    L.LongPressStartLayerCallback? onSecondaryLongPressStart,
    L.LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    L.LongPressUpLayerCallback? onSecondaryLongPressUp,
    L.LongPressEndLayerCallback? onSecondaryLongPressEnd,
  }) {
    return L.WidgetOverlay(
      bounds: bounds,
      opacity: opacity,
      data: data,
      options: L.InteractiveLayerOptions(
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onSecondaryTap: onSecondaryTap,
        onSecondaryTapDown: onSecondaryTapDown,
        onSecondaryTapUp: onSecondaryTapUp,
        onSecondaryTapCancel: onSecondaryTapCancel,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressUp: onLongPressUp,
        onLongPressEnd: onLongPressEnd,
        onSecondaryLongPress: onSecondaryLongPress,
        onSecondaryLongPressStart: onSecondaryLongPressStart,
        onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressUp: onSecondaryLongPressUp,
        onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      ),
      child: child,
    );
  }

  static double distanceBetween(
    dynamic position,
    dynamic destination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.distance(position, destination, unit: unit);
  }

  static bool isInsideRadius(
    LatLng location,
    LatLng fromCenter,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    double distance = distanceBetween(
      fromCenter,
      location,
      algorithm: algorithm,
      unit: unit,
    );
    return distance <= radius;
  }

  static List<LatLng> filterInsideRadius(
    List<LatLng> locations,
    LatLng fromCenter,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    List<LatLng> result = [];

    for (LatLng location in locations) {
      if (isInsideRadius(location, fromCenter, radius,
          algorithm: algorithm, unit: unit)) {
        result.add(location);
      }
    }

    return result;
  }

  static LatLng destination(
    dynamic fromPosition,
    double distance,
    double bearing, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.offset(fromPosition, distance, bearing);
  }

  static double bearing(
    dynamic position,
    dynamic destination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.bearing(position, destination);
  }
}