import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class Windmill extends AnimatedForegroundWidget {
  const Windmill({
    AnimatedWidgetKey status = const AnimatedWidgetKey.windmill(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.amber,
            secondColor: Colors.white,
            thirdColor: Color(0xFF5F5F5F),
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          userControlStream: userControlStream,
          status: status,
          x: 0,
          y: 40,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Windmill(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Windmill> createState() => _WindmillState();
}

class _WindmillState extends State<Windmill>
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
          scale: 1.78,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) => CustomPaint(
              willChange: true,
              painter: _WindmillPainter(
                angle: _animation.value,
                primaryColor: widget.specification.firstColor,
                secondaryColor: widget.specification.secondColor,
                thirdColor: widget.specification.thirdColor,
              ),
            ),
          ),
        ),
      );
}

class _WindmillPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;
  final Size widgetSize;
  final double angle;
  _WindmillPainter({
    required this.angle,
    this.primaryColor = Colors.amber,
    this.secondaryColor = Colors.grey,
    this.thirdColor = Colors.white,
    this.widgetSize = const Size.square(100),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wingsPaint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final outerCircle = Paint()..color = secondaryColor;

    final innerCircle = Paint()
      ..color = thirdColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final wingsPath = Path()
      ..moveTo(widgetSize.width * 0.496, widgetSize.height * 0.479)
      ..lineTo(widgetSize.width * 0.444, widgetSize.height * 0.328)
      ..lineTo(widgetSize.width * 0.474, widgetSize.height * 0.082)
      ..lineTo(widgetSize.width * 0.526, widgetSize.height * 0.028)
      ..lineTo(widgetSize.width * 0.522, widgetSize.height * 0.484)
      ..lineTo(widgetSize.width * 0.504, widgetSize.height * 0.507)
      ..lineTo(widgetSize.width * 0.664, widgetSize.height * 0.534)
      ..lineTo(widgetSize.width * 0.868, widgetSize.height * 0.674)
      ..lineTo(widgetSize.width * 0.898, widgetSize.height * 0.762)
      ..lineTo(widgetSize.width * 0.498, widgetSize.height * 0.524)
      ..lineTo(widgetSize.width * 0.495, widgetSize.height * 0.501)
      ..lineTo(widgetSize.width * 0.386, widgetSize.height * 0.622)
      ..lineTo(widgetSize.width * 0.15, widgetSize.height * 0.73)
      ..lineTo(widgetSize.width * 0.07, widgetSize.height * 0.712)
      ..lineTo(widgetSize.width * 0.496, widgetSize.height * 0.479)
      ..close();

    final cx = widgetSize.width * 0.5;
    final cy = widgetSize.height * 0.5;

    final radians = -angle * 180 * math.pi;

    canvas
      ..translate(cx, cy)
      ..rotate(radians)
      ..translate(-cx, -cy)
      ..drawPath(wingsPath, wingsPaint)
      ..drawCircle(Offset(cx, cy), widgetSize.width / 10, outerCircle)
      ..drawCircle(Offset(cx, cy), widgetSize.width / 20, innerCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
