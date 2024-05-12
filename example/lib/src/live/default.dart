import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class LiveMap extends StatelessWidget {
  const LiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      type: GoogleMapType.Street,
      center: [-6.169976, 106.830979],
      zoom: 16,
      live: true,
    );
  }
}
