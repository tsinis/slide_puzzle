import 'package:flutter/material.dart';

class AnimatedForegroundSpecs {
  final Color firstColor;
  final Color fourthColor;
  final Duration loopDuration;
  final Color secondColor;
  final Color thirdColor;

  const AnimatedForegroundSpecs({
    required this.loopDuration,
    required this.firstColor,
    this.secondColor = Colors.amber,
    this.thirdColor = Colors.white,
    this.fourthColor = Colors.green,
  });
}
