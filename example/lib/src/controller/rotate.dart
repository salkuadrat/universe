import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class RotateControllerMap extends StatefulWidget {
  @override
  _RotateControllerMapState createState() => _RotateControllerMapState();
}

class _RotateControllerMapState extends State<RotateControllerMap> {

  final _mapKey = UniqueKey();
  final _mapController = MapController();

  void _rotate90() {
    _mapController?.rotate(90, animate: true, onAnimateEnd: () {
      if(mounted) setState(() {});
    });
  }

  void _rotateBack() {
    _mapController?.rotate(0, animate: true, onAnimateEnd: () {
      if(mounted) setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        U.MapBox(
          key: _mapKey,
          type: MapBoxType.Hybrid,
          accessToken: yourAccessTokenHere,
          controller: _mapController,
          center: [51.555158, -0.108343],
          zoom: 15,
        ),
        Positioned(
          left: 20,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _mapController.rotation == 0.0 ? _rotate90 : _rotateBack,
            child: Text(
              _mapController.rotation == 0.0 
              ? 'Rotate 90 degrees'
              : 'Rotate Back'
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