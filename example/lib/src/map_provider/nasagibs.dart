import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class NASAGIBSMap extends StatefulWidget {
  @override
  _NASAGIBSMapState createState() => _NASAGIBSMapState();
}

class _NASAGIBSMapState extends State<NASAGIBSMap> {
  NASAGIBSType type = NASAGIBSType.ModisTerraTrueColorCR;

  @override
  Widget build(BuildContext context) {
    return U.NASAGIBSMap(
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
              onChanged: (NASAGIBSType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
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
