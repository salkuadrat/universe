import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MoveControllerMap extends StatefulWidget {
  const MoveControllerMap({super.key});

  @override
  MoveControllerMapState createState() => MoveControllerMapState();
}

class MoveControllerMapState extends State<MoveControllerMap> {
  final _mapKey = UniqueKey();
  final _mapController = MapController();

  final List<double> _moveTarget = [51.556674, -0.106215];
  final double _zoomTarget = 17;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _move() {
    // move to speficied latlng with zoom and animation
    _mapController.move(_moveTarget, zoom: _zoomTarget, animate: true);
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
          markers: U.MarkerLayer(_moveTarget),
        ),
        Positioned(
          left: 3,
          bottom: 90,
          child: ElevatedButton(
            onPressed: _move,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlue,
            ),
            child: const Text('Move to [51.556674, -0.106215] with zoom 17'),
          ),
        ),
      ],
    );
  }
}
