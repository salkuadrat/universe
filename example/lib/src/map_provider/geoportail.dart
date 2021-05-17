import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class GeoportailFranceMap extends StatefulWidget {
  @override
  _GeoportailFranceMapState createState() => _GeoportailFranceMapState();
}

class _GeoportailFranceMapState extends State<GeoportailFranceMap> {
  GeoportailFranceType type = GeoportailFranceType.Plan;

  @override
  Widget build(BuildContext context) {
    return U.GeoportailFranceMap(
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
              onChanged: (GeoportailFranceType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: GeoportailFranceType.Plan,
                  child: Text('Plan'),
                ),
                DropdownMenuItem(
                  value: GeoportailFranceType.Parcels,
                  child: Text('Parcels'),
                ),
                DropdownMenuItem(
                  value: GeoportailFranceType.Orthos,
                  child: Text('Orthos'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
