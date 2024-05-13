import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class USGSMap extends StatefulWidget {
  const USGSMap({super.key});

  @override
  State<USGSMap> createState() => _USGSMapState();
}

class _USGSMapState extends State<USGSMap> {
  USGSType type = USGSType.Topo;

  @override
  Widget build(BuildContext context) {
    return U.USGSMap(
      center: [51.555158, -0.108343],
      type: type,
      zoom: 8,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (USGSType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: USGSType.Topo,
                  child: Text('Topo'),
                ),
                DropdownMenuItem(
                  value: USGSType.Imagery,
                  child: Text('Imagery'),
                ),
                DropdownMenuItem(
                  value: USGSType.ImageryTopo,
                  child: Text('Imagery Topo'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
