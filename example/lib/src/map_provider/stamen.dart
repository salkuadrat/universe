import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class StamenMap extends StatefulWidget {
  @override
  _StamenMapState createState() => _StamenMapState();
}

class _StamenMapState extends State<StamenMap> {
  StamenType type = StamenType.Toner;

  @override
  Widget build(BuildContext context) {
    return U.StamenMap(
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
              onChanged: (StamenType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: StamenType.Toner,
                  child: Text('Toner'),
                ),
                DropdownMenuItem(
                  value: StamenType.TonerBackground,
                  child: Text('Toner Background'),
                ),
                DropdownMenuItem(
                  value: StamenType.TonerHybrid,
                  child: Text('Toner Hybrid'),
                ),
                DropdownMenuItem(
                  value: StamenType.TonerLines,
                  child: Text('Toner Lines'),
                ),
                DropdownMenuItem(
                  value: StamenType.TonerLabels,
                  child: Text('Toner Labels'),
                ),
                DropdownMenuItem(
                  value: StamenType.TonerLite,
                  child: Text('Toner Lite'),
                ),
                DropdownMenuItem(
                  value: StamenType.Watercolor,
                  child: Text('Watercolor'),
                ),
                DropdownMenuItem(
                  value: StamenType.Terrain,
                  child: Text('Terrain'),
                ),
                DropdownMenuItem(
                  value: StamenType.TerrainBackground,
                  child: Text('Terrain Background'),
                ),
                DropdownMenuItem(
                  value: StamenType.TerrainLabels,
                  child: Text('Terrain Labels'),
                ),
                DropdownMenuItem(
                  value: StamenType.Relief,
                  child: Text('Relief'),
                ),
                DropdownMenuItem(
                  value: StamenType.TopOSMRelief,
                  child: Text('Top OSM Relief'),
                ),
                DropdownMenuItem(
                  value: StamenType.TopOSMFeatures,
                  child: Text('Top OSM Features'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
