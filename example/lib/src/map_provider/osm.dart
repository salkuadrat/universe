import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class OpenStreetMap extends StatefulWidget {
  @override
  _OpenStreetMapState createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {

  OpenStreetMapType type = OpenStreetMapType.Mapnik;

  get center {
    if(type == OpenStreetMapType.DE) return [48.136794, 11.574197];
    if(type == OpenStreetMapType.France) return [48.858236, 2.294477];
    if(type == OpenStreetMapType.HOT) return [48.858236, 2.294477];
    if(type == OpenStreetMapType.CH) return [47.3746272,8.5175823];
    return [51.555158, -0.108343];
  }
  
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: center,
      type: type,
      zoom: 15,
      onReady: () => print('Open Street Map is ready!'),
      onTap: print,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (chosen) {
                setState(() {
                  type = chosen;
                });
              },
              items: [
                DropdownMenuItem(
                  value: OpenStreetMapType.Mapnik,
                  child: Text('Mapnik'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.DE,
                  child: Text('DE'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.CH,
                  child: Text('CH'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.France,
                  child: Text('France'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.HOT,
                  child: Text('HOT'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.CyclOSM,
                  child: Text('CyclOSM'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.MtbMap,
                  child: Text('MtbMap'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.Wikimedia,
                  child: Text('Wikimedia'),
                ),
              ], 
            ),
          ),
        ),
      ],
    );
  }
}