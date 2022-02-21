import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class WebRainbow extends AnimatedForegroundWidget {
  const WebRainbow({
    AnimatedWidgetKey status = const AnimatedWidgetKey.rainbow(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.red,
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.slowMiddle,
          userControlStream: userControlStream,
          status: status,
          x: 16,
          y: 120,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      WebRainbow(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<WebRainbow> createState() => _WebRainbowState();
}

class _WebRainbowState extends State<WebRainbow>
    with SingleTickerProviderStateMixin {
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
    if (widget.status.isDone) {
      _controller.repeat();
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
          scale: 1.4,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) => ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                child: RotationTransition(
                  turns: _animation,
                  child: Stack(children: [const SizedBox(height: 125), child!]),
                ),
              ),
            ),
            child: const ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                child: _WebRainbowPart(
                  color: Colors.red,
                  radius: 125,
                  child: _WebRainbowPart(
                    color: Colors.orange,
                    radius: 120,
                    child: _WebRainbowPart(
                      color: Colors.yellow,
                      radius: 115,
                      child: _WebRainbowPart(
                        color: Colors.green,
                        radius: 110,
                        child: _WebRainbowPart(
                          color: Colors.lightBlue,
                          radius: 105,
                          child: _WebRainbowPart(
                            color: Colors.blue,
                            radius: 100,
                            child: _WebRainbowPart(
                              color: Colors.purple,
                              radius: 95,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

// ignore: prefer-single-widget-per-file
class _WebRainbowPart extends StatelessWidget {
  final double radius;
  final Color color;
  final double strokeWidth;
  final Widget? child;

  const _WebRainbowPart({
    required this.color,
    required this.radius,
    this.strokeWidth = 5,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: strokeWidth),
          shape: BoxShape.circle,
        ),
        child: Center(child: child),
      );
}
