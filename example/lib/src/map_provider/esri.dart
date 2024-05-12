import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:example/src/dropdown.dart';

class EsriMap extends StatefulWidget {
  const EsriMap({super.key});

  @override
  EsriMapState createState() => EsriMapState();
}

class EsriMapState extends State<EsriMap> {
  EsriType type = EsriType.WorldStreetMap;

  @override
  Widget build(BuildContext context) {
    return U.EsriMap(
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
              onChanged: (EsriType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: EsriType.WorldStreetMap,
                  child: Text('World Street Map'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldImagery,
                  child: Text('World Imagery'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldTopoMap,
                  child: Text('World Topo Map'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldTerrain,
                  child: Text('World Terrain'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldShadedRelief,
                  child: Text('World Shaded Relief'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldPhysical,
                  child: Text('World Physical'),
                ),
                DropdownMenuItem(
                  value: EsriType.WorldGray,
                  child: Text('World Gray'),
                ),
                DropdownMenuItem(
                  value: EsriType.DeLorme,
                  child: Text('DeLorme'),
                ),
                DropdownMenuItem(
                  value: EsriType.OceanBasemap,
                  child: Text('Ocean Basemap'),
                ),
                DropdownMenuItem(
                  value: EsriType.NatGeoWorldMap,
                  child: Text('NatGeo World Map'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
