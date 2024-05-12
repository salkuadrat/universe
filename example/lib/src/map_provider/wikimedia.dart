import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class WikimediaMap extends StatelessWidget {
  const WikimediaMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.WikimediaMap(
      center: [51.555158, -0.108343],
      zoom: 16,
    );
  }
}
