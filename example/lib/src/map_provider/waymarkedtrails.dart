import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class WaymarkedTrailsMap extends StatefulWidget {
  const WaymarkedTrailsMap({super.key});

  @override
  WaymarkedTrailsMapState createState() => WaymarkedTrailsMapState();
}

class WaymarkedTrailsMapState extends State<WaymarkedTrailsMap> {
  WaymarkedTrailsType type = WaymarkedTrailsType.Cycling;

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      tiles: [
        U.WaymarkedTrailsTileLayer(type: type),
      ],
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (WaymarkedTrailsType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: WaymarkedTrailsType.Cycling,
                  child: Text('Cycling'),
                ),
                DropdownMenuItem(
                  value: WaymarkedTrailsType.Hiking,
                  child: Text('Hiking'),
                ),
                DropdownMenuItem(
                  value: WaymarkedTrailsType.MTB,
                  child: Text('MTB'),
                ),
                DropdownMenuItem(
                  value: WaymarkedTrailsType.Riding,
                  child: Text('Riding'),
                ),
                DropdownMenuItem(
                  value: WaymarkedTrailsType.Skating,
                  child: Text('Skating'),
                ),
                DropdownMenuItem(
                  value: WaymarkedTrailsType.Slopes,
                  child: Text('Slopes'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
