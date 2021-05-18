import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class NLMaps extends StatefulWidget {
  @override
  _NLMapsState createState() => _NLMapsState();
}

class _NLMapsState extends State<NLMaps> {
  NLMapsType type = NLMapsType.Default;

  @override
  Widget build(BuildContext context) {
    return U.NLMaps(
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
              onChanged: (NLMapsType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
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
