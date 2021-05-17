import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

// Replicating example starmap of Star Control II game from
// https://leafletjs.com/examples/crs-simple/crs-simple.html
class NonGeographicalMap extends StatelessWidget {
  // reverse latlng coordinate into xy
  List xy(latlng) {
    return [latlng[1], latlng[0]];
  }

  @override
  Widget build(BuildContext context) {
    return U.Map(crs: CRS.SIMPLE, zoom: 1, minZoom: -5, center: [
      70,
      120
    ], layers: [
      U.ImageOverlay(
        'assets/uqm_map_full.png',
        bounds: [
          [-26.5, -25],
          [1021.5, 1023]
        ],
      ),
      U.MarkerLayer([
        U.Marker(xy([175.2, 145.0]), data: 'Sol'),
        U.Marker(xy([41.6, 130.1]), data: 'Mizar'),
        U.Marker(xy([13.4, 56.5]), data: 'Krueger-Z'),
        U.Marker(xy([218.7, 8.3]), data: 'Deneb'),
      ], onTap: (latlng, data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data),
        ));
      }),
    ]);
  }
}
