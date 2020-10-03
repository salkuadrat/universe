import '../../core/core.dart';
import '../map.dart';

typedef MapChangedCallback = void Function(
  LatLng center,
  double zoom,
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
  void move(dynamic center, [double zoom]);

  void zoomTo(double zoom);

  /// Sets the map rotation to a certain degrees (in decimal, not radian).
  // void rotate(double rotation);

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [FitBoundsOptions] parameter.
  /// 
  /// can accept center: LatLngBounds([[20.0, 30.0], [10, 10]]) 
  /// LatLngBounds([LatLng(20.0, 30.0), LatLng(10.0, 10.0)]) 
  /// or [[20.0, 30.0], [10, 10]]
  void fitBounds(dynamic bounds, FitBoundsOptions options);

  void locate();

  set manager(MapStateManager manager);

  MapState get map;

  LatLngBounds get bounds;

  LatLng get center;

  double get zoom;

  double get rotation;

  MapChangedCallback onChanged;

  Stream<MapData> get positionStream;
  
  factory MapController() => UMapController();
  
}