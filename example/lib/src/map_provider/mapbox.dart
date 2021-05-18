import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

import '../shared.dart';

class MapBox extends StatefulWidget {
  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  MapBoxType type = MapBoxType.Street;

  Scale get _scale {
    if (type == MapBoxType.Satellite ||
        type == MapBoxType.Hybrid ||
        type == MapBoxType.Dark) {
      return Scale(color: Colors.white);
    }
    return Scale();
  }

  @override
  Widget build(BuildContext context) {
    return U.MapBox(
        // get your own access token from https://account.mapbox.com/access-tokens/
        accessToken: yourAccessTokenHere,
        center: [51.555158, -0.108343],
        type: type,
        zoom: 15,
        scale: _scale,
        onReady: () => print('MapBox is ready!'),
        controls: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 90, bottom: 29),
              child: UDropdownButton(
                value: type,
                onChanged: (MapBoxType? chosen) {
                  setState(() {
                    if (chosen != null) {
                      type = chosen;
                    }
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: MapBoxType.Basic,
                    child: Text('Basic'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Street,
                    child: Text('Street'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Satellite,
                    child: Text('Satellite'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Hybrid,
                    child: Text('Hybrid'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Outdoors,
                    child: Text('Outdoors'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Dark,
                    child: Text('Dark'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: MapBoxType.Bright,
                    child: Text('Bright'),
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}
