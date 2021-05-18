import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class DataClassExample {
  final String id;
  final String name;

  DataClassExample({
    required this.id,
    required this.name,
  });
}

class MultiPolygonWithDataMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      polygons: U.PolygonLayer(
        // list of Polygon with each own styles and data
        [
          U.Polygon(
            [
              [51.556550, -0.108717],
              [51.555936, -0.109532],
              [51.555796, -0.109715],
              [51.555469, -0.110004],
              [51.555422, -0.109961],
              [51.555162, -0.110251],
              [51.555135, -0.110219],
              [51.554909, -0.110444],
              [51.554855, -0.110380],
              [51.554688, -0.110509],
              [51.554635, -0.110326],
              [51.554582, -0.110326],
              [51.554235, -0.109801],
              [51.554101, -0.110026],
              [51.553968, -0.109833],
              [51.553908, -0.109919],
              [51.553888, -0.109897],
              [51.553781, -0.109886],
              [51.553748, -0.108234],
              [51.553981, -0.107011],
              [51.553895, -0.106807],
              [51.553834, -0.106754],
              [51.553968, -0.106593],
              [51.554048, -0.106732],
              [51.554375, -0.106861],
              [51.555015, -0.106850],
              [51.555369, -0.106936],
              [51.555616, -0.107033],
              [51.555782, -0.107140],
              [51.555996, -0.107333],
              [51.556236, -0.107494],
              [51.556543, -0.107666],
              [51.556603, -0.107698],
            ],
            fillColor: Colors.lightBlue,
            fillOpacity: 0.75,
            data: DataClassExample(
              id: '1',
              name: 'Arsenal 1',
            ),
          ),
          U.Polygon(
            [
              [51.557904, -0.104146],
              [51.558384, -0.102365],
              [51.557370, -0.101657],
              [51.556956, -0.103524],
            ],
            stroke: true,
            strokeColor: Colors.yellow,
            strokeWidth: 2.5,
            fillColor: Colors.orange,
            fillOpacity: 0.8,
            data: DataClassExample(
              id: '2',
              name: 'Arsenal 2',
            ),
          ),
          U.Polygon(
            [
              [51.555436, -0.105466],
              [51.555436, -0.104651],
              [51.554642, -0.104619],
              [51.553681, -0.104511],
              [51.553634, -0.104908],
              [51.554615, -0.105252],
              [51.554875, -0.105327],
            ],
            stroke: true,
            strokeColor: Colors.pink,
            isDotted: true,
            fillColor: Colors.pinkAccent,
            fillOpacity: 0.6,
            data: DataClassExample(
              id: '3',
              name: 'Arsenal 3',
            ),
          ),
        ],
        // this style will apply to all polygons
        strokeJoin: StrokeJoin.bevel,
        strokeCap: StrokeCap.butt,
        pathFillType: PathFillType.nonZero,
        onTap: (position, data) {
          if (data is DataClassExample) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome to ${data.name}'),
              ),
            );
          }
        },
      ),
    );
  }
}
