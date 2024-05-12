import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class RotateStaticMap extends StatelessWidget {
  const RotateStaticMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      interactive: false,
      rotation: -45,
    );
  }
}
