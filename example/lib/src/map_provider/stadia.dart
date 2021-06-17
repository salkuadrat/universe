import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class StadiaMap extends StatefulWidget {
  @override
  _StadiaMapState createState() => _StadiaMapState();
}

class _StadiaMapState extends State<StadiaMap> {
  StadiaType type = StadiaType.OSMOutdoors;

  @override
  Widget build(BuildContext context) {
    return U.StadiaMap(
      // use your own api key from https://stadiamaps.com
      apikey: '1ee476d7-6e86-4416-8f6c-b77b03b8f516',
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
              onChanged: (StadiaType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: StadiaType.AlidadeSmooth,
                  child: Text('Alidade Smooth'),
                ),
                DropdownMenuItem(
                  value: StadiaType.AlidadeSmoothDark,
                  child: Text('Alidade Smooth Dark'),
                ),
                DropdownMenuItem(
                  value: StadiaType.OSMBright,
                  child: Text('OSM Bright'),
                ),
                DropdownMenuItem(
                  value: StadiaType.OSMOutdoors,
                  child: Text('OSM Outdoors'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
