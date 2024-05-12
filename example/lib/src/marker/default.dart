import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class DefaultMarkerMap extends StatelessWidget {
  const DefaultMarkerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      markers: U.MarkerLayer([51.556669, -0.108123]),
    );
  }
}
