import 'dart:math' as math;

import 'package:flutter/material.dart';

class PivotTransition extends AnimatedWidget {
  final Alignment? alignment;
  final Widget? child;

  Animation<double> get _rotate => listenable as Animation<double>;

  const PivotTransition({
    required Animation<double> rotate,
    this.alignment,
    this.child,
    Key? key,
  }) : super(key: key, listenable: rotate);

  @override
  Widget build(BuildContext context) => Transform(
        transform: Matrix4.rotationZ(_rotate.value * math.pi * 2),
        alignment: alignment,
        child: child,
      );
}
