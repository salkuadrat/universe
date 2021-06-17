import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class CartoDBMap extends StatefulWidget {
  @override
  _CartoDBMapState createState() => _CartoDBMapState();
}

class _CartoDBMapState extends State<CartoDBMap> {
  CartoDBType type = CartoDBType.Positron;

  @override
  Widget build(BuildContext context) {
    return U.CartoDBMap(
      center: [51.555158, -0.108343],
      type: type,
      zoom: 16,
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (CartoDBType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: CartoDBType.Positron,
                  child: Text('Positron'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.PositronNoLabels,
                  child: Text('Positron No Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.PositronOnlyLabels,
                  child: Text('Positron Only Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.DarkMatter,
                  child: Text('Dark Matter'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.DarkMatterNoLabels,
                  child: Text('Dark Matter No Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.DarkMatterOnlyLabels,
                  child: Text('Dark Matter Only Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.Voyager,
                  child: Text('Voyager'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.VoyagerNoLabels,
                  child: Text('Voyager No Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.VoyagerOnlyLabels,
                  child: Text('Voyager Only Labels'),
                ),
                DropdownMenuItem(
                  value: CartoDBType.VoyagerLabelsUnder,
                  child: Text('Voyager Labels Under'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
