import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class OpenMap extends StatefulWidget {
  const OpenMap({super.key});

  @override
  OpenMapState createState() => OpenMapState();
}

class OpenMapState extends State<OpenMap> {
  OpenType type = OpenType.OpenTopoMap;

  bool get isSea => type == OpenType.OpenSeaMap;
  bool get isFire => type == OpenType.OpenFireMap;

  List get center {
    if (isSea) return [54.1878, 12.0915];
    if (isFire) return [48.136794, 11.574197];
    return [51.555158, -0.108343];
  }

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: center,
      zoom: 15,
      tiles: [U.OpenTileLayer(type: type)],
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (OpenType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: OpenType.OpenTopoMap,
                  child: Text('OpenTopoMap'),
                ),
                DropdownMenuItem(
                  value: OpenType.OpenSeaMap,
                  child: Text('OpenSeaMap'),
                ),
                DropdownMenuItem(
                  value: OpenType.OpenRailwayMap,
                  child: Text('OpenRailwayMap'),
                ),
                DropdownMenuItem(
                  value: OpenType.OpenFireMap,
                  child: Text('OpenFireMap'),
                ),
                /* DropdownMenuItem(
                  value: OpenType.OpenSnowMap,
                  child: Text('OpenSnowMap'),
                ),
                DropdownMenuItem(
                  value: OpenType.OpenAIP,
                  child: Text('OpenAIP'),
                ), */
              ],
            ),
          ),
        ),
      ],
    );
  }
}
