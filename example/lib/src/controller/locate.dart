import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class LocateControllerMap extends StatefulWidget {
  const LocateControllerMap({super.key});

  @override
  LocateControllerMapState createState() => LocateControllerMapState();
}

class LocateControllerMapState extends State<LocateControllerMap> {
  final _mapKey = UniqueKey();
  final _mapController = MapController();

  bool _isSearching = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

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

  Future _findLocation(context) async {
    _startSearching();

    LatLng? location = await _mapController.locate(automove: true);

    // this is only to show a nice transition between two loading text
    // do not use in production
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _stopSearching();

    final message = location != null
        ? 'Latlng: ${location.toSimpleString()}'
        : 'Location not found!';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.OpenStreetMap(
          key: _mapKey,
          controller: _mapController,
          center: [51.555158, -0.108343],
          zoom: 15,
          showLocationMarker: true,
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: () => _findLocation(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlue,
            ),
            child: Text(
              _isSearching ? 'Searching...' : 'Find your location',
            ),
          ),
        ),
      ],
    );
  }
}
