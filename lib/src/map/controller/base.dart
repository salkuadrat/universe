import '../../core/core.dart';
import '../map.dart';

/// Type definition for onChanged callback function
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
  /// Moves the map to a specific location and zoom level.
  ///
  /// [center] can use format LatLng(20.0, 30.0) or [20.0, 30.0]
  /// [animate] set to true to move the map with animation. Default [false].
  void move(dynamic center, {double? zoom, bool animate = false});

  /// Zoom the map to a specific zoom level.
  ///
  /// [zoom] target zoom level
  /// [animate] set to true to zoom the map with animation. Default [false]
  void zoomTo(double zoom, {bool animate = false});

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [FitBoundsOptions] parameter.
  ///
  /// can accept center: LatLngBounds([[20.0, 30.0], [10, 10]])
  /// LatLngBounds([LatLng(20.0, 30.0), LatLng(10.0, 10.0)])
  /// or [[20.0, 30.0], [10, 10]]
  void fitBounds(dynamic bounds, FitBoundsOptions options);

  /// Rotate the map to a specific value.
  ///
  /// [rotation] target rotation of the map (in degrees)
  /// [animate] set to true to rotate with animation. Default [false]
  /// [onAnimateEnd] callback function to be called when rotation is finished
  void rotate(double rotation, {bool animate = false, Function? onAnimateEnd});

  /// Find LatLng location by address.
  ///
  /// [query] adress or location name
  Future<LatLng?> findLocation(String query);

  /// Find current LatLng user location
  ///
  /// [automove] is the map need to move automatically to current user location.
  ///            Default [false]
  /// [toZoom] target zoom level when [automove] is set to true
  Future<LatLng?> locate({bool automove = false, double toZoom = 17.0});

  /// Calculate distance between current center of the map with [toDestination].
  ///
  /// [toDestination] target location to calculate the distance
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  double distance(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  /// Calculate LatLng destination with [distance] and [bearing]
  /// from current center of the map.
  ///
  /// [distance] distance to be used to calculate LatLang destination
  /// [bearing] bearing to be used to calculate LatLang destination
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  LatLng destination(
    double distance,
    double bearing, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  });

  /// Calculate bearing from current center of the map to [toDestination].
  ///
  /// [toDestination] the destination location to calculate the bearing
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  double bearing(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  });

  /// Check if a specific [location] is inside the radius from
  /// current center of the map.
  ///
  /// [location] the location to be checked whether it's within a radius
  /// [radius] the radius to be used to check
  /// [algorithm] algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  /// [unit] unit of [radius]. Default in meters [LengthUnit.M]
  bool isInsideRadius(
    LatLng location,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  /// Filter [locations] to only contains LatLng within a specified [radius].
  ///
  /// [locations] list of LatLng locations to be filtered
  /// [radius] radius to be used to filter locations
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  /// [unit] unit of [radius]. Default in meters [LengthUnit.M]
  List<LatLng> filterInsideRadius(
    List<LatLng> locations,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  });

  /// dispose map controller
  void dispose();

  /// set map state
  set map(MapState? map);

  /// is map controller ready to be used
  bool get isReady;

  /// map state
  MapState? get map;

  /// map bounds
  LatLngBounds? get bounds;

  /// center of the map
  LatLng? get center;

  /// zoom level of the map
  double? get zoom;

  /// rotation of the map
  double? get rotation;

  /// callback function to be called when map controller is ready
  Function? onReady;

  /// callback function to be called when map state is changed
  MapChangedCallback? onChanged;

  /// stream to listen to current position of the map
  Stream<MapData>? get positionStream;

  Stream<LatLng>? get liveStream;

  /// default implementation of [MapController]
  factory MapController() => UMapController();
}
