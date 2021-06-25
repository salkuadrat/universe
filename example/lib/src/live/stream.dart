import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class LiveStreamMap extends StatefulWidget {
  const LiveStreamMap({Key? key}) : super(key: key);

  @override
  _LiveStreamMapState createState() => _LiveStreamMapState();
}

class _LiveStreamMapState extends State<LiveStreamMap> {
  MapController _mapController = MapController();
  StreamSubscription<LatLng>? _liveSubs;

  // listen to live user location on the map
  void _listenToLiveStream() {
    _liveSubs = _mapController.liveStream?.listen((latlng) {
      print('Current location: $latlng');
    });
  }

  @override
  void dispose() {
    _liveSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      controller: _mapController,
      center: [-6.169976, 106.830979],
      zoom: 16,
      live: true,
      onReady: () {
        _listenToLiveStream();
      },
    );
  }
}
