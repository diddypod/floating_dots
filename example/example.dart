import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: FloatingDotGroup(
          number: 500,
          direction: Direction.up,
          trajectory: Trajectory.straight,
          size: DotSize.small,
          colors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
            Colors.purple,
            Colors.orange
          ],
          opacity: 0.5,
          speed: DotSpeed.slow,
        ),
      ),
    );
  }
}
