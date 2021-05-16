import 'package:flutter/material.dart';

import 'src/menu.dart';
import 'src/shared.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Key _key = menus.keys.first;

  Widget get map => menus[_key]!.map();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universe Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            map,
            AppMenu(
              items: menus,
              value: _key,
              onChanged: (key) {
                setState(() {
                  _key = key;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
