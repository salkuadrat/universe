import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class ZoomControllerMap extends StatefulWidget {
  @override
  _ZoomControllerMapState createState() => _ZoomControllerMapState();
}

class _ZoomControllerMapState extends State<ZoomControllerMap> {
  final _mapKey = UniqueKey();
  final _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _zoom() {
    // zoom to zoom level 17 with animation
    _mapController.zoomTo(17, animate: true);
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
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _zoom,
            child: Text('Zoom Map to zoom level 17'),
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
