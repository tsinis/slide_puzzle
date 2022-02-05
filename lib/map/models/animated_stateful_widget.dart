import 'package:flutter/material.dart';

abstract class AnimatedStatefulWidget extends StatefulWidget {
  final bool isDone;
  final Curve curve;
  final Duration moveDuration;

  const AnimatedStatefulWidget({
    required this.isDone,
    required this.curve,
    this.moveDuration = const Duration(milliseconds: 500),
    Key? key,
  }) : super(key: key);
}
