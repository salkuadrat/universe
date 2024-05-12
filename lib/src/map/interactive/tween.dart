import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/latlng/latlng.dart';

/// Tween animation between two [LatLng] values
///
/// [begin] - animate from this [LatLng] value
/// [end] - animate to this [LatLng] value
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
