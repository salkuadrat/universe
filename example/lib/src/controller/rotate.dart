import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class RotateControllerMap extends StatefulWidget {
  const RotateControllerMap({super.key});

  @override
  State<RotateControllerMap> createState() => _RotateControllerMapState();
}

class _RotateControllerMapState extends State<RotateControllerMap> {
  final _mapKey = UniqueKey();
  final _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _rotate90() {
    _mapController.rotate(90, animate: true, onAnimateEnd: () {
      if (mounted) setState(() {});
    });
  }

  void _rotateBack() {
    _mapController.rotate(0, animate: true, onAnimateEnd: () {
      if (mounted) setState(() {});
    });
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
            onPressed:
                _mapController.rotation == 90.0 ? _rotateBack : _rotate90,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlue,
            ),
            child: Text(
              _mapController.rotation == 90.0
                  ? 'Rotate Back'
                  : 'Rotate 90 degrees',
            ),
          ),
        ),
      ],
    );
  }
}
