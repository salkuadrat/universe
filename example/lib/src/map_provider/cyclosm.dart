import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class CyclOSMMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.CyclOSMMap(
      center: [48.858236, 2.294477],
      zoom: 10,
    );
  }
}
