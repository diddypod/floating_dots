library floating_dots;

import 'dart:math';

import 'package:flutter/material.dart';

/// Creates a group of [FloatingDot]
///
/// A FloatingDotGroup creates a specified [number] of [FloatingDots], in one
/// of three sizes, [DotSize.small], [DotSize.medium] and [DotSize.large]. The
/// dots can move in [Direction.up], starting from the bottom, or travel in
/// [Direction.random] from any edge to the opposite edge of the screen, from
/// the [direction] parameter. The dots can travel in a straight line from a
/// point on one edge to it's mirror point on the opposite edge
/// [Trajectory.straight], or to a random point on the opposite edge
/// [Trajectory.random], determined by [trajectory]. The [Color] of each ball
/// is assigned at random from a list passed to [colors].

class FloatingDotGroup extends StatefulWidget {
  final int number;
  final direction;
  final trajectory;
  final size;
  final colors;
  final random = Random();

  FloatingDotGroup({
    Key key,
    this.number = 25,
    this.direction = Direction.random,
    this.trajectory = Trajectory.random,
    this.colors = Colors.primaries,
    @required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FloatingDotGroupState();
}

class FloatingDotGroupState extends State<FloatingDotGroup> {
  List<Widget> _dots = [];

  @override
  void initState() {
    double radius;

    super.initState();
    for (int i = 0; i < widget.number; i++) {
      if (widget.size == DotSize.small) {
        radius = widget.random.nextDouble() * 15 + 5;
      } else if (widget.size == DotSize.medium) {
        radius = widget.random.nextDouble() * 25 + 25;
      } else if (widget.size == DotSize.large) {
        radius = widget.random.nextDouble() * 50 + 50;
      } else if (widget.size == DotSize.random) {
        radius = widget.random.nextDouble() * 70 + 5;
      }
      _dots.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: FloatingDot(
          direction: widget.direction,
          trajectory: widget.trajectory,
          radius: radius,
          color: widget.colors[widget.random.nextInt(widget.colors.length)],
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: _dots,
      ),
    );
  }
}

typedef SizeCallback = void Function(Direction direction);

/// Creates a dot that travels from an edge of the screen to the opposite egde
///
/// A FloatingDotGroup creates one coloured dot. The dot can move in
/// [Direction.up], starting from the bottom, or travel in
/// [Direction.random] from any edge to the opposite edge of the screen, from
/// the [direction] parameter. The dots can travel in a straight line from a
/// point on one edge to it's mirror point on the opposite edge
/// [Trajectory.straight], or to a random point on the opposite edge
/// [Trajectory.random], determined by [trajectory]. The [Color] of each ball
/// is assigned as [color]. The size of the ball is passed as [radius].

class FloatingDot extends StatefulWidget {
  final direction;
  final trajectory;
  final double radius;
  final color;

  FloatingDot({
    Key key,
    this.direction = Direction.random,
    this.trajectory = Trajectory.random,
    @required this.radius,
    @required this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FloatingDotState();
}

class FloatingDotState extends State<FloatingDot>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  bool _vertical;
  bool _inverseDir;
  double _initialPosition;
  double _destination;
  double _start;
  double _fraction;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    _fraction = 0.0;
    if (widget.direction == Direction.up) {
      _vertical = true;
      _inverseDir = false;
    } else {
      _vertical = random.nextBool();
      _inverseDir = random.nextBool();
    }
    _initialPosition = random.nextDouble();
    if (widget.trajectory == Trajectory.straight) {
      _destination = _initialPosition;
    } else {
      _destination = random.nextDouble();
    }
    _start = 150 * random.nextDouble();
    controller = AnimationController(
        duration: Duration(seconds: random.nextInt(45) + 15), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: DotPainter(
      vertical: _vertical,
      inverseDir: _inverseDir,
      initialPosition: _initialPosition,
      destination: _destination,
      radius: widget.radius,
      start: _start,
      fraction: _fraction,
      color: widget.color,
    ));
  }
}

class DotPainter extends CustomPainter {
  bool vertical;
  bool inverseDir;
  double initialPosition;
  double destination;
  double radius;
  double start;
  double diameter;
  double distance;
  double fraction;
  Color color;
  final Paint _paint;

  DotPainter({
    this.vertical,
    this.inverseDir,
    this.initialPosition,
    this.destination,
    this.radius,
    this.start,
    this.fraction,
    this.color,
  }) : _paint = Paint() {
    _paint.color = Color.lerp(color, Color.fromARGB(0, 255, 255, 255), .25);
    diameter = radius * 2;
    distance = destination - initialPosition;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset;
    if (!this.vertical && this.inverseDir) {
      offset = Offset(
          -start - radius + (size.width + diameter + start) * fraction,
          size.height * (initialPosition + distance * fraction));
    } else if (this.vertical && this.inverseDir) {
      offset = Offset(size.width * (initialPosition + distance * fraction),
          -start - radius + (size.height + diameter + start) * fraction);
    } else if (!this.vertical && !this.inverseDir) {
      offset = Offset(
          size.width +
              start +
              radius -
              (size.width + diameter + start) * fraction,
          size.height * (initialPosition + distance * fraction));
    } else if (this.vertical && !this.inverseDir) {
      offset = Offset(
          size.width * (initialPosition + distance * fraction),
          size.height +
              start +
              radius -
              (size.height + diameter + start) * fraction);
    }

    canvas.drawCircle(offset, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum Direction {
  up,
  random,
}

enum Trajectory {
  straight,
  random,
}

enum DotSize {
  small,
  medium,
  large,
  random,
}
