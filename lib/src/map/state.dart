import 'dart:math' as math;
import 'package:flutter/rendering.dart';

import '../core/crs/crs.dart';
import '../core/geometry/latlng_bounds.dart';
import '../core/geometry/bounds.dart';
import '../core/geometry/point.dart';
import '../core/geometry/size.dart';
import '../core/latlng/latlng.dart';
import '../core/geometry/zoom.dart';
import '../shared.dart';
import 'controller/base.dart';
import 'manager.dart';
import 'options/fitbounds.dart';
import 'options/map.dart';

class MapState {
  final MapController controller;
  final MapOptions options;

  final LatLng center;
  final LatLngBounds bounds;
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final double rotation;
  final Size size;

  Crs get crs => options.crs;

  bool get hasRotation => rotation != null && rotation > 0.0;
  double get angle => degToRadian(rotation);

  double get width => size.width;
  double get height => size.height;

  MapState({
    this.controller, 
    this.options,
    LatLng center,
    LatLngBounds bounds,
    double zoom,
    double minZoom,
    double maxZoom,
    double rotation,
    Size size,
  }) : center = center ?? options.center, 
      bounds = bounds ?? options.bounds,
      zoom = zoom ?? options.zoomOptions.zoom,
      minZoom = minZoom ?? options.zoomOptions.minZoom,
      maxZoom = maxZoom ?? options.zoomOptions.maxZoom,
      rotation = rotation ?? options.rotation,
      size = size ?? options.size;

  void check() {
    
  }
  
  MapState copyWith({
    MapController controller,
    LatLng center,
    LatLngBounds bounds,
    double zoom,
    double minZoom,
    double maxZoom,
    double rotation,
    Size size,
  }) => MapState(
    controller: controller ?? this.controller,
    options: this.options,
    center: center,
    bounds: bounds,
    zoom: zoom,
    minZoom: minZoom,
    maxZoom: maxZoom,
    rotation: rotation,
    size: size,
  );

  MapState withManager(MapManager manager) {
    MapController controller = this.controller;
    controller.manager = manager;
    return copyWith(controller: controller);
  }
  
  MapState withMinZoom(double minZoom) => copyWith(minZoom: minZoom);
  MapState withMaxZoom(double maxZoom) => copyWith(maxZoom: maxZoom);

  GeoPoint get centerPoint => GeoPoint.from(size / 2);
  GeoPoint get pixelCenterOrigin => getPixelCenterOrigin(center);

  GeoPoint getPixelCenterOrigin(LatLng center, [double zoom]) {
    zoom ??= this.zoom;
    return (project(center, zoom) - centerPoint).round();
  }

  Bounds getPixelWorldBounds(double zoom) {
    zoom ??= this.zoom;
    return options.crs.getProjectedBounds(zoom);
  }

  Bounds getPixelBounds(double zoom) {
    double scale = getZoomScale(zoom, this.zoom);

    GeoPoint centerPoint = project(center, zoom).floor();
    Size halfSize = size / (scale * 2);
    GeoPoint offset = GeoPoint.from(halfSize);

    return Bounds(centerPoint - offset, centerPoint + offset);
  }

  double limitZoom([double zoom]) {
    zoom ??= this.zoom;
    return math.max(minZoom, math.min(maxZoom, zoom));
  }

  GeoPoint project(LatLng position, [double zoom]) {
    zoom ??= this.zoom;
    return crs.latlngToPoint(position, zoom);
  }

  GeoPoint latlngToPoint(LatLng position) {
    return project(position);
  }

  LatLng unproject(GeoPoint point, [double zoom]) {
    zoom ??= this.zoom;
    return crs.pointToLatLng(point, zoom);
  }

  LatLng pointToLatLng(GeoPoint point) {
    return unproject(point);
  }

  GeoPoint offsetToPoint(Offset offset) {
    return GeoPoint(offset.dx, offset.dy);
  }

  Offset pointToOffset(GeoPoint point) {
    return Offset(point.x, point.y);
  }

  LatLng offsetToPosition(Offset offset, [double width, double height]) {
    width ??= size.width;
    height ??= size.height;

    GeoPoint mapCenter = project(center);
    GeoPoint localPoint = offsetToPoint(offset);
    GeoPoint localPointOffsetCenter = GeoPoint(
      (width / 2) - localPoint.x, 
      (height / 2) - localPoint.y,
    );

    return unproject(mapCenter - localPointOffsetCenter);
  }

  /// Returns the scale factor to be applied to a map transition 
  /// from zoom level `fromZoom` to `toZoom`. 
  /// 
  /// Used internally to help with zoom animations.
  double getZoomScale(double toZoom, [double fromZoom]) {
    fromZoom ??= zoom;
    return crs.scale(toZoom) / crs.scale(fromZoom);
  }

  /// Returns the zoom level that the map would end up at, 
  /// if it is at `fromZoom` level and everything is scaled 
  /// by a factor of `scale`. 
  /// 
  /// Inverse of [`getZoomScale`].
  double getScaleZoom(double scale, [double fromZoom]) {
    fromZoom ??= zoom;
    return crs.zoom(scale * crs.scale(fromZoom));   
  }

  double getScaledZoom(double fromZoom, double scale) {
    double zoom = fromZoom + (math.log(scale) / math.ln2);
    return limitZoom(zoom);
  }

  CenterZoom getBoundsCenterZoom(LatLngBounds bounds, FitBoundsOptions options) {
    UniversalPoint<double> paddingTL = UniversalPoint<double>(
      options.padding.left, options.padding.top);

    UniversalPoint<double> paddingBR = UniversalPoint<double>(
      options.padding.right, options.padding.bottom);

    double zoom = getBoundsZoom(bounds, paddingTL + paddingBR); 
    zoom = options.hasMaxZoom ? math.min(options.maxZoom, zoom) : zoom;

    if(zoom == double.infinity) {
      return CenterZoom(center: bounds.center, zoom: zoom);
    }

    GeoPoint swPoint = project(bounds.southWest, zoom);
    GeoPoint nePoint = project(bounds.northEast, zoom);
    UniversalPoint<double> offset = (paddingBR - paddingTL) / 2;

    GeoPoint centerPoint = ((swPoint + nePoint) / 2) + offset;
    LatLng center = unproject(centerPoint, zoom);

    return CenterZoom(center: center, zoom: zoom);
  }

  double getBoundsZoom(LatLngBounds bounds, UniversalPoint<double> padding, {bool inside=false}) {
    double zoom = this.zoom ?? 0.0;
    LatLng nw = bounds.northWest;
    LatLng se = bounds.southEast;

    Size size = Size.from(this.size - padding);
    Size boundsSize = Bounds(project(se, zoom), project(nw, zoom)).size;

    double scaleX = size.width / boundsSize.width;
    double scaleY = size.height / boundsSize.height;
    double scale = inside ? math.max(scaleX, scaleY) : math.min(scaleX, scaleY);
    
    double minZoom = this.minZoom ?? 0.0;
    double maxZoom = this.maxZoom ?? double.infinity;
    zoom = getScaleZoom(scale, zoom);

    return math.max(minZoom, math.min(maxZoom, zoom));
  }
}