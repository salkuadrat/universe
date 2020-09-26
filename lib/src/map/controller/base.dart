import '../../core/geometry/latlng_bounds.dart';
import '../../core/latlng/latlng.dart';
import '../manager.dart';
import '../options/fitbounds.dart';
import '../state.dart';
import 'default.dart';

/// Controller to programmatically interact with [UMap].
///
/// It allows for map movement through [move], rotation through [rotate]
/// and to fit the map bounds with [fitBounds].
///
/// It also provides current map properties.
abstract class MapController {

  /// Moves the map to a specific location and zoom level
  /// can accept center: GeoPosition(20.0, 30.0) or center: [20.0, 30.0]
  void move(dynamic center, double zoom);

  /// Sets the map rotation to a certain degrees angle (in decimal).
  void rotate(double degree);

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [FitBoundsOptions] parameter.
  void fitBounds(LatLngBounds bounds, FitBoundsOptions options);

  set manager(MapManager manager);

  MapState get map;

  bool get isReady;

  Future<void> get onReady;

  LatLng get center;
  
  LatLngBounds get bounds;

  double get zoom;

  //ValueChanged<double> onRotationChanged;

  //Stream<MapPosition> get position;

  factory MapController() => UMapController();
}