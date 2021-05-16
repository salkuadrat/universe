import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiCircleWithDataMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253],
      zoom: 15,
      onReady: () => print('Map ready!'),
      // multiple circle layer with data, showing the data to snackbar when it's tapped
      circles: U.CircleLayer(
        [
          U.Circle(
            [-6.170039, 106.8241],
            radius: 120,
            data: 'Bicycle Palace',
          ),
          U.Circle(
            [-6.181552, 106.826938],
            radius: 150,
            strokeColor: Colors.red,
            strokeWidth: 0.8,
            fillColor: Colors.redAccent,
            fillOpacity: 0.4,
            data: 'National Library',
          ),
          U.Circle(
            [-6.176160, 106.821770],
            radius: 180,
            stroke: false,
            fillColor: Colors.orange,
            data: 'National Museum',
          ),
        ],
        onTap: (position, data) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome to $data'),
            ),
          );
        },
      ),
    );
  }
}
