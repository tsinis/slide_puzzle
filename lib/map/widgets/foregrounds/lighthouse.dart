import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Lighthouse extends AnimatedForegroundWidget {
  const Lighthouse({
    Stream<UserControl>? userControlStream,
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Color.fromARGB(200, 255, 255, 255),
            secondColor: Color.fromARGB(0, 255, 255, 255),
            loopDuration: Duration(milliseconds: 1000),
          ),
          size: const Size(200, 80),
          curve: Curves.fastLinearToSlowEaseIn,
          userControlStream: userControlStream,
          isDone: isDone,
          key: key,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Lighthouse(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<Lighthouse> createState() => _LighthouseState();
}

// ignore: lines_longer_than_80_chars
class _LighthouseState extends State<Lighthouse>
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
          builder: (_, __) => CustomPaint(
            size: widget.size,
            willChange: true,
            painter: _LighthousePainter(
              animation: _animation.value,
              primaryColor: widget.specification.firstColor,
              secondaryColor: widget.specification.secondColor,
            ),
          ),
        ),
      );
}

class _LighthousePainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final double animation;

  _LighthousePainter({
    required this.animation,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(
        Offset(size.width * 0.5, size.height * 0.5),
        size.width * 0.5 * animation,
        <Color>[primaryColor, secondaryColor],
        <double>[0, 1],
      );

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height * 0.6)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(0, size.height * 0.3)
      ..lineTo(0, size.height * 0.7)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
