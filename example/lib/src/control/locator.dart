import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe/universe.dart';

class CustomLocatorMap extends StatelessWidget {
  const CustomLocatorMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      showLocator: true,
      // onReady: () => print('Map is ready!'),
      locator: Locator(
        icon: SvgPicture.asset(
          'assets/locator.svg',
          width: 44,
          height: 44,
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor,
            BlendMode.clear,
          ),
        ),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 14, top: 100),
        toZoom: 15, // target map zoom when moving to the user's location
      ),
    );
  }
}
