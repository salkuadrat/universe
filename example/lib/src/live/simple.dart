import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class SimpleLiveMap extends StatelessWidget {
  const SimpleLiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [-6.169976, 106.830979],
      zoom: 16,
      live: true,
      showLocationIndicator: false, // hide location indicator
      showLocator: false, // hide locator control
    );
  }
}
