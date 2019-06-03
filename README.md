# floating_dots

[![Pub](https://img.shields.io/pub/v/floating_dots.svg)](https://pub.dartlang.org/packages/floating_dots)

Creates a group of coloured floating dots (or a single floating dot) that travel at a random speed from one edge of the screen to another.

![small dots, floating randomly](https://i.imgur.com/SZThxum.gif "small dots, moving randomly from all edges")  ![small dots, floating up](https://i.imgur.com/GRLc2Lk.gif "small dots, moving straight up from the bottom")

## Installation

In your `pubspec.yaml` root add:

```yaml
dependencies:
    floating_dots: ^0.2.2
```

then,

`import 'package:floating_dots/floating_dots.dart';`

## Usage

### FloatingDotGroup

```dart
FloatingDotGroup(
    number: int,
    direction: Direction,
    trajectory: Trajectory,
    size: DotSize,
    colors: List<Color>,
    opacity: double,
    speed: DotSpeed,
)
```

### FloatingDot

```dart
FloatingDot(
    direction: Direction,
    trajectory: Trajectory,
    radius: double,
    color: Colour,
    opacity: double,
    time: int,
)
```

## Examples

![small dots](https://i.imgur.com/6J0G1kn.gif "Demo of small dots, floating up")

Small dots

```dart
FloatingDotGroup(
    number: 5,
    direction: Direction.up,
    trajectory: Trajectory.random,
    size: DotSize.small,
    colors: Colors.primaries,
    opacity: 1,
    speed: DotSpeed.fast,
),
```

![medium dots](https://i.imgur.com/h6Gu6mh.gif "Demo of medium dots, floating in from all edges")

Medium dots

```dart
FloatingDotGroup(
    number: 25,
    direction: Direction.random,
    trajectory: Trajectory.random,
    size: DotSize.medium,
    colors: Colors.accents,
    opacity: .5,
    speed: DotSpeed.medium,
),
```

![large dots](https://i.imgur.com/tLwWrY5.gif "Demo of one large dot on a  dots, floating up")

Large dots

```dart
Stack(
    children: <Widget>[
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
        ),
        FloatingDotGroup(
            number: 1,
            direction: Direction.up,
            trajectory: Trajectory.straight,
            size: DotSize.large,
            colors: [Colors.deepOrange],
            opacity: 1,
            speed: DotSpeed.medium,
        ),
    ],
),
```
