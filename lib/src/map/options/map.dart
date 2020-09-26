import '../../core/crs/crs.dart';
import '../../core/crs/crs.epsg3857.dart';
import '../../core/geometry/size.dart';
import '../../core/geometry/latlng_bounds.dart';
import '../../core/latlng/latlng.dart';
import 'zoom.dart';

class MapOptions {
  final Crs crs;
  final Size size;
  final LatLng center;
  final LatLngBounds bounds;
  final ZoomOptions zoomOptions;
  final double rotation;
  final bool interactive;
  final bool slideOnBoundaries;
  final bool adaptiveBoundaries;
  final LatLng swPanBoundary;
  final LatLng nePanBoundary;
  final Function(LatLng) onTap;
  final Function(LatLng) onLongPress;
  final Function onPositionChanged;

  MapOptions({
    this.crs = const Epsg3857(), 
    this.size, 
    this.center, 
    this.bounds, 
    ZoomOptions zoomOptions,
    this.rotation = 0.0, 
    this.interactive, 
    this.slideOnBoundaries = false, 
    this.adaptiveBoundaries = false, 
    this.swPanBoundary, 
    this.nePanBoundary, 
    this.onTap, 
    this.onLongPress, 
    this.onPositionChanged
  }): this.zoomOptions = zoomOptions ?? ZoomOptions();

  MapOptions copyWith({
    Crs crs,
    Size size,
    LatLng center,
    LatLngBounds bounds,
    ZoomOptions zoomOptions,
    double rotation,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    Function onPositionChanged,
  }) => MapOptions(
    crs: crs ?? this.crs,
    size: size ?? this.size,
    center: center ?? this.center,
    bounds: bounds ?? this.bounds,
    zoomOptions: zoomOptions ?? this.zoomOptions,
    rotation: rotation ?? this.rotation,
    interactive: interactive ?? this.interactive,
    slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
    adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
    swPanBoundary: swPanBoundary ?? this.swPanBoundary,
    nePanBoundary: nePanBoundary ?? this.nePanBoundary,
    onTap: onTap ?? this.onTap,
    onLongPress: onLongPress ?? this.onLongPress,
    onPositionChanged: onPositionChanged ?? this.onPositionChanged,
  );
}