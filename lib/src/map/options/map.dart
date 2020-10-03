import '../../core/crs/crs.dart';
import '../../core/geometry/size.dart';
import '../../core/latlng/latlng.dart';
import '../../shared.dart';
import '../map.dart';

class MapOptions {
  
  final Crs crs;
  final Size size;
  final LatLng center;
  final LatLngBounds bounds;
  final FitBoundsOptions fitBoundsOptions;
  final ZoomOptions zoomOptions;
  final double rotation;
  final bool live;
  final bool locator;
  final bool interactive;
  final bool slideOnBoundaries;
  final bool adaptiveBoundaries;
  final LatLng swPanBoundary;
  final LatLng nePanBoundary;
  final Function(LatLng) onTap;
  final Function(LatLng) onLongPress;
  final MapChangedCallback onChanged;
  final String attribution;

  double get zoom => zoomOptions.zoom;
  double get minZoom => zoomOptions.minZoom;
  double get maxZoom => zoomOptions.maxZoom;
  double get zoomDelta => zoomOptions.zoomDelta;

  bool get hasSize => size != null;
  bool get noSize => size == null;
  bool get hasBounds => bounds != null;

  MapOptions({
    this.crs = const Epsg3857(), 
    this.size, 
    this.center, 
    this.bounds, 
    this.fitBoundsOptions = const FitBoundsOptions(),
    ZoomOptions zoomOptions,
    this.rotation = 0.0, 
    this.live = liveDef,
    this.locator = locatorDef,
    this.interactive = interactiveDef, 
    this.slideOnBoundaries = false, 
    this.adaptiveBoundaries = false, 
    this.swPanBoundary, 
    this.nePanBoundary, 
    this.onTap, 
    this.onLongPress, 
    this.onChanged,
    this.attribution = attributionDef,
  }): this.zoomOptions = zoomOptions ?? ZoomOptions();

  MapOptions copyWith({
    Crs crs,
    Size size,
    LatLng center,
    LatLngBounds bounds,
    ZoomOptions zoomOptions,
    double rotation,
    bool live,
    bool locator,
    bool interactive,
    bool slideOnBoundaries,
    bool adaptiveBoundaries,
    LatLng swPanBoundary,
    LatLng nePanBoundary,
    Function(LatLng) onTap,
    Function(LatLng) onLongPress,
    Function(LatLng, LatLngBounds, double, bool) onChanged,
    String attribution,
  }) => MapOptions(
    crs: crs ?? this.crs,
    size: size ?? this.size,
    center: center ?? this.center,
    bounds: bounds ?? this.bounds,
    zoomOptions: zoomOptions ?? this.zoomOptions,
    rotation: rotation ?? this.rotation,
    live: live ?? this.live,
    locator: locator ?? this.locator,
    interactive: interactive ?? this.interactive,
    slideOnBoundaries: slideOnBoundaries ?? this.slideOnBoundaries,
    adaptiveBoundaries: adaptiveBoundaries ?? this.adaptiveBoundaries,
    swPanBoundary: swPanBoundary ?? this.swPanBoundary,
    nePanBoundary: nePanBoundary ?? this.nePanBoundary,
    onTap: onTap ?? this.onTap,
    onLongPress: onLongPress ?? this.onLongPress,
    onChanged: onChanged ?? this.onChanged,
    attribution: attribution ?? this.attribution,
  );
}