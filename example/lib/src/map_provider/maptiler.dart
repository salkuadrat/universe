import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class MapTiler extends StatefulWidget {
  @override
  _MapTilerState createState() => _MapTilerState();
}

class _MapTilerState extends State<MapTiler> {
  MapTilerType type = MapTilerType.Default;

  @override
  Widget build(BuildContext context) {
    return U.MapTiler(
      apikey: '',
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
              onChanged: (MapTilerType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: MapTilerType.Default,
                  child: Text('Default'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Streets,
                  child: Text('Streets'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Basic,
                  child: Text('Basic'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Bright,
                  child: Text('Bright'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Pastel,
                  child: Text('Pastel'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Positron,
                  child: Text('Positron'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Hybrid,
                  child: Text('Hybrid'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Toner,
                  child: Text('Toner'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Topo,
                  child: Text('Topo'),
                ),
                DropdownMenuItem(
                  value: MapTilerType.Voyager,
                  child: Text('Voyager'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
