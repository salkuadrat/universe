import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MoveControllerMap extends StatefulWidget {
  @override
  _MoveControllerMapState createState() => _MoveControllerMapState();
}

class _MoveControllerMapState extends State<MoveControllerMap> {

  final _mapKey = UniqueKey();
  final _mapController = MapController();

  List<double> _moveTarget = [51.556674, -0.106215];
  double _zoomTarget = 17;

  void _move() {
    // move to speficied latlng with zoom and animation
    _mapController.move(_moveTarget, zoom: _zoomTarget, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.MapBox(
          key: _mapKey,
          type: MapBoxType.Hybrid,
          controller: _mapController,
          accessToken: yourAccessTokenHere,
          center: [51.555158, -0.108343],
          zoom: 15,
          markers: U.MarkerLayer(_moveTarget),
        ),
        Positioned(
          left: 3,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _move,
            child: Text('Move to [51.556674, -0.106215] with zoom 17'),
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