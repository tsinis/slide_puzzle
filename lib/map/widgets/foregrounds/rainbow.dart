import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class Rainbow extends AnimatedForegroundWidget {
  const Rainbow({
    AnimatedWidgetKey status = const AnimatedWidgetKey.rainbow(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.red,
            loopDuration: Duration(milliseconds: 1500),
          ),
          curve: Curves.easeInCirc,
          userControlStream: userControlStream,
          status: status,
          size: const Size(160, 200),
          x: 40,
          y: 120,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Rainbow(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Rainbow> createState() => _RainbowState();
}

class _RainbowState extends State<Rainbow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: Curves.easeOutCirc,
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
        child: SizedBox.fromSize(
          size: widget.size,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) => _RainbowPart(
              animation: _animation,
              color: Colors.purple,
              strokeWidth: 35,
              child: _RainbowPart(
                animation: _animation,
                color: Colors.blue,
                strokeWidth: 30,
                child: _RainbowPart(
                  animation: _animation,
                  color: Colors.lightBlue,
                  strokeWidth: 25,
                  child: _RainbowPart(
                    animation: _animation,
                    color: Colors.green,
                    strokeWidth: 20,
                    child: _RainbowPart(
                      animation: _animation,
                      color: Colors.yellow,
                      strokeWidth: 15,
                      child: _RainbowPart(
                        animation: _animation,
                        color: Colors.orange,
                        strokeWidth: 10,
                        child: _RainbowPart(
                          animation: _animation,
                          color: Colors.red,
                          strokeWidth: 5,
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
class _RainbowPart extends StatelessWidget {
  final Animation<double> animation;
  final Widget? child;
  final double strokeWidth;
  final double radius;
  final Color color;

  const _RainbowPart({
    required this.animation,
    required this.color,
    required this.strokeWidth,
    this.radius = 180,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _GradientPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, -animation.value),
            colors: <Color>[color, color.withOpacity(0)],
          ),
        ),
        child: SizedBox.square(
          dimension: radius,
          child: child,
        ),
      );
}

class _GradientPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final outerRect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(radius),
    );

    final innerRect = Rect.fromLTWH(
      strokeWidth,
      strokeWidth,
      size.width - strokeWidth * 2,
      size.height - strokeWidth * 2,
    );
    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(radius - strokeWidth),
    );

    final paint = Paint()..shader = gradient.createShader(outerRect);

    final outer = Path()..addRRect(outerRRect);
    final inner = Path()..addRRect(innerRRect);
    final path = Path.combine(PathOperation.difference, outer, inner);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
