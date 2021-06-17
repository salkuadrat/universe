import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class StaticMapWithMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      interactive: false,
      showCenterMarker: true,
    );
  }
}
