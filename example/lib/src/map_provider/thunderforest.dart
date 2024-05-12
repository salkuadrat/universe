import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class ThunderforestMap extends StatefulWidget {
  const ThunderforestMap({super.key});

  @override
  ThunderforestMapState createState() => ThunderforestMapState();
}

class ThunderforestMapState extends State<ThunderforestMap> {
  ThunderforestType type = ThunderforestType.Outdoors;

  @override
  Widget build(BuildContext context) {
    return U.ThunderforestMap(
      // Please get and use your own API key from https://www.thunderforest.com
      apikey: '4c00aeebf2284054b8f72e7e18ce0d3c',
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
              onChanged: (ThunderforestType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: ThunderforestType.Cycle,
                  child: Text('Cycle'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Transport,
                  child: Text('Transport'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.TransportDark,
                  child: Text('Transport Dark'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Spinal,
                  child: Text('Spinal'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Landscape,
                  child: Text('Landscape'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Outdoors,
                  child: Text('Outdoors'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Pioneer,
                  child: Text('Pioneer'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.MobileAtlas,
                  child: Text('Mobile Atlas'),
                ),
                DropdownMenuItem(
                  value: ThunderforestType.Neighbourhood,
                  child: Text('Neighbourhood'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
