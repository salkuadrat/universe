import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class SafeCastMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.SafeCastMap(
      center: [51.555158, -0.108343],
      zoom: 16,
    );
  }
}
