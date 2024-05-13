import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class NASAGIBSMap extends StatefulWidget {
  const NASAGIBSMap({super.key});

  @override
  State<NASAGIBSMap> createState() => _NASAGIBSMapState();
}

class _NASAGIBSMapState extends State<NASAGIBSMap> {
  NASAGIBSType type = NASAGIBSType.ModisTerraTrueColorCR;

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 4,
      minZoom: 1,
      maxZoom: 7,
      tiles: [U.NASAGIBSTileLayer(type: type)],
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (NASAGIBSType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraTrueColorCR,
                  child: Text('ModisTerraTrueColorCR'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraBands367CR,
                  child: Text('ModisTerraBands367CR'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ViirsEarthAtNight2012,
                  child: Text('ViirsEarthAtNight2012'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraLSTDay,
                  child: Text('ModisTerraLSTDay'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraSnowCover,
                  child: Text('ModisTerraSnowCover'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraAOD,
                  child: Text('ModisTerraAOD'),
                ),
                DropdownMenuItem(
                  value: NASAGIBSType.ModisTerraChlorophyll,
                  child: Text('ModisTerraChlorophyll'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
