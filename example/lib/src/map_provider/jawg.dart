import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class JawgMap extends StatefulWidget {
  const JawgMap({super.key});

  @override
  JawgMapState createState() => JawgMapState();
}

class JawgMapState extends State<JawgMap> {
  JawgType type = JawgType.Streets;

  @override
  Widget build(BuildContext context) {
    return U.JawgMap(
      // Please get and use your own API key from https://www.jawg.io
      accessToken:
          'yN0ESgFsBwgdpSy0MoyaFsDI66mXptDz4cWH0wArMflMJCBK7TkuyjQY8OtqEViZ',
      center: [51.555158, -0.108343],
      type: type,
      zoom: 16,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (JawgType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
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
