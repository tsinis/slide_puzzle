import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';
import 'pivot_transition.dart';

class Bridge extends AnimatedForegroundWidget {
  const Bridge({
    Stream<UserControl>? userControlStream,
    bool isDone = true,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.black,
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.easeInSine,
          userControlStream: userControlStream,
          isDone: isDone,
          x: 105,
          y: 160,
          key: key,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Bridge(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Bridge> createState() => _BridgeState();
}

class _BridgeState extends State<Bridge> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  late final ReverseAnimation _reverseAnimation;

  late final SizedBox _line = SizedBox(
    height: 20,
    width: 2,
    child: ColoredBox(color: widget.specification.firstColor),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      upperBound: 0.46,
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _reverseAnimation = ReverseAnimation(_animation);

    if (widget.isDone) {
      _controller.repeat(reverse: true);
    }
    widget.listenUserControls(_controller);
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: widget.x, top: widget.y),
        child: Row(
          children: <Widget>[
            PivotTransition(
              rotate: _animation,
              alignment: Alignment.bottomRight,
              child: _line,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: _line.height! * 2 - _line.width! - 1,
                bottom: _line.width! * 2,
              ),
              child: PivotTransition(
                rotate: _reverseAnimation,
                alignment: Alignment.bottomRight,
                child: _line,
              ),
            ),
          ],
        ),
      );
}
