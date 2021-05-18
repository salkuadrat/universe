import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class ImageOverlayMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [-6.175329, 106.827253],
      zoom: 15,
      showLocator: true,
      rectangles: U.RectangleLayer(
        [
          // to see star trek overlay bounds
          [
            [-6.17098, 106.825514],
            [-6.167775, 106.822867]
          ]
        ],
        fillOpacity: 0.5,
      ),
      images: [
        U.ImageOverlay(
          // from url
          'http://img.freeflagicons.com/thumb/background_with_square_parts/indonesia/indonesia_640.png',
          bounds: [
            [-6.180143, 106.823504],
            [-6.180344, 106.828948],
            [-6.17162, 106.82938],
            [-6.171958, 106.823674],
          ],
          fit: BoxFit.cover,
        ),
        U.ImageOverlay(
          'assets/startrek.png', // from assets
          bounds: [
            [-6.17098, 106.825514],
            [-6.167775, 106.822867],
          ],
        )
      ],
      onTap: print,
    );
  }
}
