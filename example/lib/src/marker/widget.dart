import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MarkerWidgetMap extends StatelessWidget {
  const MarkerWidgetMap({super.key});

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
        // marker with custom widget
        widget: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ARS'),
            Icon(Icons.location_on, color: Colors.red, size: 24)
          ],
        ),
      ),
    );
  }
}
