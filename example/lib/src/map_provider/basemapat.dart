import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class BasemapATMap extends StatefulWidget {
  @override
  _BasemapATMapState createState() => _BasemapATMapState();
}

class _BasemapATMapState extends State<BasemapATMap> {
  BasemapATType type = BasemapATType.Default;

  @override
  Widget build(BuildContext context) {
    return U.BasemapATMap(
      center: [51.555158, -0.108343],
      type: type,
      zoom: 16,
      onReady: () => print('Map is ready!'),
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (BasemapATType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: BasemapATType.Default,
                  child: Text('Default'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Grau,
                  child: Text('Grau'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Overlay,
                  child: Text('Overlay'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Terrain,
                  child: Text('Terrain'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Surface,
                  child: Text('Surface'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Hdpi,
                  child: Text('High DPI'),
                ),
                DropdownMenuItem(
                  value: BasemapATType.Orthofoto,
                  child: Text('Orthofoto'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
