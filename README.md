# floating_dots

[![Pub](https://img.shields.io/pub/v/floating_dots.svg)](https://pub.dartlang.org/packages/floating_dots)

Creates a group of coloured floating dots (or a single floating dot) that travel at a random speed from one edge of the screen to another.

![small dots, floating randomly](https://i.imgur.com/DYGCvqK.gif "small dots, moving randomly from all edges")      ![small dots, floating up](https://i.imgur.com/uHZGSAT.gif "small dots, moving straight up from the bottom")

## Installation

In your `pubspec.yaml` root add:

```yaml
dependencies:
    floating_dots: ^0.1.0
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
)
```

### FloatingDot

```dart
FloatingDot(
    direction: Direction,
    trajectory: Trajectory,
    radius: double,
    color: Colour,
)
```

## Examples

![small dots](https://i.imgur.com/ksHiXlB.gif "Demo of small dots, floating up")

Small dots

```dart
FloatingDotGroup(
    number: 5,
    direction: Direction.up,
    trajectory: Trajectory.straight,
    size: DotSize.small,
    colors: Colors.primaries,
)
```

![medium dots](https://i.imgur.com/JlsTQkf.gif "Demo of medium dots, floating in from all edges")

Medium dots

```dart
FloatingDotGroup(
    number: 25,
    direction: Direction.random,
    trajectory: Trajectory.random,
    size: DotSize.medium,
    colors: Colors.accents,
)
```

![large dots](https://i.imgur.com/MSsizo7.gif "Demo of medium dots, floating up")

Large dots

```dart
FloatingDotGroup(
    number: 3,
    direction: Direction.up,
    trajectory: Trajectory.straight,
    size: DotSize.large,
    colors: Colors.accents,
)
```
