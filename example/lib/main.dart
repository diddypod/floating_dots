import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Dots Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            FloatingDotGroup(
              number: 500,
              direction: Direction.up,
              trajectory: Trajectory.straight,
              size: DotSize.small,
              colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple, Colors.orange]
            ),
          ],
        ),
      ),
    );
  }
}
