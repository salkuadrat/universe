import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class JawgMap extends StatefulWidget {
  @override
  _JawgMapState createState() => _JawgMapState();
}

class _JawgMapState extends State<JawgMap> {
  JawgType type = JawgType.Streets;

  @override
  Widget build(BuildContext context) {
    return U.JawgMap(
      // Please get and use your own API key from https://www.jawg.io
      accessToken: 'XlZATO6aTUg6aQsBES8aebd7szoowRb2TUjE2aE7GVq4LrvKLu9evqYB7XTe1nLj',
      center: [51.555158, -0.108343],
      type: type,
      zoom: 16,
      onReady: () => print('Open Map is ready!'),
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (JawgType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: JawgType.Streets,
                  child: Text('Streets'),
                ),
                DropdownMenuItem(
                  value: JawgType.Terrain,
                  child: Text('Terrain'),
                ),
                DropdownMenuItem(
                  value: JawgType.Sunny,
                  child: Text('Sunny'),
                ),
                DropdownMenuItem(
                  value: JawgType.Dark,
                  child: Text('Dark'),
                ),
                DropdownMenuItem(
                  value: JawgType.Light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: JawgType.Matrix,
                  child: Text('Matrix'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
