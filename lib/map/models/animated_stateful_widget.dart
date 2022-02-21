import 'package:flutter/material.dart';

import 'animated_widget_key.dart';

abstract class AnimatedStatefulWidget extends StatefulWidget {
  final AnimatedWidgetKey status;
  final Curve curve;
  final Duration moveDuration;

  const AnimatedStatefulWidget({
    required this.status,
    required this.curve,
    this.moveDuration = const Duration(milliseconds: 500),
  }) : super(key: status);
}
