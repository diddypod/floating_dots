library floating_dots;

import 'dart:math';

import 'package:flutter/material.dart';

/// Creates a group of [FloatingDot]
///
/// A FloatingDotGroup creates a specified [number] of [FloatingDot] objects,
/// in one of three sizes, [DotSize.small], [DotSize.medium] and
/// [DotSize.large], or a mix of all 3 using [DotSize.random] passed to
/// [size]. They can move in [Direction.up], starting from the bottom, or
/// travel in [Direction.random] from any edge to the opposite edge of the
/// screen, from the [direction] parameter. The dots can travel in a straight
/// line from a point on one edge to it's mirror point on the opposite edge
///  - [Trajectory.straight], or to a random point on the opposite edge
///  - [Trajectory.random], determined by [trajectory]. The [Color] of each
/// ball is assigned at random from a list passed to [colors]. The opacity of
/// the color is controlled with [opacity] and is applied to the color of each
/// dot.

class FloatingDotGroup extends StatefulWidget {
  final int number;
  final Direction direction;
  final Trajectory trajectory;
  final DotSize size;
  final List<Color> colors;
  final double opacity;
  final DotSpeed speed;
  final random = Random();

  FloatingDotGroup({
    Key key,
    this.number = 25,
    this.direction = Direction.random,
    this.trajectory = Trajectory.random,
    this.size = DotSize.random,
    this.colors = Colors.primaries,
    this.opacity = .5,
    this.speed = DotSpeed.slow,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FloatingDotGroupState();
}

class FloatingDotGroupState extends State<FloatingDotGroup> {
  double radius;
  int time;

  List<Widget> buildDots() {
    List<Widget> dots = [];

    // Assign size as per DotSize
    //  - small:  5-20
    //  - medium: 25-50
    //  - large:  50-100
    //  - random: 5-75
    // Assign color at random from list of Color objects.
    // Add them to the list of FloatingDot objects.

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
      if (widget.speed == DotSpeed.slow) {
        time = widget.random.nextInt(45) + 22;
      } else if (widget.speed == DotSpeed.medium) {
        time = widget.random.nextInt(30) + 15;
      } else if (widget.speed == DotSpeed.fast) {
        time = widget.random.nextInt(15) + 7;
      } else if (widget.speed == DotSpeed.mixed) {
        time = widget.random.nextInt(45) + 7;
      }
      dots.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: FloatingDot(
          direction: widget.direction,
          trajectory: widget.trajectory,
          radius: radius,
          color: widget.colors[widget.random.nextInt(widget.colors.length)]
              .withOpacity(widget.opacity),
          time: time,
        ),
      ));
    }
    return dots;
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: buildDots(),
      ),
    );
  }
}

/// Creates a dot that travels from an edge of the screen to the opposite egde
///
/// A FloatingDot creates one coloured dot. This dot can move in
/// [Direction.up], starting from the bottom, or travel in
/// [Direction.random] from any edge to the opposite edge of the screen, from
/// the [direction] parameter. It can travel in a straight line from a point
/// on one edge to it's mirror point on the opposite edge
/// [Trajectory.straight], or to a random point on the opposite edge
/// [Trajectory.random], determined by [trajectory]. The [Color] of this ball
/// is passed as [color]. The size is determined by [radius]. The time taken by
/// the dot to go from end to end is passed as [time].

class FloatingDot extends StatefulWidget {
  final Direction direction;
  final Trajectory trajectory;
  final double radius;
  final int time;
  final Color color;

  FloatingDot({
    Key key,
    @required this.direction,
    @required this.trajectory,
    @required this.radius,
    @required this.color,
    @required this.time,
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
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Assign travel direction and starting edge from Direction.
    // Assign random initial position.
    // Assign destination from Traejectory, either random or initial postion.
    // Assign _start, a beginning handicap so that dots are created staggered,
    // and not all on the edge.
    // Create and start repeating linear animation with a speed between 15-60
    // seconds from edge to edge.

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
        duration: Duration(seconds: widget.time), vsync: this);

    controller
      ..addListener(() {
        setState(() {
          _fraction = controller.value;
        });
      });

    controller.repeat();
  }

  @override
  void didUpdateWidget(covariant FloatingDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction != oldWidget.direction) {
      if (widget.direction == Direction.up) {
        _vertical = true;
        _inverseDir = false;
      } else {
        _vertical = random.nextBool();
        _inverseDir = random.nextBool();
      }
    }
    if (widget.trajectory != oldWidget.trajectory) {
      if (widget.trajectory == Trajectory.straight) {
        _destination = _initialPosition;
      } else {
        _destination = random.nextDouble();
      }
    }
    if (widget.time != oldWidget.time) {
      controller.duration = Duration(seconds: widget.time);
      controller.repeat();
    }
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

/// Paints the dot from parameters given by [FloatingDot]

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
  Paint _paint;

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
    _paint.color = color;
    diameter = radius * 2;
    distance = destination - initialPosition;
  }

  // Find initial and final destinations and paint at linear interpolation
  // using animation fraction.

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

enum DotSpeed {
  slow,
  medium,
  fast,
  mixed,
}
