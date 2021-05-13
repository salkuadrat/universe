import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class LiveMapWithMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [-6.170039, 106.8241],
      zoom: 16,
      live: true,
      showLocationMarker: true,
      //showLocationIndicator: false, // default false when showLocationMarker true
      //showLocator: true, // default true
    );
  }
}