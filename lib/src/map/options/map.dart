import 'package:flutter/widgets.dart';

import '../../control/control.dart';
import '../../core/crs/crs.dart';
import '../../core/geometry/size.dart';
import '../../core/latlng/latlng.dart';
import '../../layer/layer.dart';
import '../../shared.dart';
import '../map.dart';

class MapOptions {
  
  /// The [Coordinate Reference System] to use. 
  /// Don't change this if you're not sure what it means.
  final Crs crs;

  /// Size of container to show map on the screen.
  final Size? size;

  /// Initial geographic center of the map (by latlng position).
  final LatLng? center;

  /// Initial geographic center of the map (by location name).
  final String? centerQuery;

  /// Specified [ZoomOptions] to define [zoom], [minZoom], [maxZoom] and [zoomDelta]
  final ZoomOptions zoomOptions;

  /// Initial rotation of the map container.
  final double rotation;

  /// Disable gesture rotation on the map.
  final bool disableRotation;

  final dynamic centerMarker;

  final dynamic locationMarker;

  /// To define whether to show center marker (usually used for static map).
  final bool showCenterMarker;

  /// Whether the map automatically search for live user's location
  final bool live;

  final bool moveWhenLive;

  /// Whether to show locator button to use to search user's location when it's tapped.
  final bool showLocator;

  /// To define custom style and position of [Locator] on the screen.
  final Locator? locator;

  /// Whether to show location marker at the user's location 
  /// when live or locate by [locator]
  /// 
  /// Default to false when [showLocationIndicator] is true.
  final bool showLocationMarker;

  /// Whether to show location indicator at the user's location 
  /// when live or locate by [locator]
  final bool? showLocationIndicator;

  /// To define custom style and position of [LocationIndictor] on the screen.
  final LocationIndicator? locationIndicator;

  /// Whether to show compass to visualize current rotation of the map.
  final bool showCompass;

  /// To define custom style and position of [Compass] on the screen.
  final Compass? compass;

  /// Whether to show scale to indicate the current scale on the map.
  final bool showScale;

  /// To define custom style and position of [Scale] on the screen.
  final Scale? scale;

  /// Whether the map is interactive (can accept Gesture from user).
  /// Set it to [false] when you need static map.
  final bool interactive;

  final bool hideAttribution;

  /// When this option is set, the map restricts the view to the given 
  /// geographical bounds, bouncing the user back if the user tries to pan 
  /// outside the view.
  final LatLngBounds? maxBounds;
  final LatLngBounds? fitBounds;
  final FitBoundsOptions fitBoundsOptions;
  final bool slideOnBoundaries;
  final bool adaptiveBoundaries;
  final Function(LatLng?)? onTap;
  final Function(LatLng?)? onLongPress;
  final MapChangedCallback? onChanged;
  final Function? onReady;
  final String attribution;

  double get zoom => zoomOptions.zoom;
  double get minZoom => zoomOptions.minZoom;
  double get maxZoom => zoomOptions.maxZoom;
  double get zoomDelta => zoomOptions.zoomDelta;

  bool get hasSize => size != null;
  bool get noSize => size == null;
  bool get hasMaxBounds => maxBounds != null;
  bool get hasFitBounds => fitBounds != null;
  //bool get hasBounds => bounds != null;

  bool get hasCenter => center != null;
  bool get hasCenterQuery => centerQuery != null && centerQuery!.isNotEmpty;

  bool get notLive => !live;

  bool get canRotate => !disableRotation;

  MapOptions({
    this.crs = CRS.EPSG3857, 
    dynamic center,
    this.size,  
    ZoomOptions? zoomOptions,
    this.rotation = rotationDef, 
    this.disableRotation = disableRotationDef,
    this.showCenterMarker = showCenterMarkerDef,
    this.centerMarker = markerDef,
    this.live = liveDef,
    this.moveWhenLive = moveWhenLiveDef,
    this.showLocator = showLocatorDef,
    this.locator,
    this.locationMarker = markerDef,
    this.showLocationMarker = showLocationMarkerDef,
    this.showLocationIndicator,
    this.locationIndicator,
    this.showCompass = showCompassDef,
    this.compass,
    this.showScale = showScaleDef,
    this.scale,
    this.interactive = interactiveDef, 
    this.maxBounds,
    this.fitBounds,
    FitBoundsOptions? fitBoundsOptions,
    this.slideOnBoundaries = slideOnBoundariesDef, 
    this.adaptiveBoundaries = adaptiveBoundariesDef, 
    this.onTap, 
    this.onLongPress, 
    this.onChanged,
    this.onReady,
    this.attribution = attributionDef,
    this.hideAttribution = hideAttributionDef,
  }): 
    assert(
      center is LatLng || 
      center is String || 
      (
        center is List && 
        center.isNotEmpty && 
        (center.first is int || center.first is double)
      )
    ),
    this.center = (
      center is LatLng || 
      (
        center is List && 
        center.isNotEmpty && 
        (center.first is int || center.first is double)
      )
    ) ? LatLng.from(center) : null,
    this.centerQuery = center is String ? center : null,
    this.zoomOptions = zoomOptions ?? ZoomOptions(),
    this.fitBoundsOptions = fitBoundsOptions ?? FitBoundsOptions();
    
  MapOptions copyWith({
    Crs? crs,
    Size? size,
    dynamic center,
    ZoomOptions? zoomOptions,
    double? rotation,
    bool? disableRotation,
    bool? showCenterMarker,
    dynamic centerMarker,
    bool? live,
    bool? moveWhenLive,
    bool? showLocator,
    Locator? locator,
    dynamic locationMarker,
    bool? showLocationMarker,
    bool? showLocationIndicator,
    LocationIndicator? locationIndicator,
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
    Function(LatLng?)? onTap,
    Function(LatLng?)? onLongPress,
    MapChangedCallback? onChanged,
    Function? onReady,
    String? attribution,
    bool? hideAttribution,
  }) => MapOptions(
    crs: crs ?? this.crs,
    size: size ?? this.size,
    center: center ?? this.center ?? this.centerQuery,
    zoomOptions: zoomOptions ?? this.zoomOptions,
    rotation: rotation ?? this.rotation,
    disableRotation: disableRotation ?? this.disableRotation,
    showCenterMarker: showCenterMarker ?? this.showCenterMarker,
    centerMarker: centerMarker ?? this.centerMarker,
    locationMarker: locationMarker ?? this.locationMarker,
    live: live ?? this.live,
    moveWhenLive: moveWhenLive ?? this.moveWhenLive,
    locator: locator ?? this.locator,
    showLocator: showLocator ?? this.showLocator,
    locationIndicator: locationIndicator ?? this.locationIndicator,
    showLocationIndicator: showLocationIndicator ?? this.showLocationIndicator,
    showLocationMarker: showLocationMarker ?? this.showLocationMarker,
    compass: compass ?? this.compass,
    showCompass: showCompass ?? this.showCompass,
    scale: scale ?? this.scale,
    showScale: showScale ?? this.showScale,
    interactive: interactive ?? this.interactive,
    maxBounds: maxBounds ?? this.maxBounds,
    fitBounds: fitBounds ?? this.fitBounds,
    fitBoundsOptions: fitBoundsOptions ?? this.fitBoundsOptions,
    slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
    adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
    onTap: onTap ?? this.onTap,
    onLongPress: onLongPress ?? this.onLongPress,
    onChanged: onChanged ?? this.onChanged,
    onReady: onReady ?? this.onReady,
    attribution: attribution ?? this.attribution,
    hideAttribution: hideAttribution ?? this.hideAttribution,
  );
}