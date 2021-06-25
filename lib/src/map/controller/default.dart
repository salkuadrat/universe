import '../../core/core.dart';
import '../../shared.dart';
import '../map.dart';

/// Default implementation of [MapController]
class UMapController implements MapController {
  /// map state
  MapState? map;

  /// is map controller is ready to be used
  @override
  bool get isReady => map != null;

  /// Moves the map to a specific location and zoom level.
  ///
  /// [center] can use format LatLng(20.0, 30.0) or [20.0, 30.0]
  /// [animate] set to true to move the map with animation. Default [false].
  @override
  void move(center, {double? zoom, bool animate = false}) {
    map?.move(center, zoom ?? map!.zoom, animate);
  }

  /// Zoom the map to a specific zoom level.
  ///
  /// [zoom] target zoom level
  /// [animate] set to true to zoom the map with animation. Default [false]
  @override
  void zoomTo(double zoom, {bool animate = false}) {
    map?.zoomTo(zoom, animate);
  }

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [FitBoundsOptions] parameter.
  ///
  /// can accept center: LatLngBounds([[20.0, 30.0], [10, 10]])
  /// LatLngBounds([LatLng(20.0, 30.0), LatLng(10.0, 10.0)])
  /// or [[20.0, 30.0], [10, 10]]
  @override
  void fitBounds(dynamic bounds, [FitBoundsOptions? options]) {
    map?.fitBounds(bounds, options);
  }

  /// Zoom in the map with a specified delta
  void zoomIn([double zoomDelta = zoomDeltaDef]) {
    map?.zoomIn(zoomDelta);
  }

  /// Zoom out the map with a specified delta
  void zoomOut([double zoomDelta = zoomDeltaDef]) {
    map?.zoomOut(zoomDelta);
  }

  /// Rotate the map to a specific value.
  ///
  /// [rotation] target rotation of the map (in degrees)
  /// [animate] set to true to rotate with animation. Default [false]
  /// [onAnimateEnd] callback function to be called when rotation is finished
  @override
  void rotate(double rotation, {bool animate = false, Function? onAnimateEnd}) {
    map?.rotate(rotation, animate, onAnimateEnd);
  }

  /// Find LatLng location by address.
  ///
  /// [query] adress or location name
  @override
  Future<LatLng?> findLocation(String query) async {
    return await map?.findLocation(query);
  }

  /// Find current LatLng user location
  ///
  /// [automove] is the map need to move automatically to current user location.
  ///            Default [false]
  /// [toZoom] target zoom level when [automove] is set to true
  @override
  Future<LatLng?> locate({bool automove = false, double toZoom = 17.0}) async {
    return await map?.locate(automove, toZoom);
  }

  /// map bounds
  @override
  LatLngBounds? get bounds => map?.bounds;

  /// center of the map
  @override
  LatLng? get center => map?.center;

  /// zoom level of the map
  @override
  double? get zoom => map?.zoom;

  /// rotation of the map
  @override
  double? get rotation => map?.rotation;

  /// callback function to be called when map controller is ready
  @override
  Function? onReady;

  /// callback function to be called when map state is changed
  @override
  MapChangedCallback? onChanged;

  /// stream to listen to current position of the map
  @override
  Stream<MapData>? get positionStream => map?.positionStream.stream;

  /// stream to listen to current live user position on the map
  @override
  Stream<LatLng>? get liveStream => map?.liveStream.stream;

  /// Calculate distance between current center of the map with [toDestination].
  ///
  /// [toDestination] target location to calculate the distance
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  @override
  double distance(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.distance(map?.center, toDestination, unit: unit);
  }

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
  @override
  LatLng destination(
    double distance,
    double bearing, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.offset(map?.center, distance, bearing);
  }

  /// Calculate bearing from current center of the map to [toDestination].
  ///
  /// [toDestination] the destination location to calculate the bearing
  /// [algorithm] calculation algorithm to be used.
  ///             Available values [DistanceAlgorithmType.Haversine] and
  ///             [DistanceAlgorithmType.Vincenty]
  ///
  ///             Default [DistanceAlgorithmType.Haversine]
  @override
  double bearing(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.bearing(map?.center, toDestination);
  }

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
  @override
  bool isInsideRadius(
    LatLng location,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    double distance = this.distance(location, algorithm: algorithm, unit: unit);
    return distance <= radius;
  }

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
  @override
  List<LatLng> filterInsideRadius(
    List<LatLng> locations,
    double radius, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
    LengthUnit unit = LengthUnit.M,
  }) {
    List<LatLng> result = [];

    for (LatLng location in locations) {
      if (isInsideRadius(location, radius, algorithm: algorithm, unit: unit)) {
        result.add(location);
      }
    }

    return result;
  }

  /// dispose map controller
  @override
  void dispose() {
    map?.close();
  }
}
