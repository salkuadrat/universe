import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class CyclOSMMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.CyclOSMMap(
      center: [51.555158, -0.108343],
      zoom: 13,
    );
  }
}
