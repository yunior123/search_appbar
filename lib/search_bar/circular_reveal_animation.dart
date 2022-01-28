import 'package:flutter/material.dart';

import 'clipper.dart';

class CircularRevealAnimation extends StatelessWidget {
  final Alignment? centerAlignment;
  late final Offset centerOffset;
  final double? minRadius;
  final double? maxRadius;
  final Widget child;
  final Animation<double> animation;

  CircularRevealAnimation({
    Key? key,
    required this.child,
    required this.animation,
    required Offset center,
    this.centerAlignment,
    Offset? centerOffset,
    this.minRadius,
    this.maxRadius,
  }) : super(key: key) {
    this.centerOffset = centerOffset ?? center;
    assert(centerAlignment == null || centerOffset == null);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? _) {
        return ClipPath(
          clipper: CircularRevealClipper(
            fraction: animation.value,
            centerAlignment: centerAlignment,
            centerOffset: centerOffset,
            minRadius: minRadius,
            maxRadius: maxRadius,
          ),
          child: child,
        );
      },
    );
  }
}
