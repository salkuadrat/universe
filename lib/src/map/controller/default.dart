import 'dart:async';

import '../../core/geometry/latlng_bounds.dart';
import '../../core/latlng/latlng.dart';
import '../../map/manager.dart';
import '../options/fitbounds.dart';
import '../state.dart';
import 'base.dart';

class UMapController implements MapController {
  final Completer<Null> _ready = Completer<Null>();

  MapManager _manager;

  set manager(MapManager manager) {
    _manager = manager;

    if(!_ready.isCompleted) {
      _ready.complete();
    }
  }

  @override 
  MapState get map => _manager?.state;

  @override
  Future<void> get onReady => _ready.future;

  @override
  void move(center, double zoom) {
    _manager?.move(center, zoom);
  }

  @override
  void fitBounds(dynamic bounds, [FitBoundsOptions options]) {
    _manager?.fitBounds(bounds, options);
  }

  @override
  void rotate(double degree) {
    _manager?.rotate(degree);
  }

  @override
  bool get isReady => _manager != null && _manager.state != null;

  @override
  LatLngBounds get bounds => _manager?.state?.bounds;

  @override
  LatLng get center => _manager?.state?.center;

  @override
  double get zoom => _manager?.state?.zoom;

  /* @override
  ValueChanged<double> onRotationChanged;

  @override
  Stream<MapPosition> get position => throw UnimplementedError(); */
}