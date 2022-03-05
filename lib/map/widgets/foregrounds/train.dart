import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/illustration_colors.dart';
import '../../models/user_control.dart';

class Train extends AnimatedForegroundWidget {
  const Train({
    AnimatedWidgetKey status = const AnimatedWidgetKey.train(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: IllustrationColors.lightRed,
            secondColor: IllustrationColors.lightYellow,
            thirdColor: IllustrationColors.darkRed,
            loopDuration: Duration(milliseconds: 1500),
          ),
          size: const Size(250, 88),
          curve: Curves.slowMiddle,
          userControlStream: userControlStream,
          status: status,
          x: 6,
          y: 95.5,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Train(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> with SingleTickerProviderStateMixin {
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
      begin: const Offset(-1, 0),
      end: const Offset(2, 0),
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
        padding: EdgeInsets.only(left: widget.x, top: widget.y),
        child: Transform.scale(
          scale: 1.32,
          child: SizedBox.fromSize(
            size: widget.size,
            child: ClipRect(
              child: Transform.rotate(
                alignment: const Alignment(-0.44, 0),
                angle: 40 * (math.pi / 180),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (_, child) => SlideTransition(
                    position: _animation,
                    child: child,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 3,
                        left: 0,
                        child: Container(
                          width: 44,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            color: widget.specification.firstColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 4,
                        child: Container(
                          width: 36,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.5)),
                            color: widget.specification.firstColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 7,
                        left: 2,
                        child: Container(
                          width: 40,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.5)),
                            color: widget.specification.thirdColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 6,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 34,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 12,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 26,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 16,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 30,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 21,
                        child: Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.specification.secondColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
