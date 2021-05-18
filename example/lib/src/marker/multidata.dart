import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class MarkerData {
  final String name;
  final String description;

  MarkerData({
    required this.name,
    required this.description,
  });
}

class MultiMarkerWithDataMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      // multiple markers with different styles
      markers: U.MarkerLayer(
        [
          // default
          U.Marker([51.555158, -0.108343], data: 'Arsenal'),
          // marker icon
          U.Marker(
            [51.558374, -0.107398],
            widget: MarkerIcon(icon: Icons.location_on, color: Colors.red),
            data: 'Arsenal #1',
          ),
          // marker svg
          U.Marker(
            [51.556674, -0.106215],
            widget: MarkerSvg('assets/marker.svg', color: Colors.pink),
            data: 'Arsenal #2',
          ),
          // marker custom widget
          U.Marker(
            [51.556669, -0.108123],
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ARS'),
                SizedBox(height: 5),
                Icon(Icons.location_on, color: Colors.red, size: 28)
              ],
            ),
            data: 'Arsenal #3',
          ),
        ],
        onTap: (latlng, data) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data: $data'),
          ));
        },
      ),
    );
  }
}
