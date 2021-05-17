import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class JusticeMap extends StatefulWidget {
  @override
  _JusticeMapState createState() => _JusticeMapState();
}

class _JusticeMapState extends State<JusticeMap> {
  JusticeMapType type = JusticeMapType.Plural;

  @override
  Widget build(BuildContext context) {
    return U.JusticeMap(
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
              onChanged: (JusticeMapType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: JusticeMapType.Income,
                  child: Text('Income'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Indian,
                  child: Text('Indian'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Asian,
                  child: Text('Asian'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Black,
                  child: Text('Black'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Hispanic,
                  child: Text('Hispanic'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Multi,
                  child: Text('Multi'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Nonwhite,
                  child: Text('Nonwhite'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.White,
                  child: Text('White'),
                ),
                DropdownMenuItem(
                  value: JusticeMapType.Plural,
                  child: Text('Plural'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
