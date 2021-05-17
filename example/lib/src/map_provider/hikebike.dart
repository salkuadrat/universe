import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class HikeBikeMap extends StatefulWidget {
  @override
  _HikeBikeMapState createState() => _HikeBikeMapState();
}

class _HikeBikeMapState extends State<HikeBikeMap> {
  HikeBikeType type = HikeBikeType.Default;

  @override
  Widget build(BuildContext context) {
    return U.HikeBikeMap(
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
              onChanged: (HikeBikeType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: HikeBikeType.Default,
                  child: Text('Hike Bike'),
                ),
                DropdownMenuItem(
                  value: HikeBikeType.Hill,
                  child: Text('Hike Bike Hill'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
