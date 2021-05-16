import '../../core/core.dart';
import '../map.dart';

typedef MapChangedCallback = void Function(
  LatLng? center,
  double? zoom,
  double rotation,
);

/// Controller to programmatically interact with [UMap].
///
/// It allows for map movement through [move], rotation through [rotate]
/// and to fit the map bounds with [fitBounds].
///
/// It also provides current map properties.
abstract class MapController {
  /// Moves the map to a specific location and zoom level
  /// can accept center: LatLng(20.0, 30.0) or center: [20.0, 30.0]
  void move(dynamic center, {double? zoom, bool animate = false});

  void zoomTo(double zoom, {bool animate = false});

  /// Sets the map rotation to a certain degrees (in decimal, not radian).
  // void rotate(double rotation);

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [FitBoundsOptions] parameter.
  ///
  /// can accept center: LatLngBounds([[20.0, 30.0], [10, 10]])
  /// LatLngBounds([LatLng(20.0, 30.0), LatLng(10.0, 10.0)])
  /// or [[20.0, 30.0], [10, 10]]
  void fitBounds(dynamic bounds, FitBoundsOptions options);

  void rotate(double rotation, {bool animate = false, Function? onAnimateEnd});

  Future<LatLng?> findLocation(String query);

  Future<LatLng?> locate({bool automove = false, double toZoom = 17.0});

  double distance(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  LatLng destination(
    double distance,
    double bearing, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  });

  double bearing(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  });

  bool isInsideRadius(
    LatLng location,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  List<LatLng> filterInsideRadius(
    List<LatLng> locations,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  set map(MapStates? map);

  bool get isReady;

  MapStates? get map;

  LatLngBounds? get bounds;

  LatLng? get center;

  double? get zoom;

  double? get rotation;

  Function? onReady;

  MapChangedCallback? onChanged;

  Stream<MapData>? get positionStream;

  factory MapController() => UMapController();
}
