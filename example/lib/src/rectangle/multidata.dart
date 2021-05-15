import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class DataClassExample {
  final String id;
  final String name;
  DataClassExample({this.id, this.name});
}

class MultiRectangleWithDataMap extends StatefulWidget {
  @override
  _MultiRectangleWithDataMapState createState() => _MultiRectangleWithDataMapState();
}

class _MultiRectangleWithDataMapState extends State<MultiRectangleWithDataMap> {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Hybrid,
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253], 
      zoom: 15,
      rectangles: U.RectangleLayer(
        [
          U.Rectangle(
            [
              [-6.183200,106.823205],
              [-6.180427,106.831809],
            ],
            strokeColor: Colors.yellow,
            fillColor: Colors.lightBlue,
            data: DataClassExample(
              id: 'LIB',
              name: 'National Library',
            ),
          ),
          U.Rectangle(
            [
              [-6.177590,106.825007],
              [-6.173344,106.829234],
            ],
            strokeColor: Colors.red,
            fillColor: Colors.red,
            data: DataClassExample(
              id: 'MON',
              name: 'National Monument',
            ),
          ),
          U.Rectangle(
            [
              [-6.171083,106.823290],
              [-6.167542,106.825307],
            ],
            strokeColor: Colors.orange,
            fillColor: Colors.teal,
            data: DataClassExample(
              id: 'PLC',
              name: 'Bicycle Palace',
            ),
          ),
        ],
        stroke: true,
        strokeWidth: 5,
        fillOpacity: 1.0,
        onTap: (position, data) {
          if(data is DataClassExample) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome to ${data.name}'),
              ),
            );
          }
        },
      ),
    );
  }
}