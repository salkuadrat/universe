import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class InitialRotationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      rotation: 72,
    );
  }
}
