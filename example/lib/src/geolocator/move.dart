// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MoveGeolocatorMap extends StatefulWidget {
  const MoveGeolocatorMap({super.key});

  @override
  _MoveGeolocatorMapState createState() => _MoveGeolocatorMapState();
}

class _MoveGeolocatorMapState extends State<MoveGeolocatorMap> {
  final _mapController = MapController();
  final _locationName = 'Highbury Square';

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _move() {
    // move map by location name
    _mapController.move(_locationName, zoom: 16.988, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.OpenStreetMap(
          controller: _mapController,
          // set map center by location name (not latlng)
          center: 'Emirates Stadium',
          zoom: 15,
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _move,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlue,
            ),
            child: Text('Move to $_locationName'),
          ),
        ),
      ],
    );
  }
}
