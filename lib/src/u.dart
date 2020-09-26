import 'package:flutter/painting.dart';

import 'core/crs/crs.dart';
import 'core/geometry/latlng_bounds.dart';
import 'core/geometry/size.dart';
import 'core/latlng/latlng.dart';
import 'layer/base/layer.dart';
import 'layer/circle/layer.dart';
import 'layer/circle/marker.dart';
import 'layer/circle/options.dart';
import 'layer/group/layer.dart';
import 'layer/group/options.dart';
import 'layer/image/layer.dart';
import 'layer/marker/icon.dart';
import 'layer/marker/layer.dart';
import 'layer/marker/marker.dart';
import 'layer/marker/options.dart';
import 'layer/polygon/layer.dart';
import 'layer/polygon/marker.dart';
import 'layer/polygon/options.dart';
import 'layer/polyline/layer.dart';
import 'layer/polyline/marker.dart';
import 'layer/polyline/options.dart';
import 'layer/rectangle/layer.dart';
import 'layer/rectangle/marker.dart';
import 'layer/rectangle/options.dart';
import 'layer/tile/layer.dart';
import 'layer/tile/options.dart';
import 'layer/video/layer.dart';
import 'map/controller/base.dart';
import 'map/options/map.dart';
import 'map/universe.dart';
import 'map/options/zoom.dart';

class U {
  static const CrsList CRS = const CrsList();

  static Universe map(dynamic center, {
    num zoom = 13.0,
    double rotation = 0.0,
    num minZoom,
    num maxZoom,
    MapController controller,
    LatLngBounds bounds,
    TileLayer baseLayer,
    MarkerLayer marker,
    List<UniverseLayer> layers,
    Crs crs,
    Size size,
    bool slideOnBoundaries = false,
    bool adaptiveBoundaries = false,
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
      zoomOptions: ZoomOptions(zoom: zoom, minZoom: minZoom, maxZoom: maxZoom),
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
      baseLayer: baseLayer,
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
      options: TileLayerOptions(templateUrl),
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
    bool stroke = true,
    Color color,
    num weight = 3,
    double opacity = 1.0,
    String lineCap = 'round',
    String lineJoin = 'round',
    bool fill,
    Color fillColor,
    double fillOpacity = 0.2,
    String fillRule = 'evenodd',
    bool interactive = true,
    String attribution,
  }) {
    return CircleLayer(
      options: CircleLayerOptions(Circle(latlng, radius)),
    );
  }

  static CirclesLayer circles(List<Circle> circles, {num radius}) {
    circles.forEach((circle) { 
      if(radius != null && radius > 0.0) {
        circle.radius = radius.toDouble();
      }
    });
    return CirclesLayer(options: CirclesLayerOptions(circles));
  }

  static PolylineLayer polyline(Polyline polyline, {bool culling=false}) {
    return PolylineLayer(options: PolylineLayerOptions(polyline, culling: culling));   
  }

  static MultiPolylineLayer polylines(List<Polyline> polylines, {bool culling=false}) {
    return MultiPolylineLayer(
      options: MultiPolylineLayerOptions(polylines, culling: culling),
    );   
  }

  static PolygonLayer polygon(Polygon polygon) {
    return PolygonLayer(
      options: PolygonLayerOptions(polygon),
    );
  }

  static MultiPolygonLayer polygons(List<Polygon> polygons) {
    return MultiPolygonLayer(
      options: MultiPolygonLayerOptions(polygons),
    );
  }

  static RectangleLayer rectangle(Rectangle rectangle) {
    return RectangleLayer(
      options: RectangleLayerOptions(rectangle),
    );
  }

  static MultiRectangleLayer rectangles(List<Rectangle> rectangles) {
    return MultiRectangleLayer(
      options: MultiRectangleLayerOptions(rectangles),
    );
  }

  static ImageOverlay image() {
    return ImageOverlay();
  }

  static VideoOverlay video() {
    return VideoOverlay();
  }

  static GroupLayer group(List<UniverseLayer> layers) {
    return GroupLayer(options: GroupLayerOptions(layers));
  }
}