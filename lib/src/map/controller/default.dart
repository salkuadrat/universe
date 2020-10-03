import '../../core/core.dart';
import '../../shared.dart';
import '../map.dart';

class UMapController implements MapController {

  MapStateManager _manager;

  set manager(MapStateManager manager) {
    _manager = manager;
  }

  @override 
  MapState get map => _manager?.state;

  @override
  void move(center, [double zoom]) {
    _manager?.move(center, zoom ?? this.zoom);
  }

  @override 
  void zoomTo(double zoom) {
    _manager?.zoom(zoom);
  }

  @override
  void fitBounds(dynamic bounds, [FitBoundsOptions options]) {
    _manager?.fitBounds(bounds, options);
  }

  void zoomIn([double zoomDelta = zoomDeltaDef]) {
    _manager?.zoomIn(zoomDelta);
  }

  void zoomOut([double zoomDelta = zoomDeltaDef]) {
    _manager?.zoomOut(zoomDelta);
  }

  @override 
  void locate() {
    _manager?.locate();
  }

  /* 
  void rotate(double rotation) {
    _manager?.rotate(rotation);
  } */

  @override
  LatLngBounds get bounds => _manager?.state?.bounds;

  @override
  LatLng get center => _manager?.state?.center;

  @override
  double get zoom => _manager?.state?.zoom;

  @override 
  double get rotation => _manager?.state?.rotation;

  @override 
  MapChangedCallback onChanged;

  @override 
  Stream<MapData> get positionStream => _manager?.positionStream?.stream;
  
}