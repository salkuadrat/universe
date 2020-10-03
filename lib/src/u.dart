import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:universe/src/layer/marker/image.dart';
import 'package:universe/universe.dart';

import 'core/core.dart';
import 'layer/marker/marker.dart' as M;
import 'layer/circle/marker.dart' as C;
import 'layer/polyline/marker.dart' as PL;
import 'layer/polygon/marker.dart' as PG;
import 'layer/rectangle/marker.dart' as R;
import 'layer/layer.dart';
import 'map/map.dart';
import 'osm.dart';
import 'shared.dart';

enum GoogleMapType {
  Street,
  Satellite,
  Hybrid,
  Terrain,
}

class U {

  static const CRSS CRS = const CRSS();

  // ignore: non_constant_identifier_names
  static Universe Map({
    @required dynamic center, 
    num zoom,
    num minZoom,
    num maxZoom,
    num zoomDelta,
    Color background,
    MapController controller,
    LatLngBounds bounds,
    TileLayer base,
    MarkerLayer markers,
    CircleLayer circles,
    PolylineLayer polylines,
    PolygonLayer polygons,
    RectangleLayer rectangles,
    List<MapLayer> layers,
    Crs crs,
    Size size,
    bool live,
    bool locator,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    MapChangedCallback onChanged,
  }) {
    MapOptions options = MapOptions(
      crs: crs ?? CRS.EPSG3857,
      size: size,
      bounds: bounds,
      center: LatLng.from(center),
      zoomOptions: ZoomOptions(
        zoom: zoom ?? zoomDef, 
        minZoom: minZoom ?? minZoomDef, 
        maxZoom: maxZoom ?? maxZoomDef,
        zoomDelta: zoomDelta ?? zoomDeltaDef,
      ),
      rotation: 0.0,
      live: live ?? liveDef,
      locator: locator ?? locatorDef,
      interactive: interactive ?? interactiveDef,
      slideOnBoundaries: slideOnBoundaries ?? false,
      adaptiveBoundaries: adaptiveBoundaries ?? false,
      swPanBoundary: swPanBoundary,
      nePanBoundary: nePanBoundary,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
    );

    return Universe(
      controller: controller,
      options: options,
      background: background ?? Color(0xFFDEDEDE),
      base: base,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      layers: layers ?? [],
    );
  }

