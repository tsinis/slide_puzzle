import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Gate extends AnimatedForegroundWidget {
  const Gate({
    Stream<UserControl>? userControlStream,
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.black,
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.bounceIn,
          userControlStream: userControlStream,
          isDone: isDone,
          x: 105,
          y: 150,
          key: key,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Gate(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Gate> createState() => _GateState();
}

class _GateState extends State<Gate> with SingleTickerProviderStateMixin {
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
      end: const Offset(0, -0.74),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
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
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 38,
                child: Container(
                  width: 1,
                  height: 36,
                  color: widget.specification.firstColor,
                ),
              ),
              Positioned(
                top: 0,
                left: 3,
                child: Container(
                  width: 1,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 10,
                child: Container(
                  width: 1,
                  height: 36,
                  color: widget.specification.firstColor,
                ),
              ),
              Positioned(
                top: 0,
                left: 17,
                child: Container(
                  width: 1,
                  height: 36,
                  color: widget.specification.firstColor,
                ),
              ),
              Positioned(
                top: 0,
                left: 24,
                child: Container(
                  width: 1,
                  height: 36,
                  color: widget.specification.firstColor,
                ),
              ),
              Positioned(
                top: 0,
                left: 31,
                child: Container(
                  width: 1,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.specification.firstColor,
                  ),
                ),
              ),
              Positioned(
                top: 18,
                left: -1,
                child: Container(
                  width: 44,
                  height: 8,
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.specification.firstColor),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 0,
                child: Container(
                  width: 42,
                  height: 8,
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.specification.firstColor),
                  ),
                ),
              ),
            ],
          ),
          builder: (_, child) => SizedBox(
            width: 42,
            height: 32,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: SlideTransition(
                position: _animation,
                child: child,
              ),
            ),
          ),
        ),
      );
}
