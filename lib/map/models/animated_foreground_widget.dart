import 'package:flutter/material.dart';

import 'animated_foreground_specs.dart';
import 'animated_stateful_widget.dart';
import 'user_control.dart';

abstract class AnimatedForegroundWidget extends AnimatedStatefulWidget {
  final Stream<UserControl>? userControlStream;
  final AnimatedForegroundSpecs specification;
  final double scale;
  final double x;
  final double y;

  Duration get duration => isDone ? specification.loopDuration : moveDuration;

  const AnimatedForegroundWidget({
    required bool isDone,
    required this.specification,
    Curve curve = Curves.linear,
    this.userControlStream,
    this.scale = 1,
    this.x = 50,
    this.y = 50,
    Key? key,
  }) : super(key: key, isDone: isDone, curve: curve);

  void listenUserControls(AnimationController animationController) {
    userControlStream?.listen(
      (userEvent) => userEvent.maybeWhen(
        orElse: () {
          if (animationController.status == AnimationStatus.completed) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        },
      ),
    );
  }

  @required
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  });
}
