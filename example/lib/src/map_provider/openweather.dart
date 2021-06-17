import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';
import 'package:universe_example/src/dropdown.dart';

class OpenWeatherMap extends StatefulWidget {
  @override
  _OpenWeatherMapState createState() => _OpenWeatherMapState();
}

class _OpenWeatherMapState extends State<OpenWeatherMap> {
  OpenWeatherMapType type = OpenWeatherMapType.Clouds;

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 5,
      tiles: [
        U.OpenWeatherMapTileLayer(
          type: type,
          apikey: '9de243494c0b295cca9337e1e96b00e2',
        ),
      ],
      controls: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(left: 90, bottom: 29),
            child: UDropdownButton(
              value: type,
              onChanged: (OpenWeatherMapType? chosen) {
                setState(() {
                  if (chosen != null) {
                    type = chosen;
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: OpenWeatherMapType.Clouds,
                  child: Text('Clouds'),
                ),
                /* DropdownMenuItem(
                  value: OpenWeatherMapType.GlobalPrecipitation,
                  child: Text('Global Precipitation'),
                ), */
                DropdownMenuItem(
                  value: OpenWeatherMapType.Pressure,
                  child: Text('Pressure'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.WindSpeed,
                  child: Text('Wind Speed'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Temperature,
                  child: Text('Temperature'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
