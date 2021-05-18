import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class HereMap extends StatefulWidget {
  @override
  _HereMapMapState createState() => _HereMapMapState();
}

class _HereMapMapState extends State<HereMap> {
  HereType type = HereType.BasicMap;

  @override
  Widget build(BuildContext context) {
    return U.HereMap(
      // Please get and use your own API key from https://developer.here.com
      appId: 'peafGBLTYaId8lBMBigq',
      appCode: 'nK1-DJEIaLkPsPt4hw4K_Q',
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
              onChanged: (HereType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: HereType.BasicMap,
                  child: Text('Basic Map'),
                ),
                DropdownMenuItem(
                  value: HereType.CarnavDayGrey,
                  child: Text('Carnav Day Grey'),
                ),
                DropdownMenuItem(
                  value: HereType.HybridDay,
                  child: Text('Hybrid Day'),
                ),
                DropdownMenuItem(
                  value: HereType.HybridDayGrey,
                  child: Text('Hybrid Day Grey'),
                ),
                DropdownMenuItem(
                  value: HereType.HybridDayMobile,
                  child: Text('Hybrid Day Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.HybridDayTraffic,
                  child: Text('Hybrid Day Traffic'),
                ),
                DropdownMenuItem(
                  value: HereType.HybridDayTransit,
                  child: Text('Hybrid Day Transit'),
                ),
                DropdownMenuItem(
                  value: HereType.MapLabels,
                  child: Text('Map Labels'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDay,
                  child: Text('Normal Day'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayCustom,
                  child: Text('Normal Day Custom'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayGrey,
                  child: Text('Normal Day Grey'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayGreyMobile,
                  child: Text('Normal Day Grey Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayMobile,
                  child: Text('Normal Day Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayTraffic,
                  child: Text('Normal Day Traffic'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayTransit,
                  child: Text('Normal Day Transit'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalDayTransitMobile,
                  child: Text('Normal Day Transit Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNight,
                  child: Text('Normal Night'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNightGrey,
                  child: Text('Normal Night Grey'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNightGreyMobile,
                  child: Text('Normal Night Grey Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNightMobile,
                  child: Text('Normal Night Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNightTransit,
                  child: Text('Normal Night Transit'),
                ),
                DropdownMenuItem(
                  value: HereType.NormalNightTransitMobile,
                  child: Text('Normal Night Transit Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.PedestrianDay,
                  child: Text('Pedestrian Day'),
                ),
                DropdownMenuItem(
                  value: HereType.PedestrianNight,
                  child: Text('Pedestrian Night'),
                ),
                DropdownMenuItem(
                  value: HereType.ReducedDay,
                  child: Text('Reduced Day'),
                ),
                DropdownMenuItem(
                  value: HereType.ReducedNight,
                  child: Text('Reduced Night'),
                ),
                DropdownMenuItem(
                  value: HereType.SatelliteDay,
                  child: Text('Satellite Day'),
                ),
                DropdownMenuItem(
                  value: HereType.TerrainDay,
                  child: Text('Terrain Day'),
                ),
                DropdownMenuItem(
                  value: HereType.TerrainDayMobile,
                  child: Text('Terrain Day Mobile'),
                ),
                DropdownMenuItem(
                  value: HereType.TrafficFlow,
                  child: Text('Traffic Flow'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
