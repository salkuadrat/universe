import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({super.key});

  @override
  State<OpenStreetMap> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  OpenStreetMapType type = OpenStreetMapType.HOT;

  get center {
    if (type == OpenStreetMapType.DE) return [48.136794, 11.574197];
    if (type == OpenStreetMapType.France) return [48.858236, 2.294477];
    if (type == OpenStreetMapType.HOT) return [48.858236, 2.294477];
    if (type == OpenStreetMapType.CH) return [47.3746272, 8.5175823];
    return [51.555158, -0.108343];
  }

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: center,
      type: type,
      zoom: 15,
      onTap: print,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (OpenStreetMapType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: OpenStreetMapType.Mapnik,
                  child: Text('Mapnik'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.DE,
                  child: Text('Germany (DE)'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.CH,
                  child: Text('Switzerland (CH)'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.France,
                  child: Text('France'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.HOT,
                  child: Text('Humanitarian (HOT)'),
                ),
                DropdownMenuItem(
                  value: OpenStreetMapType.BZH,
                  child: Text('Breton (BZH)'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
