import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MarkerWithDataMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      markers: U.MarkerLayer(
        [51.556669, -0.108123],
        data: 'Arsenal Football Club',
        onTap: (latlng, data) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data: $data'),
          ));
        },
      ),
      onReady: () => print('MapBox is ready!'),
    );
  }
}
