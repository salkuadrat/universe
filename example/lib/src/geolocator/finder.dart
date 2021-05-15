import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class LocationFinderMap extends StatefulWidget {
  @override
  _LocationFinderMapState createState() => _LocationFinderMapState();
}

class _LocationFinderMapState extends State<LocationFinderMap> {

  final _mapKey = UniqueKey();
  final _mapController = MapController();
  final _locationName = 'Highbury Square';

  bool _isSearching = false;

  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
    });
  }

  Future _findLocation() async {
    _startSearching();

    LatLng? location = await _mapController.findLocation(_locationName);

    // this is only to show a nice transition between two loading text
    // do not use in production
    await Future.delayed(Duration(milliseconds: 500));
    
    _stopSearching();

    final message = location != null 
      ? 'Latlng: ${location.toSimpleString()}' 
      : 'Location not found!';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.MapBox(
          key: _mapKey,
          controller: _mapController,
          type: MapBoxType.Bright,
          accessToken: yourAccessTokenHere,
          center: 'Emirates Stadium', // set map center by location name (not latlng)
          zoom: 16,
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _findLocation,
            child: Text(_isSearching 
              ? 'Searching...' 
              : 'Find latlng for $_locationName'
            ),
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