import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class GoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  GoogleMapType type = GoogleMapType.Street;

  Scale get _scale {
    if (type == GoogleMapType.Satellite || type == GoogleMapType.Hybrid) {
      return Scale(color: Colors.white);
    }
    return Scale();
  }

  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      center: [51.555158, -0.108343],
      type: type,
      zoom: 16,
      scale: _scale,
      onReady: () => print('Google Map is ready!'),
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (GoogleMapType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: GoogleMapType.Street,
                  child: Text('Street'),
                ),
                DropdownMenuItem(
                  value: GoogleMapType.Satellite,
                  child: Text('Satellite'),
                ),
                DropdownMenuItem(
                  value: GoogleMapType.Hybrid,
                  child: Text('Hybrid'),
                ),
                DropdownMenuItem(
                  value: GoogleMapType.Terrain,
                  child: Text('Terrain'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
