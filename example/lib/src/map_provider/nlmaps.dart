import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class NLMaps extends StatefulWidget {
  const NLMaps({super.key});

  @override
  NLMapsState createState() => NLMapsState();
}

class NLMapsState extends State<NLMaps> {
  NLMapsType type = NLMapsType.Default;

  @override
  Widget build(BuildContext context) {
    return U.NLMaps(
      center: [52, 5],
      minZoom: 6,
      maxZoom: 19,
      maxBounds: LatLngBounds.from([
        [50.5, 3.25],
        [54, 7.6]
      ]),
      type: type,
      zoom: 11,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (NLMapsType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: NLMapsType.Default,
                  child: Text('Default'),
                ),
                DropdownMenuItem(
                  value: NLMapsType.Pastel,
                  child: Text('Pastel'),
                ),
                DropdownMenuItem(
                  value: NLMapsType.Grijs,
                  child: Text('Grijs'),
                ),
                DropdownMenuItem(
                  value: NLMapsType.Luchtfoto,
                  child: Text('Luchtfoto'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
