import 'package:flutter/material.dart';
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
    return U.OpenWeatherMap(
      apikey: '',
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
                DropdownMenuItem(
                  value: OpenWeatherMapType.CloudsClassic,
                  child: Text('Clouds Classic'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Precipitation,
                  child: Text('Precipitation'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.PrecipitationClassic,
                  child: Text('Precipitation Classic'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Rain,
                  child: Text('Rain'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.RainClassic,
                  child: Text('Rain Classic'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Pressure,
                  child: Text('Pressure'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.PressureContour,
                  child: Text('Pressure Contour'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Wind,
                  child: Text('Wind'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Temperature,
                  child: Text('Temperature'),
                ),
                DropdownMenuItem(
                  value: OpenWeatherMapType.Snow,
                  child: Text('Snow'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
