import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class LiveMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      type: GoogleMapType.Street,
      center: [-6.170039, 106.8241],
      zoom: 16,
      live: true,
      //showLocationIndicator: true, // default true when live true
      //showLocator: true, // default true
    );
  }
}