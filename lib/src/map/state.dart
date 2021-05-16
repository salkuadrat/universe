/* import 'dart:math' as math;
import 'package:flutter/rendering.dart';

import '../core/core.dart';
import '../shared.dart';
import 'map.dart';

class MapState {
  final MapController? controller;
  final MapOptions? options;
  final LatLng? center;
  final double? zoom;
  final double minZoom;
  final double maxZoom;
  final double rotation;
  final Size? size;

  /// current user's location from MapManager locate()
  LatLng? location;
  bool? isLocating = false;

  bool get isNotLocating => !isLocating!;

  Crs get crs => options!.crs;

  bool get hasCenter => center != null;
  bool get canRotate => options!.canRotate;
  bool get hasRotation => rotation > 0.0;
  bool get showCenterMarker => options!.showCenterMarker;
  bool get showLocationMarker => options!.showLocationMarker && location != null;

  dynamic get centerMarker => options!.centerMarker;
  dynamic get locationMarker => options!.locationMarker;

  double get angle => degToRadian(rotation);
  double get width => size!.width;
  double get height => size!.height;

  MapState({
    this.controller, 
    this.options,
    LatLng? center,
    this.location,
    this.isLocating,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    Size? size,
  }) : 
    this.center = center ?? options?.center,
    this.zoom = zoom ?? options?.zoomOptions.zoom,
    this.minZoom = minZoom ?? options?.zoomOptions.minZoom ?? minZoomDef,
    this.maxZoom = maxZoom ?? options?.zoomOptions.maxZoom ?? maxZoomDef,
    this.rotation = rotation ?? options?.rotation ?? 0.0,
    this.size = size ?? options!.size;

  void init() {
    assert(size != null);
    assert(zoom != null);
    assert(
      options!.slideOnBoundaries || 
      (options!.centerQuery != null && options!.centerQuery!.isNotEmpty) || 
      (center != null && !isOutOfBounds(center))
    );
    assert(!options!.adaptiveBoundaries || size != null, 'Size must be set in order to enable adaptive boundaries.');
    
    controller?.onReady = options!.onReady;
    controller?.onChanged = options!.onChanged;
  }
  
  MapState copyWith({
    MapController? controller,
    LatLng? center,
    LatLng? optionCenter,
    LatLngBounds? bounds,
    LatLng? location,
    bool? isLocating,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    Size? size,
  }) => MapState(
    controller: controller ?? this.controller,
    options: optionCenter != null 
      ? this.options!.copyWith(center: optionCenter) 
      : this.options,
    center: center ?? this.center,
    location: location ?? this.location,
    isLocating: isLocating ?? this.isLocating,
    zoom: zoom ?? this.zoom,
    minZoom: minZoom ?? this.minZoom,
    maxZoom: maxZoom ?? this.maxZoom, 
    rotation: rotation ?? this.rotation,
    size: size ?? this.size,
  );

  MapState withManager(MapStateManager manager) {
    MapController controller = this.controller!;
    //controller.manager = manager;
    return copyWith(controller: controller);
  }
  
  MapState withMinZoom(double minZoom) => copyWith(minZoom: minZoom);
  MapState withMaxZoom(double maxZoom) => copyWith(maxZoom: maxZoom);
  MapState updateLocation(LatLng? location) => copyWith(location: location);
  MapState startLocating() => copyWith(isLocating: true);
  MapState stopLocating() => copyWith(isLocating: false);

  //bool get hasBounds => options.hasBounds;
  bool get hasMaxBounds => options!.hasMaxBounds;
  LatLng? get swBound => options!.maxBounds?.southWest;
  LatLng? get neBound => options!.maxBounds?.northEast;

  Size get halfSize => size! / 2;
  UPoint get halfPoint => UPoint.from(halfSize);
  UPoint get centerPoint => project(center, zoom);
  
  /// Returns the projected pixel coordinates of the top left point of 
  /// the map layer (useful in custom layer and overlay implementations).
  UPoint get pixelOrigin => (centerPoint - halfPoint).round();

  UPoint getPixelOrigin(LatLng? center, [double? zoom]) {
    final centerPoint = project(center, zoom ?? this.zoom);
    return (centerPoint - halfPoint).round();
  }

  Bounds? getPixelWorldBounds(double? zoom) {
    return crs.getProjectedBounds(zoom ?? this.zoom);
  }

  Bounds get pixelBounds => getPixelBounds(center, zoom);

  Bounds getPixelBounds(LatLng? center, double? zoom) {
    double scale = getZoomScale(zoom, this.zoom);

    UPoint centerPoint = project(center, zoom).floor();
    UPoint offset = UPoint.from(halfSize / scale);

    return Bounds(centerPoint - offset, centerPoint + offset);
  }

  LatLngBounds get bounds {
    final bounds = pixelBounds;

    return LatLngBounds(
      unproject(bounds.bottomLeft),
      unproject(bounds.topRight),
    );
  }
  
  LatLngBounds wrapLatLngBounds(LatLngBounds latlngBounds) {
    return crs.wrapLatLngBounds(latlngBounds);
  }

  double limitZoom([double? zoom]) {
    return math.max(
      minZoom, 
      math.min(maxZoom, zoom ?? this.zoom!),
    );
  }

  UPoint project(LatLng? latlng, [double? zoom]) {
    return latlngToPoint(latlng, zoom ?? this.zoom);
  }

  UPoint latlngToPoint(LatLng? latlng, [double? zoom]) {
    return crs.latlngToPoint(latlng, zoom ?? this.zoom);
  }

  LatLng? unproject(UPoint point, [double? zoom]) {
    return pointToLatLng(point, zoom ?? this.zoom);
  }

  LatLng? pointToLatLng(UPoint point, [double? zoom]) {
    return crs.pointToLatLng(point, zoom ?? this.zoom);
  }

  UPoint offsetToPoint(Offset offset) {
    return UPoint(offset.dx, offset.dy);
  }

  Offset pointToOffset(UPoint point) {
    return Offset(point.x, point.y);
  }

  Size offsetToSize(Offset offset) {
    return Size(offset.dx, offset.dy);
  }

  Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  LatLng? offsetToLatLng(Offset offset, [double? width, double? height]) {
    width ??= size!.width;
    height ??= size!.height;
    
    UPoint point = offsetToPoint(offset);
    UPoint centerPoint = project(center);
    UPoint diffPoint = UPoint(
      (width / 2) - point.x, 
      (height / 2) - point.y,
    );

    return unproject(centerPoint - diffPoint);
  }

  /// Returns the scale factor to be applied to a map transition 
  /// from zoom level `fromZoom` to `toZoom`. 
  /// 
  /// Used internally to help with zoom animations.
  double getZoomScale(double? toZoom, [double? fromZoom]) {
    return crs.scale(toZoom)! / crs.scale(fromZoom ?? this.zoom)!;
  }

  /// Returns the zoom level that the map would end up at, 
  /// if it is at `fromZoom` level and everything is scaled 
  /// by a factor of `scale`. 
  /// 
  /// Inverse of [`getZoomScale`].
  double getScaleZoom(double scale, [double? fromZoom]) {
    return crs.zoom(scale * crs.scale(fromZoom ?? this.zoom)!);   
  }

  double getScaledZoom(double fromZoom, double scale) {
    final zoom = fromZoom + (math.log(scale) / math.ln2);
    return limitZoom(zoom);
  }

  bool isEqualZoom(double zoom, [double maxMargin = 0.005]) {
    return (this.zoom! - zoom).abs() <= maxMargin;
  }

  bool isNotEqualZoom(double zoom, [double maxMargin = 0.005]) {
    return !isEqualZoom(zoom, maxMargin);
  }

  MapData getBoundsCenterZoom(LatLngBounds bounds, FitBoundsOptions options) {
    UPoint paddingTL = UPoint(options.padding.left, options.padding.top);
    UPoint paddingBR = UPoint(options.padding.right, options.padding.bottom);

    double zoom = getBoundsZoom(bounds, paddingTL + paddingBR); 
    zoom = math.min(options.maxZoom, zoom);

    if(zoom == double.infinity) {
      return MapData(center: bounds.center, zoom: zoom);
    }

    UPoint swPoint = project(bounds.southWest, zoom);
    UPoint nePoint = project(bounds.northEast, zoom);
    UPoint offset = (paddingBR - paddingTL) / 2;

    UPoint centerPoint = ((swPoint + nePoint) / 2) + offset;
    LatLng? center = unproject(centerPoint, zoom);

    return MapData(center: center, zoom: zoom);
  }

  double getBoundsZoom(LatLngBounds bounds, UPoint padding, {bool inside=false}) {
    double zoom = this.zoom ?? 0.0;

    LatLng nw = bounds.northWest;
    LatLng se = bounds.southEast;

    Size size = this.size! - padding;
    Size boundsSize = Bounds(project(se, zoom), project(nw, zoom)).size;

    double scaleX = size.width / boundsSize.width;
    double scaleY = size.height / boundsSize.height;
    double scale = inside ? math.max(scaleX, scaleY) : math.min(scaleX, scaleY);
    
    double minZoom = this.minZoom;
    double maxZoom = this.maxZoom;
    zoom = getScaleZoom(scale, zoom);

    return math.max(minZoom, math.min(maxZoom, zoom));
  }
  
  double  get _widthInDegrees => 
    size!.width * (360 / math.pow(2, zoom! + 8));

  double get _heightInDegrees => 
    (size!.height * 170.102258) / math.pow(2, zoom! + 8);
  
  SafeBounds? _safeBoundsCache;
  double? _safeBoundsZoom;

  SafeBounds? get _safeBounds {
    if(_safeBoundsCache != null && _safeBoundsZoom == zoom) {
      return _safeBoundsCache;
    }

    if(hasMaxBounds) {
      final halfHeight = _heightInDegrees / 2;
      final halfWidth = _widthInDegrees / 2;
      
      final swLatitude = swBound!.lat + halfHeight;
      final swLongitude = swBound!.lng + halfWidth;
      final neLatitude = neBound!.lat - halfHeight;
      final neLongitude = neBound!.lng - halfWidth;
      
      _safeBoundsCache = SafeBounds(
        LatLng(swLatitude, swLongitude),
        LatLng(neLatitude, neLongitude),
      );
      
      _safeBoundsZoom = zoom;
    }

    return _safeBoundsCache;
  }

  //if center is out of bounds
  bool isOutOfBounds(LatLng? center) {
    if(center == null) {
      return true;
    }

    if(hasMaxBounds) {
      if(options!.adaptiveBoundaries) {
        return !_safeBounds!.contains(center);
      }

      bool isLatOutOfBounds =  
        (center.lat < swBound!.lat) || 
        (center.lat > neBound!.lat);
      
      bool isLngOutOfBounds = 
        (center.lng < swBound!.lng) || 
        (center.lng > neBound!.lng);
      
      if(isLatOutOfBounds || isLngOutOfBounds) {
        return true;
      }
    }

    return false;
  }

  LatLng safeCenter(LatLng center, LatLng defaultCenter) {
    if(hasMaxBounds) {
      if (options!.adaptiveBoundaries) {
        return _safeBounds!.containLatLng(center, defaultCenter);
      }

      return LatLng(
        center.lat.clamp(swBound!.lat, neBound!.lat),
        center.lng.clamp(swBound!.lng, neBound!.lng),
      );
    }
    
    return defaultCenter;
  }

  void onTap(LatLng? location) {
    options!.onTap?.call(location);
  }

  void onLongPress(LatLng? location) {
    options!.onLongPress?.call(location);
  }

  void onChanged(LatLng? center, double? zoom, double rotation) {
    controller!.onChanged?.call(center, zoom, rotation);
  }
} */
