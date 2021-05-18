import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class HyddaMap extends StatefulWidget {
  @override
  _HyddaMapState createState() => _HyddaMapState();
}

class _HyddaMapState extends State<HyddaMap> {
  HyddaType type = HyddaType.Base;

  @override
  Widget build(BuildContext context) {
    return U.HyddaMap(
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
              onChanged: (HyddaType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: HyddaType.Base,
                  child: Text('Base'),
                ),
                DropdownMenuItem(
                  value: HyddaType.Full,
                  child: Text('Full'),
                ),
                DropdownMenuItem(
                  value: HyddaType.RoadsLabels,
                  child: Text('RoadsLabels'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
