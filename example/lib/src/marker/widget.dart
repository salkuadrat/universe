import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MarkerWidgetMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere, 
      center: [51.555158, -0.108343],
      zoom: 15,
      markers: U.MarkerLayer(
        [
          [51.558374, -0.107398],
          [51.556674, -0.106215],
        ],
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Arsenal'),
            SizedBox(height: 5),
            Icon(Icons.location_on, color: Colors.red, size: 28)
          ],
        ),
      ),
    );
  }
}