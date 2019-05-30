# floating_dots

Creates a group of coloured floating dots (or a single floating dot) that travel at a random speed from one edge of the screen to another.

![small dots, floating randomly](screenshots/small_random_random.gif "small dots, moving randomly from all edges")
![small dots, floating up](screenshots/small_up_straight_500.gif "small dots, moving straight up from the bottom")

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

![small dots](screenshots/small_up_straight_5.gif "Demo of small dots, floating up")

## Examples

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

![medium dots](screenshots/medium_random_random.gif "Demo of medium dots, floating in from all edges")

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

![large dots](screenshots/large_up_straight.gif "Demo of medium dots, floating up")

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
