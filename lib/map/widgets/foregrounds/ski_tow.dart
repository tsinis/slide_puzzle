import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/illustration_colors.dart';
import '../../models/user_control.dart';

class SkiTow extends AnimatedForegroundWidget {
  const SkiTow({
    AnimatedWidgetKey status = const AnimatedWidgetKey.skiTow(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Color.fromARGB(255, 90, 90, 90),
            secondColor: IllustrationColors.lightRed,
            loopDuration: Duration(milliseconds: 3500),
          ),
          curve: Curves.slowMiddle,
          userControlStream: userControlStream,
          status: status,
          x: 44.5,
          y: 0,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      SkiTow(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<SkiTow> createState() => _SkiTowState();
}

class _SkiTowState extends State<SkiTow> with SingleTickerProviderStateMixin {
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
      end: const Offset(-0.1, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
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
        padding: EdgeInsets.only(left: widget.x, bottom: widget.y),
        child: Transform.scale(
          alignment: const Alignment(-0.44, -0.5),
          scale: 0.823,
          child: RotatedBox(
            quarterTurns: 1,
            child: SizedBox(
              width: 250,
              height: 112,
              child: Stack(
                children: [
                  Positioned(
                    top: 44,
                    right: 1,
                    child: Transform.rotate(
                      angle: 40 * (math.pi / 180),
                      child: Container(
                        width: 330,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          color: widget.specification.firstColor,
                        ),
                      ),
                    ),
                  ),
                  ClipRect(
                    child: Transform.rotate(
                      angle: 40 * (math.pi / 180),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (_, child) => SlideTransition(
                          position: _animation,
                          child: child,
                        ),
                        child: Stack(
                          children: List.generate(
                            12,
                            (i) => Positioned(
                              top: 66,
                              left: i * 20,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.specification.secondColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
