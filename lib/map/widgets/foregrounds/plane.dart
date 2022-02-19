import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Plane extends AnimatedForegroundWidget {
  const Plane({
    Stream<UserControl>? userControlStream,
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Color.fromARGB(255, 61, 61, 61),
            thirdColor: Color.fromARGB(255, 131, 131, 131),
            fourthColor: Colors.brown,
            loopDuration: Duration(milliseconds: 5500),
          ),
          curve: Curves.slowMiddle,
          userControlStream: userControlStream,
          isDone: isDone,
          x: 0,
          y: 80,
          key: key,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Plane(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Plane> createState() => _PlaneState();
}

class _PlaneState extends State<Plane> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    if (widget.isDone) {
      _controller.repeat();
    }
    widget.userControlStream?.listen(
      (userEvent) => userEvent.maybeWhen(
        orElse: () => _controller.forward(from: 0),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: widget.x, top: widget.y),
        child: AnimatedBuilder(
          animation: _animation,
          child: RotatedBox(
            quarterTurns: 4,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 16,
                  left: 0,
                  child: Container(
                    width: 90,
                    height: 14.5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      color: widget.specification.firstColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 4.35,
                  left: 34.84,
                  child: Container(
                    width: 20.33,
                    height: 20.33,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      color: widget.specification.secondColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 26.13,
                  left: 36.29,
                  child: SizedBox(
                    width: 17.33,
                    height: 41.15,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0.6,
                          left: 7,
                          child: Transform.rotate(
                            angle: 4 * (math.pi / 180),
                            child: Container(
                              width: 8.7,
                              height: 40.64,
                              color: widget.specification.secondColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 2,
                          child: Transform.rotate(
                            angle: -4 * (math.pi / 180),
                            child: Container(
                              width: 8.7,
                              height: 40.64,
                              color: widget.specification.secondColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 43.55,
                  child: Container(
                    width: 2.9,
                    height: 8.7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: widget.specification.secondColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 4.35,
                  left: 42,
                  child: Container(
                    width: 5.8,
                    height: 4.35,
                    color: widget.specification.thirdColor,
                  ),
                ),
                Positioned(
                  top: 11.61,
                  left: 39.19,
                  child: Container(
                    width: 11.61,
                    height: 20.32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(1),
                      ),
                      color: widget.specification.fourthColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 66.77,
                  left: 29,
                  child: Container(
                    width: 31.9,
                    height: 7.25,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      color: widget.specification.thirdColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 63.87,
                  left: 43.54,
                  child: Container(
                    width: 2.9,
                    height: 15.96,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      color: widget.specification.firstColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 1.45,
                  left: 31.93,
                  child: Container(
                    width: 26.13,
                    height: 1.45,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(0.5),
                      ),
                      color: widget.specification.thirdColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 13,
                  left: 0,
                  child: Container(
                    width: 90,
                    height: 14.51,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      color: widget.specification.thirdColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          builder: (_, child) => RotationTransition(
            turns: _animation,
            child: SizedBox(
              height: 84,
              child: child,
            ),
          ),
        ),
      );
}
