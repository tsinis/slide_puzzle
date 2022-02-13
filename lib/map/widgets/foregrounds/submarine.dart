import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Submarine extends AnimatedForegroundWidget {
  const Submarine({
    Stream<UserControl>? userControlStream,
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            secondColor: Colors.black,
            thirdColor: Color(0xFF5F5F5F),
            loopDuration: Duration(milliseconds: 2000),
          ),
          curve: Curves.easeOutSine,
          userControlStream: userControlStream,
          isDone: isDone,
          x: 60,
          y: 0,
          key: key,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Submarine(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Submarine> createState() => _SubmarineState();
}

// ignore: lines_longer_than_80_chars
class _SubmarineState extends State<Submarine> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    if (widget.isDone) {
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
          builder: (_, child) => Stack(
            children: <Widget>[
              AnimatedPositioned(
                top: _animation.value * 22,
                duration: widget.duration,
                curve: widget.curve,
                child: SizedBox.fromSize(
                  size: widget.size,
                  child: child,
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: <Color>[
                        Colors.teal.withOpacity(0.5), // TODO as constant.
                        Colors.teal,
                        Colors.teal,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 47,
                child: Container(
                  width: 2,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 50,
                child: Container(
                  width: 2,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              Positioned(
                top: 9,
                left: 44,
                child: Container(
                  width: 13,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    color: widget.specification.secondColor,
                  ),
                ),
              ),
              Positioned(
                top: 33,
                left: 0,
                child: Container(
                  width: 88,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 22,
                left: 38,
                child: Container(
                  width: 25,
                  height: 11,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(1),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(4),
                    ),
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
              Positioned(
                top: 27,
                left: 8,
                child: Container(
                  width: 85,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              Positioned(
                top: 34,
                left: 35,
                child: SizedBox(
                  width: 44,
                  height: 4,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 24,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 8,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 32,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 16,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: widget.specification.secondColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 52,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: widget.specification.firstColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 27,
                left: 3,
                child: Container(
                  width: 7,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(1),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(4),
                    ),
                    color: widget.specification.secondColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
