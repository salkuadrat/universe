import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class CleanMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      // hide scale
      showScale: false,
      // hide compass
      showCompass: false,
      // hide locator
      showLocator: false,
      onReady: () => print('Map is ready!'),
    );
  }
}
