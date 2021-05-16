import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import 'control/control.dart';
import 'core/core.dart';
import 'layer/layer.dart' as L;
import 'map/controller/controller.dart' as C;
import 'map/map.dart';
import 'tiles.dart';
import 'shared.dart';
import 'type.dart';

class U {
  // ignore: non_constant_identifier_names
  // static C.MapController MapController() => C.MapController();

  /// The central point of Universe API.
  /// Tt is used to create a map on the screen and manipulate it.
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
  /// It can accept any type of inputs, such as:
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: [-6.175329, 106.827253],
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or LatLng instance:
  ///
  /// ```dart
  /// U.Map(
  ///   controller: MapController(),
  ///   center: LatLng(-6.175329, 106.827253),
  ///   zoom: 15,
  /// )
  /// ```
  ///
  /// or use location name.
  ///
  /// The Universe map is smart enough to automatically
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
    required L.TileLayer base,
    L.MarkerLayer? markers,
    L.CircleLayer? circles,
    L.PolylineLayer? polylines,
    L.PolygonLayer? polygons,
    L.RectangleLayer? rectangles,
    List<L.ImageOverlay> images = const [],
    List<L.VideoOverlay> videos = const [],
    List<L.MapLayer> layers = const [],
    List<Widget> controls = const [],
    Crs? crs,
    Size? size,
    bool? showCenterMarker,
    dynamic centerMarker,
    dynamic locationMarker,
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
      locationMarker: locationMarker ?? markerDef,
      live: live ?? liveDef,
      moveWhenLive: moveWhenLive ?? moveWhenLiveDef,
      locator: locator ?? Locator(),
      showLocator: showLocator ?? showLocatorDef,
      locationIndicator: locationIndicator ?? L.LocationIndicator(),
      showLocationIndicator: showLocationIndicator ??
          showLocator ??
          live ??
          showLocationIndicatorDef,
      showLocationMarker: showLocationMarker ?? showLocationMarkerDef,
      compass: compass ?? Compass(),
      showCompass: showCompass ?? showCompassDef,
      showScale: showScale ?? showScaleDef,
      scale: scale ?? Scale(),
      interactive: interactive ?? interactiveDef,
      maxBounds: maxBounds,
      fitBounds: fitBounds,
      fitBoundsOptions: fitBoundsOptions ?? FitBoundsOptions(),
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
      background: background ?? Color(0xFFDEDEDE),
      base: base,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      images: images,
      videos: videos,
      layers: layers,
      controls: controls,
    );
  }

  /// Used to display map with TileLayer from GoogleMap servers.
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
    if (type == GoogleMapType.Satellite || type == GoogleMapType.Hybrid) {
      background ??= Color(0xFF888888);
    } else {
      background ??= Color(0xFFDEDEDE);
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
      base: GoogleMapLayer(type: type, options: options),
    );
  }

  /// Used to display map with TileLayer from OpenStreetMap servers.
  // ignore: non_constant_identifier_names
  static Universe OpenStreetMap({
    Key? key,
    required dynamic center,
    OpenStreetMapType type = OpenStreetMapType.Mapnik,
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
      base: OpenStreetMapLayer(
        type: type,
        options: options,
        apikey: apikey,
      ),
    );
  }

  /// Used to display map with TileLayer from MapBox servers.
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
    if (type == MapBoxType.Dark) {
      background ??= Color(0xFF555555);
    } else if (type == MapBoxType.Satellite || type == MapBoxType.Hybrid) {
      background ??= Color(0xFF888888);
    } else {
      background ??= Color(0xFFDEDEDE);
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
      base: MapBoxLayer(type: type, accessToken: accessToken),
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
    additionalOptions = const <String, dynamic>{},
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
  ///   templateUrl: 'http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi',
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
    additionalOptions = const <String, dynamic>{},
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
  static L.TileLayer GoogleMapLayer({
    GoogleMapType type = GoogleMapType.Street,
    L.TileLayerOptions? options,
  }) {
    options ??= L.TileLayerOptions();

    String lyrs = 'm';
    if (type == GoogleMapType.Satellite)
      lyrs = 's';
    else if (type == GoogleMapType.Hybrid)
      lyrs = 'y';
    else if (type == GoogleMapType.Terrain) lyrs = 'p';

    return L.TileLayer(
      options: options.copy(
        templateUrl: 'https://{s}.google.com/vt/lyrs=$lyrs&x={x}&y={y}&z={z}',
        subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
        attribution: 'Map Data &copy; Google',
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
  /// Default value: [OpenStreetMapType.Mapnik]
  ///
  /// @param: [apikey]
  ///
  /// String to pass api key to load OSM Map that need apikey.
  ///
  // ignore: non_constant_identifier_names
  static L.TileLayer OpenStreetMapLayer({
    OpenStreetMapType type = OpenStreetMapType.Mapnik,
    L.TileLayerOptions? options,
    String apikey = '',
  }) {
    options ??= L.TileLayerOptions();

    return L.TileLayer(
      options: osm(type, options, apikey),
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
  static L.TileLayer MapBoxLayer({
    required String accessToken,
    MapBoxType type = MapBoxType.Street,
    L.TileLayerOptions? options,
  }) {
    options ??= L.TileLayerOptions();

    String id = 'mapbox/streets-v11';
    if (type == MapBoxType.Basic) id = 'mapbox/basic-v9';
    if (type == MapBoxType.Satellite) id = 'mapbox/satellite-v9';
    if (type == MapBoxType.Hybrid) id = 'mapbox/satellite-streets-v11';
    if (type == MapBoxType.Outdoors) id = 'mapbox/outdoors-v11';
    if (type == MapBoxType.Dark) id = 'mapbox/dark-v10';
    if (type == MapBoxType.Light) id = 'mapbox/light-v10';
    if (type == MapBoxType.Bright) id = 'mapbox/bright-v9';

    return L.TileLayer(
      options: options.copy(
        tileSize: 512,
        maxZoom: 18,
        zoomOffset: -1,
        templateUrl:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        attribution:
            'Map data &copy; OpenStreetMap contributors, Imagery &copy; MapBox',
        additionalOptions: {
          'id': id,
          'accessToken': accessToken,
        },
      ),
    );
  }

  /// Used to display marker(s) at specified locations on map.
  ///
  /// @param: [marker]
  ///
  /// This param can accept any type of inputs for
  /// a single marker layer or multiple markers layer.
  ///
  /// Example:
  ///
  /// Single Marker Layer
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
  /// Multiple Markers Layer
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
  /// Used to define the type of widget to show as Marker.
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
      child: child,
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
    double distance =
        distanceBetween(fromCenter, location, algorithm: algorithm, unit: unit);
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
