import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MarkerImageMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      markers: U.MarkerLayer(
        [
          [51.558374, -0.107398],
          [51.556674, -0.106215],
        ],
        widget: MarkerImage('assets/marker.png'),
        size: 48,
      ),
      layers: [
        U.MarkerLayer(
          [51.556669, -0.108123],
          widget: MarkerImage('https://i.ibb.co/ZTvXW1S/markerimg.png'),
          size: 48,
        ),
      ],
      onTap: print,
    );
  }
}
