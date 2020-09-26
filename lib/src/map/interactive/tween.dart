import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

import '../../core/latlng/latlng.dart';

class GeoPositionTween extends Tween<LatLng> {
  GeoPositionTween({
    @required LatLng begin, 
    @required LatLng end,
  }) : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) => LatLng(
    begin.lat + (end.lat - begin.lat) * t, 
    begin.lng + (end.lng - begin.lng) * t,
  );
}