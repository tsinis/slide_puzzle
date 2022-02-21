import 'package:flutter/material.dart';

import 'animated_foreground_specs.dart';
import 'animated_stateful_widget.dart';
import 'animated_widget_key.dart';
import 'user_control.dart';

abstract class AnimatedForegroundWidget extends AnimatedStatefulWidget {
  final Stream<UserControl>? userControlStream;
  final AnimatedForegroundSpecs specification;
  final Size size;
  final double x;
  final double y;

  Duration get duration =>
      status.isDone ? specification.loopDuration : moveDuration;

  const AnimatedForegroundWidget({
    required AnimatedWidgetKey status,
    required this.specification,
    Curve curve = Curves.linear,
    this.userControlStream,
    this.size = const Size.square(100),
    this.x = 50,
    this.y = 50,
  }) : super(status: status, curve: curve);

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
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  });
}