  // ignore: non_constant_identifier_names
  static Universe GoogleMap({
    @required dynamic center, 
    GoogleMapType type = GoogleMapType.Street,
    TileLayerOptions options,
    num zoom,
    num minZoom,
    num maxZoom,
    Color background,
    MapController controller,
    LatLngBounds bounds,
    MarkerLayer markers,
    CircleLayer circles,
    PolylineLayer polylines,
    PolygonLayer polygons,
    RectangleLayer rectangles,
    List<MapLayer> layers,
    Crs crs,
    Size size,
    bool live,
    bool locator,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    MapChangedCallback onChanged,
  }) {

    String lyrs = 'm';
    if(type == GoogleMapType.Satellite) lyrs = 's';
    else if(type == GoogleMapType.Hybrid) lyrs = 'y';
    else if(type == GoogleMapType.Terrain) lyrs = 'p';

    options ??= TileLayerOptions();

    return U.Map(
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      background: background,
      controller: controller,
      bounds: bounds,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      layers: layers,
      crs: crs,
      size: size,
      live: live,
      locator: locator,
      interactive: interactive,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      swPanBoundary: swPanBoundary,
      nePanBoundary: nePanBoundary,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      base: TileLayer(
        options: options.copy(
          templateUrl: 'http://{s}.google.com/vt/lyrs=$lyrs&x={x}&y={y}&z={z}',
          subdomains: ['mt0','mt1','mt2','mt3'],
          attribution: 'Map Data &copy; Google',
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static Universe OpenStreetMap({
    @required dynamic center, 
    OpenStreetMapType type = OpenStreetMapType.Mapnik,
    TileLayerOptions options,
    num zoom,
    num minZoom,
    num maxZoom,
    Color background,
    MapController controller,
    LatLngBounds bounds,
    MarkerLayer markers,
    CircleLayer circles,
    PolylineLayer polylines,
    PolygonLayer polygons,
    RectangleLayer rectangles,
    List<MapLayer> layers,
    Crs crs,
    Size size,
    bool live,
    bool locator,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    MapChangedCallback onChanged,
  }) {

    options ??= TileLayerOptions();

    return U.Map(
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      background: background,
      controller: controller,
      bounds: bounds,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      layers: layers,
      crs: crs,
      size: size,
      live: live,
      locator: locator,
      interactive: interactive,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      swPanBoundary: swPanBoundary,
      nePanBoundary: nePanBoundary,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      base: TileLayer(options: osm(type, options)),
    );
  }

  // ignore: non_constant_identifier_names
  static Universe MapBox({
    @required dynamic center, 
    @required String accessToken,
    TileLayerOptions options,
    num zoom,
    num minZoom,
    num maxZoom,
    Color background,
    MapController controller,
    LatLngBounds bounds,
    MarkerLayer markers,
    CircleLayer circles,
    PolylineLayer polylines,
    PolygonLayer polygons,
    RectangleLayer rectangles,
    List<MapLayer> layers,
    Crs crs,
    Size size,
    bool live,
    bool locator,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    MapChangedCallback onChanged,
  }) {

    options ??= TileLayerOptions();

    return U.Map(
      center: center,
      zoom: zoom,
      minZoom: minZoom,
      maxZoom: maxZoom,
      background: background,
      controller: controller,
      bounds: bounds,
      markers: markers,
      circles: circles,
      polylines: polylines,
      polygons: polygons,
      rectangles: rectangles,
      layers: layers,
      crs: crs,
      size: size,
      live: live,
      locator: locator,
      interactive: interactive,
      slideOnBoundaries: slideOnBoundaries,
      adaptiveBoundaries: adaptiveBoundaries,
      swPanBoundary: swPanBoundary,
      nePanBoundary: nePanBoundary,
      onTap: onTap,
      onLongPress: onLongPress,
      onChanged: onChanged,
      base: TileLayer(
        options: options.copy(
          templateUrl: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$accessToken',
          attribution: 'Map Data &copy; MapBox'
        ),
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  static TileLayer Tile(String templateUrl, {
    dynamic subdomains = subdomainsDef,
    num minZoom = minZoomDef,
    num maxZoom = maxZoomDef,
    num zoomOffset = zoomOffsetDef,
    String errorTileUrl = '',
    bool zoomReverse = false,
    bool crossOrigin = false,
    dynamic tileSize = tileSizeDef,
    double opacity = tileOpacityDef,
    bool updateWhenZooming = true,
    num updateInterval = updateTileIntervalDef,
    LatLngBounds bounds,
    num minNativeZoom,
    num maxNativeZoom,
    TileProvider tileProvider = tileProviderDef,
    bool tms = tmsDef,
    num keepBuffer = keepBufferDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) {
    return TileLayer(
      options: TileLayerOptions(
        templateUrl: templateUrl,
        subdomains: subdomains,
        minZoom: minZoom?.toDouble(),
        maxZoom: maxZoom?.toDouble(),
        zoomOffset: zoomOffset?.toDouble(),
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
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static MarkerLayer Marker(dynamic latlng, {
    dynamic marker, 
    num opacity = opacityDef,
    num size = markerSizeDef,
    num width,
    num height,
    MarkerAlignment align = markerAlignDef,
    Offset offset,
  }) {
    return MarkerLayer(
      M.Marker.from(latlng),
      options: MarkerLayerOptions(
        icon: marker is MarkerIcon ? marker : null, 
        image: marker is MarkerImage ? marker : null, 
        widget: marker is Widget ? marker : null,
        opacity: opacity,
        size: size,
        width: width,
        height: height,
        align: align,
        offset: offset,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static MarkerLayer Markers(List<dynamic> latlngs, {
    dynamic marker, 
    num opacity = opacityDef,
    num size = markerSizeDef,
    num width,
    num height,
    MarkerAlignment align = markerAlignDef,
    Offset offset,
  }) {
    return MarkerLayer(
      latlngs.map((latlng) => M.Marker.from(latlng)).toList(),
      options: MarkerLayerOptions(
        icon: marker is MarkerIcon ? marker : null, 
        image: marker is MarkerImage ? marker : null, 
        widget: marker is Widget ? marker : null,
        opacity: opacity,
        size: size,
        width: width,
        height: height,
        align: align,
        offset: offset,
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  static CircleLayer Circle(dynamic circle, {
    num radius,
    num radiusInMeter,
    bool stroke = strokeDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthCircleDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = fillCircleDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) {
    var _circle = C.Circle.from(circle);
    var _center = _circle.latlng;
    _circle = C.Circle(_center, radius, radiusInMeter: radiusInMeter);

    return CircleLayer(
      _circle, 
      options: CircleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fill: fill,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static CircleLayer Circles(List<dynamic> circles, {
    num radius,
    num radiusInMeter,
    bool stroke = strokeDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthCircleDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = fillCircleDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) {
    return CircleLayer(
      circles.map((value) {
        C.Circle circle = C.Circle.from(value);
        if(radius != null && radius > 0.0) circle.radius = radius.toDouble();
        if(radiusInMeter != null && radiusInMeter > 0.0) circle.radiusInMeter = radiusInMeter.toDouble();
        return circle;
      }).toList(),
      options: CircleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fill: fill,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        interactive: interactive,
    ));
  }

  // ignore: non_constant_identifier_names
  static PolylineLayer Polyline(dynamic polyline, {
    bool stroke = strokeDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return PolylineLayer(
      PL.Polyline.from(polyline), 
      options: PolylineLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static PolylineLayer Polylines(List<dynamic> polylines, {
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return PolylineLayer(
      polylines.map((p) => PL.Polyline.from(p)).toList(), 
      options: PolylineLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static PolygonLayer Polygon(dynamic polygon, {
    bool stroke = strokePolygonDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthPolygonDef,
    double strokeOpacity = strokeOpacityPolygonDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return PolygonLayer(
      PG.Polygon.from(polygon), 
      options: PolygonLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static PolygonLayer Polygons(List<dynamic> polygons, {
    bool stroke = strokePolygonDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthPolygonDef,
    double strokeOpacity = strokeOpacityPolygonDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return PolygonLayer(
      polygons.map((p) => PG.Polygon.from(p)).toList(),
      options: PolygonLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static RectangleLayer Rectangle(dynamic rectangle, {
    bool stroke = strokeRectangleDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthRectangleDef,
    double strokeOpacity = strokeOpacityRectangleDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return RectangleLayer(
      R.Rectangle.from(rectangle),
      options: RectangleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static RectangleLayer Rectangles(List<dynamic> rectangles, {
    bool stroke = strokeRectangleDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthRectangleDef,
    double strokeOpacity = strokeOpacityRectangleDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) {
    return RectangleLayer(
      rectangles.map((r) => R.Rectangle.from(r)).toList(),
      options: RectangleLayerOptions(
        stroke: stroke,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        strokeOpacity: strokeOpacity,
        strokeCap: strokeCap,
        strokeJoin: strokeJoin,
        fillColor: fillColor,
        fillOpacity: fillOpacity,
        fillType: fillType,
        gradientStrokeColors: gradientStrokeColors,
        gradientStrokeStops: gradientStrokeStops,
        gradientFillColors: gradientFillColors,
        gradientFillStops: gradientFillStops,
        isDotted: isDotted,
        smoothFactor: smoothFactor,
        culling: culling,
        interactive: interactive,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static ImageOverlayLayer Image(dynamic image, {
    dynamic bounds,
    ImageProvider imagePlaceholder,
    ImageProvider imageError,
    double opacity = overlayOpacityDef,
    bool gaplessPlayback = overlayGaplessPlaybackDef,
    bool interactive = interactiveDef, 
    String attribution = attributionDef,
  }) {
    return ImageOverlayLayer(
      ImageOverlay.from(image, bounds),
      options: ImageOverlayOptions(
        imagePlaceholder: imagePlaceholder,
        imageError: imageError,
        opacity: opacity,
        gaplessPlayback: gaplessPlayback,
        interactive: interactive,
        attribution: attribution,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static ImageOverlayLayer Images(List<dynamic> images, {
    ImageProvider imagePlaceholder,
    ImageProvider imageError,
    double opacity = overlayOpacityDef,
    bool gaplessPlayback = overlayGaplessPlaybackDef,
    bool interactive = interactiveDef, 
    String attribution = attributionDef,
  }) {
    return ImageOverlayLayer(
      images.map((image) {
        if(image is ImageOverlay) {
          return image;
        }

        if(image is List && image.length == 2) {
          return ImageOverlay.from(image[0], image[1]);
        }
      }).toList(),
      options: ImageOverlayOptions(
        imagePlaceholder: imagePlaceholder,
        imageError: imageError,
        opacity: opacity,
        gaplessPlayback: gaplessPlayback,
        interactive: interactive,
        attribution: attribution,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static VideoOverlayLayer Video(dynamic video, [dynamic bounds]) {
    return VideoOverlayLayer(
      VideoOverlay.from(video, bounds),
    );
  }

  // ignore: non_constant_identifier_names
  static VideoOverlayLayer Videos(List<dynamic> videos) {
    return VideoOverlayLayer(
      videos.map((video) {
        if(video is VideoOverlay) {
          return video;
        }
        
        if(video is List && video.length == 2) {
          return VideoOverlay.from(video[0], video[1]);
        }
      }).toList(),
    );
  }

  // ignore: non_constant_identifier_names
  static GroupLayer Group(List<MapLayer> layers) {
    return GroupLayer(
      layers, 
      options: GroupLayerOptions(),
    );
  }
}