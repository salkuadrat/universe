import 'package:flutter/painting.dart';

import 'core/core.dart';
import 'layer/layer.dart';
import 'map/map.dart';
import 'shared.dart';

class U {
  static const CrsList CRS = const CrsList();

  static Universe map(dynamic center, {
    num zoom,
    double rotation,
    num minZoom,
    num maxZoom,
    MapController controller,
    LatLngBounds bounds,
    TileLayer base,
    MarkerLayer marker,
    List<SingleLayer> layers,
    Crs crs,
    Size size,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    Function onPositionChanged,
  }) {
    
    MapOptions options = MapOptions(
      crs: crs ?? CRS.EPSG3857,
      size: size,
      bounds: bounds,
      center: LatLng.from(center),
      zoomOptions: ZoomOptions(zoom: zoom ?? 13.0, minZoom: minZoom, maxZoom: maxZoom),
      rotation: rotation ?? 0.0,
      slideOnBoundaries: slideOnBoundaries ?? false,
      adaptiveBoundaries: adaptiveBoundaries ?? false,
      swPanBoundary: swPanBoundary,
      nePanBoundary: nePanBoundary,
      onTap: onTap,
      onLongPress: onLongPress,
      onPositionChanged: onPositionChanged,
    );

    return Universe(
      controller: controller,
      options: options,
      base: base,
      marker: marker,
      layers: layers ?? [],
    );
  }

  static TileLayer tile(String templateUrl, {
    dynamic subdomains = 'abc',
    num minZoom = 0,
    num maxZoom = 18,
    num zoomOffset = 0,
    String errorTileUrl = '',
    bool zoomReverse = false,
    bool crossOrigin = false,
    dynamic tileSize = 256,
    double opacity = 1.0,
    bool updateWhenZooming = true,
    num updateInterval = 200,
    LatLngBounds bounds,
    num minNativeZoom,
    num maxNativeZoom,
    num keepBuffer,
    String attribution,
  }) {
    return TileLayer(
      templateUrl, 
      subdomains: parseSubdomains(subdomains),
      options: TileLayerOptions(),
    );
  }

  static MarkerLayer marker(dynamic latlng, {
    num opacity = 1.0,
    Marker marker,
    MarkerIcon icon,
  }) {
    return MarkerLayer(
      options: MarkerLayerOptions(latlng, 
        marker: marker, 
        icon: icon, 
        opacity: opacity,
      ),
    );
  }

  static CircleLayer circle(dynamic latlng, num radius, {
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) {
    return CircleLayer(
      Circle(latlng, radius), 
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

  static CircleLayer circles(List<dynamic> circles, {
    num radius,
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) {
    return CircleLayer(
      circles.map((value) {
        Circle circle = Circle.from(value);
        if(radius != null && radius > 0.0) circle.radius = radius.toDouble();
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

  static PolylineLayer polyline(dynamic polyline) {
    return PolylineLayer(
      Polyline.from(polyline), 
      options: PolylineLayerOptions(),
    );
  }

  static PolylineLayer polylines(List<dynamic> polylines) {
    return PolylineLayer(
      polylines.map((polyline) => Polyline.from(polyline)).toList(), 
      options: PolylineLayerOptions(),
    );
  }

  static PolygonLayer polygon(dynamic polygon) {
    return PolygonLayer(
      Polygon.from(polygon), 
      options: PolygonLayerOptions(),
    );
  }

  static PolygonLayer polygons(List<dynamic> polygons) {
    return PolygonLayer(
      polygons.map((polygon) => Polygon.from(polygon)).toList(),
      options: PolygonLayerOptions(),
    );
  }

  static RectangleLayer rectangle(dynamic rectangle) {
    return RectangleLayer(
      Rectangle.from(rectangle),
      options: RectangleLayerOptions(),
    );
  }

  static RectangleLayer rectangles(List<dynamic> rectangles) {
    return RectangleLayer(
      rectangles.map((rectangle) => Rectangle.from(rectangle)).toList(),
      options: RectangleLayerOptions(),
    );
  }

  static ImageOverlayLayer image(dynamic image, [dynamic bounds]) {
    return ImageOverlayLayer(
      ImageOverlay.from(image, bounds),
    );
  }

  static ImageOverlayLayer images(List<dynamic> images) {
    return ImageOverlayLayer(
      images.map((image) {
        if(image is ImageOverlay) {
          return image;
        }

        if(image is List && image.length == 2) {
          return ImageOverlay.from(image[0], image[1]);
        }
      }).toList(),
    );
  }

  static VideoOverlayLayer video(dynamic video, [dynamic bounds]) {
    return VideoOverlayLayer(
      VideoOverlay.from(video, bounds),
    );
  }

  static VideoOverlayLayer videos(List<dynamic> videos) {
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

  static GroupLayer group(List<SingleLayer> layers) {
    return GroupLayer(
      layers, 
      options: GroupLayerOptions(),
    );
  }
}