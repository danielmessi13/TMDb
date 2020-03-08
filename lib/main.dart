import 'package:flutter/material.dart';

import 'src/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDb Movies',
      theme: ThemeData(
        primaryColor: Color(0xFF04774D),
        accentColor: Color(0xFF081C24),
        canvasColor: Color(0xFF081C24),
        textTheme: TextTheme(
          body1: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}
