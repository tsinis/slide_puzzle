// ignore_for_file: avoid_redundant_argument_values

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class Wheel extends AnimatedForegroundWidget {
  const Wheel({
    AnimatedWidgetKey status = const AnimatedWidgetKey.wheel(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            secondColor: Colors.amber,
            thirdColor: Colors.white,
            fourthColor: Colors.green,
            loopDuration: Duration(milliseconds: 4500),
          ),
          userControlStream: userControlStream,
          curve: Curves.decelerate,
          status: status,
          x: 80,
          y: 60,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Wheel(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final loopValue = (widget.status.isDone) ? 0.0 : 0.5;
    _controller = AnimationController(
      duration: widget.duration,
      lowerBound: loopValue,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    if (widget.status.isDone) {
      _controller.repeat(reverse: true);
    }
    widget.listenUserControls(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: widget.x, top: widget.y),
        child: Stack(
          children: <Widget>[
            RotationTransition(
              turns: _animation,
              child: SizedBox(
                width: 88,
                height: 86,
                child: Stack(
                  children: <Positioned>[
                    Positioned(
                      width: 87,
                      height: 87,
                      child: _Cross(color: widget.specification.thirdColor),
                    ),
                    Positioned(
                      width: 87,
                      height: 87,
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: _Cross(color: widget.specification.thirdColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _WheelStand(
              primaryColor: widget.specification.firstColor,
              secondaryColor: widget.specification.secondColor,
              thirdColor: widget.specification.fourthColor,
            ),
          ],
        ),
      );
}

// ignore: prefer-single-widget-per-file
class _WheelStand extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;

  const _WheelStand({
    required this.primaryColor,
    required this.secondaryColor,
    required this.thirdColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Positioned>[
          Positioned(
            top: 8,
            left: 5.9,
            child: SizedBox(
              width: 77,
              height: 91,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 22,
                    left: 26,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 6),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: 77,
                      height: 7,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3e-7,
                    left: 3,
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: thirdColor, width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(70),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 9,
                    left: 12,
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor, width: 5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(52)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 53,
                    child: Transform.rotate(
                      angle: -30 * (math.pi / 180),
                      child: SizedBox(
                        width: 4,
                        height: 52,
                        child: ColoredBox(color: primaryColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 19.2,
                    child: Transform.rotate(
                      angle: 30 * (math.pi / 180),
                      child: SizedBox(
                        width: 4,
                        height: 52,
                        child: ColoredBox(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

// ignore: prefer-single-widget-per-file
class _Cross extends StatelessWidget {
  final Color color;

  const _Cross({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            top: 78,
            left: 40,
            child: SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 40,
            child: SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 7,
            left: 43.5,
            child: SizedBox(
              width: 1,
              height: 25,
              child: ColoredBox(color: color),
            ),
          ),
          Positioned(
            top: 54,
            left: 43.5,
            child: SizedBox(
              width: 1,
              height: 25,
              child: ColoredBox(color: color),
            ),
          ),
          Positioned(
            top: 39,
            left: 1,
            child: Transform.rotate(
              angle: -90 * (math.pi / 180),
              child: SizedBox(
                width: 8,
                height: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 39,
            left: 79,
            child: Transform.rotate(
              angle: -90 * (math.pi / 180),
              child: SizedBox(
                width: 8,
                height: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 31,
            left: 67,
            child: Transform.rotate(
              angle: -90 * (math.pi / 180),
              child: SizedBox(
                width: 1,
                height: 25,
                child: ColoredBox(color: color),
              ),
            ),
          ),
          Positioned(
            top: 31,
            left: 23,
            child: Transform.rotate(
              angle: -90 * (math.pi / 180),
              child: SizedBox(
                width: 1,
                height: 25,
                child: ColoredBox(color: color),
              ),
            ),
          ),
        ],
      );
}
