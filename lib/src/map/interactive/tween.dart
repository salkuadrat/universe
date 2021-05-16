import 'package:flutter/animation.dart';

import '../../core/latlng/latlng.dart';

class LatLngTween extends Tween<LatLng> {
  LatLngTween({
    required LatLng? begin,
    required LatLng? end,
  }) : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) => LatLng(
        begin!.lat + (end!.lat - begin!.lat) * t,
        begin!.lng + (end!.lng - begin!.lng) * t,
      );
}
