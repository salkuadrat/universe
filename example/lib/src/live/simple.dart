import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class SimpleLiveMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [-6.170039, 106.8241],
      zoom: 16,
      live: true,
      showLocationIndicator: false, // hide location indicator
      showLocator: false, // hide locator control
    );
  }
}