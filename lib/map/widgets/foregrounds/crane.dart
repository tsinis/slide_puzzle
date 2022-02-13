import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Crane extends AnimatedForegroundWidget {
  const Crane({
    Stream<UserControl>? userControlStream,
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            secondColor: Colors.black,
            thirdColor: Color(0xFF5F5F5F),
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.decelerate,
          userControlStream: userControlStream,
          isDone: isDone,
          x: 100,
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
      Crane(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Crane> createState() => _CraneState();
}

class _CraneState extends State<Crane> with SingleTickerProviderStateMixin {
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
          builder: (_, __) => Stack(
            children: <Widget>[
              AnimatedPositioned(
                curve: widget.curve,
                duration: widget.duration,
                top: _animation.value * 6,
                left: _animation.value * 80 + 16,
                child: AnimatedContainer(
                  width: 14,
                  height: _animation.value * 120 + 22,
                  curve: widget.curve,
                  duration: widget.duration,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.specification.secondColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: widget.curve,
                duration: widget.duration,
                top: 0,
                left: _animation.value * 80 + 14,
                child: Container(
                  width: 18,
                  height: 8,
                  decoration: BoxDecoration(
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: widget.curve,
                duration: widget.duration,
                top: _animation.value * 120 + 16,
                left: _animation.value * 80,
                child: Container(
                  width: 48,
                  height: 16,
                  decoration: BoxDecoration(
                    color: widget.specification.thirdColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
