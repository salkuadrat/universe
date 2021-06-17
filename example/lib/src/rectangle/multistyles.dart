import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiRectangleStylesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253],
      zoom: 15,
      rectangles: U.RectangleLayer(
        [
          U.Rectangle(
            [
              [-6.183200, 106.823205],
              [-6.180427, 106.831809],
            ],
            strokeColor: Colors.yellow,
            fillColor: Colors.lightBlue,
          ),
          U.Rectangle(
            [
              [-6.177590, 106.825007],
              [-6.173344, 106.829234],
            ],
            strokeColor: Colors.red,
            fillColor: Colors.red,
          ),
          U.Rectangle(
            [
              [-6.171083, 106.823290],
              [-6.167542, 106.825307],
            ],
            strokeColor: Colors.orange,
            fillColor: Colors.teal,
          ),
        ],
        stroke: true,
        strokeWidth: 5,
        fillOpacity: 1.0,
      ),
    );
  }
}
