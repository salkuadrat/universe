import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class GeoportailFranceMap extends StatefulWidget {
  const GeoportailFranceMap({super.key});

  @override
  State<GeoportailFranceMap> createState() => _GeoportailFranceMapState();
}

class _GeoportailFranceMapState extends State<GeoportailFranceMap> {
  GeoportailFranceType type = GeoportailFranceType.Plan;

  @override
  Widget build(BuildContext context) {
    return U.GeoportailFranceMap(
      // Please get and use your own API key from http://professionnels.ign.fr/ign/contrats/
      apikey: 'choisirgeoportail',
      center: [48.858236, 2.294477],
      type: type,
      zoom: 8,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (GeoportailFranceType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
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
