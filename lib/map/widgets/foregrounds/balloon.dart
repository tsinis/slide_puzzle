import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/illustration_colors.dart';
import '../../models/user_control.dart';

class Balloon extends AnimatedForegroundWidget {
  const Balloon({ 
    AnimatedWidgetKey status = const AnimatedWidgetKey.balloon(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: IllustrationColors.orange,
            secondColor: IllustrationColors.lightYellow,
            thirdColor: IllustrationColors.brown,
            fourthColor: IllustrationColors.midGrey,
            loopDuration: Duration(milliseconds: 3500),
          ),
          curve: Curves.easeInOutCubicEmphasized,
          userControlStream: userControlStream,
          status: status,
          x: 145,
          y: 40,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Balloon(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.1),
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
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
        child: AnimatedBuilder(
          animation: _animation,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 51,
                left: 24,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 52,
                left: 25,
                child: Container(
                  width: 4,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    color: widget.specification.secondColor,
                  ),
                ),
              ),
              Positioned(
                top: 58,
                left: 25,
                child: Container(
                  width: 1,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(1),
                    ),
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 2,
                child: Container(
                  width: 51,
                  height: 51,
                  decoration: BoxDecoration(
                    color: widget.specification.secondColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 9,
                child: Container(
                  width: 37,
                  height: 51,
                  decoration: BoxDecoration(
                    color: widget.specification.firstColor,
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(37, 51),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 22,
                child: Container(
                  width: 11,
                  height: 51,
                  decoration: BoxDecoration(
                    color: widget.specification.secondColor,
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(11, 51)),
                  ),
                ),
              ),
              Positioned(
                top: 26,
                left: 27,
                child: Container(
                  width: 1,
                  height: 50,
                  color: widget.specification.thirdColor,
                ),
              ),
              Positioned(
                top: 25,
                left: 0,
                child: Container(
                  width: 55,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 26,
                left: 10,
                child: Transform.rotate(
                  angle: -20 * (math.pi / 180),
                  child: Container(
                    width: 1,
                    height: 50,
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 26,
                left: 44,
                child: Transform.rotate(
                  angle: 20 * (math.pi / 180),
                  child: Container(
                    width: 1,
                    height: 50,
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 71,
                left: 15,
                child: SizedBox(
                  width: 24,
                  height: 12,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 1,
                        child: Container(
                          width: 22,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                            color: widget.specification.thirdColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 24,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(1),
                            ),
                            color: widget.specification.fourthColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          builder: (_, child) =>
              SlideTransition(position: _animation, child: child),
        ),
      );
}
