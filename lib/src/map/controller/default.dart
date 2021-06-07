import '../../core/core.dart';
import '../../shared.dart';
import '../map.dart';

class UMapController implements MapController {
  MapState? map;

  @override
  bool get isReady => map != null;

  @override
  void move(center, {double? zoom, bool animate = false}) {
    map?.move(center, zoom ?? map!.zoom, animate);
  }

  @override
  void zoomTo(double zoom, {bool animate = false}) {
    map?.zoomTo(zoom, animate);
  }

  @override
  void fitBounds(dynamic bounds, [FitBoundsOptions? options]) {
    map?.fitBounds(bounds, options);
  }

  void zoomIn([double zoomDelta = zoomDeltaDef]) {
    map?.zoomIn(zoomDelta);
  }

  void zoomOut([double zoomDelta = zoomDeltaDef]) {
    map?.zoomOut(zoomDelta);
  }

  @override
  void rotate(double rotation, {bool animate = false, Function? onAnimateEnd}) {
    map?.rotate(rotation, animate, onAnimateEnd);
  }

  @override
  Future<LatLng?> findLocation(String query) async {
    return await map?.findLocation(query);
  }

  @override
  Future<LatLng?> locate({bool automove = false, double toZoom = 17.0}) async {
    return await map?.locate(automove, toZoom);
  }

  @override
  LatLngBounds? get bounds => map?.bounds;

  @override
  LatLng? get center => map?.center;

  @override
  double? get zoom => map?.zoom;

  @override
  double? get rotation => map?.rotation;

  @override
  Function? onReady;

  @override
  MapChangedCallback? onChanged;

  @override
  Stream<MapData>? get positionStream => map?.positionStream.stream;

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

  @override
  double bearing(
    dynamic toDestination, {
    DistanceAlgorithmType algorithm = DistanceAlgorithmType.Haversine,
  }) {
    bool isVincenty = algorithm == DistanceAlgorithmType.Vincenty;
    Distance d = isVincenty ? DistanceVincenty() : DistanceHaversine();
    return d.bearing(map?.center, toDestination);
  }

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

  @override
  void dispose() {
    map?.dispose();
  }
}
