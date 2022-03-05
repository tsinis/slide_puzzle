import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/illustration_colors.dart';
import '../../models/user_control.dart';
import 'pivot_transition.dart';

class Bridge extends AnimatedForegroundWidget {
  const Bridge({
    AnimatedWidgetKey status = const AnimatedWidgetKey.bridge(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: IllustrationColors.lightYellow,
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.easeInSine,
          userControlStream: userControlStream,
          status: status,
          x: 89,
          y: 58,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Bridge(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
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
    width: 3,
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

    if (widget.status.isDone) {
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
        child: Transform.scale(
          scale: 1.45,
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
        ),
      );
}
