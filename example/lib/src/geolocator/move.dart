import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MoveGeolocatorMap extends StatefulWidget {
  @override
  _MoveGeolocatorMapState createState() => _MoveGeolocatorMapState();
}

class _MoveGeolocatorMapState extends State<MoveGeolocatorMap> {
  final _mapController = MapController();
  final _locationName = 'Highbury Square';

  void _move() {
    // move map by location name
    _mapController.move(_locationName, zoom: 16.988, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.MapBox(
          controller: _mapController,
          type: MapBoxType.Hybrid,
          accessToken: yourAccessTokenHere,
          center:
              'Emirates Stadium', // set map center by location name (not latlng)
          zoom: 15,
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _move,
            child: Text('Move to $_locationName'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.lightBlue,
            ),
          ),
        ),
      ],
    );
  }
}
