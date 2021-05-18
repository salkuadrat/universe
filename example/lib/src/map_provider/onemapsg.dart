import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class OneMapSG extends StatefulWidget {
  @override
  _OneMapSGState createState() => _OneMapSGState();
}

class _OneMapSGState extends State<OneMapSG> {
  OneMapSGType type = OneMapSGType.Default;

  @override
  Widget build(BuildContext context) {
    return U.OneMapSG(
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
              onChanged: (OneMapSGType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: OneMapSGType.Default,
                  child: Text('Default'),
                ),
                DropdownMenuItem(
                  value: OneMapSGType.Night,
                  child: Text('Night'),
                ),
                DropdownMenuItem(
                  value: OneMapSGType.Original,
                  child: Text('Original'),
                ),
                DropdownMenuItem(
                  value: OneMapSGType.Grey,
                  child: Text('Grey'),
                ),
                DropdownMenuItem(
                  value: OneMapSGType.LandLot,
                  child: Text('LandLot'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
