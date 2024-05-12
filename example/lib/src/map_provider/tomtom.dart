import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class TomTomMap extends StatefulWidget {
  const TomTomMap({super.key});

  @override
  TomTomMapState createState() => TomTomMapState();
}

class TomTomMapState extends State<TomTomMap> {
  TomTomType type = TomTomType.Basic;

  @override
  Widget build(BuildContext context) {
    return U.TomTomMap(
      // Please get and use your own API key from https://developer.tomtom.com
      apikey: 'CiNkU6dezS1lWtDYotck4SGuOgdXWW0X',
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
              onChanged: (TomTomType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: TomTomType.Basic,
                  child: Text('Basic'),
                ),
                DropdownMenuItem(
                  value: TomTomType.Hybrid,
                  child: Text('Hybrid'),
                ),
                DropdownMenuItem(
                  value: TomTomType.Labels,
                  child: Text('Labels'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
