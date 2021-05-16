import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class GeolocatorMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Light,
      accessToken: yourAccessTokenHere,
      center:
          'Emirates Stadium', // set map center by location name (not latlng)
      zoom: 15,
    );
  }
}
