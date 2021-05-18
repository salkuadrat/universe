import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class CustomScaleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      showLocator: true,
      onReady: () => print('Map is ready!'),
      scale: Scale(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(bottom: 64, left: 90),
        color: Colors.brown,
        fontSize: 14,
      ),
    );
  }
}
