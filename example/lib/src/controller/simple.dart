import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class ControllerMap extends StatefulWidget {
  @override
  _ControllerMapState createState() => _ControllerMapState();
}

class _ControllerMapState extends State<ControllerMap> {
  final _mapKey = UniqueKey();
  final _mapController = MapController();

  MapData? _mapData;

  void _listenPositionStream() {
    if (mounted)
      setState(() {
        _mapData = MapData(
          center: _mapController.center,
          zoom: _mapController.zoom!,
        );
      });
    // listen everytime the map data changes (move or zoom)
    _mapController.positionStream?.listen((data) {
      if (mounted)
        setState(() {
          _mapData = data;
        });
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
          onReady: () {
            _listenPositionStream(); // start listening after controller ready
          },
        ),
        if (_mapData != null)
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20, bottom: 90, right: 40),
              child: Material(
                elevation: 6,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Text(
                      'Center: ${_mapData!.center.toSimpleString()}\nZoom: ${_mapData!.zoom}'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
