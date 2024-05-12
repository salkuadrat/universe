import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class LiveMapWithMarker extends StatelessWidget {
  const LiveMapWithMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [-6.169976, 106.830979],
      zoom: 16,
      live: true,
      showLocationMarker: true,
      //showLocationIndicator: false, // default false when showLocationMarker true
      //showLocator: true, // default true
    );
  }
}
