import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class Whale extends AnimatedForegroundWidget {
  const Whale({
    AnimatedWidgetKey status = const AnimatedWidgetKey.whale(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            secondColor: Colors.white,
            thirdColor: Color(0xFF5F5F5F),
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.decelerate,
          userControlStream: userControlStream,
          status: status,
          x: 40,
          y: 66,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Whale(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Whale> createState() => _WhaleState();
}

class _WhaleState extends State<Whale> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final ReverseAnimation _reverseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    if (widget.status.isDone) {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      );
      _controller.repeat();
    } else {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }
    _reverseAnimation = ReverseAnimation(_animation);
    widget.userControlStream?.listen(
      (userEvent) => userEvent.maybeWhen(
        orElse: () => _controller.forward(from: 0),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: widget.x, top: widget.y),
        child: RotatedBox(
          quarterTurns: 0,
          child: RotationTransition(
            turns: _reverseAnimation,
            child: SizedBox(
              height: 200,
              child: AnimatedBuilder(
                animation: _reverseAnimation,
                builder: (_, __) => Opacity(
                  opacity: _reverseAnimation.value,
                  child: CustomPaint(
                    size: const Size(100, 100),
                    willChange: true,
                    painter: _WhalePainter(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _WhalePainter extends CustomPainter {
  @override
  // ignore: long-method
  void paint(Canvas canvas, Size size) {
    final square = Size.square(size.width);
    final holePaint = Paint();
    final bodyPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(square.width * 0.5, square.height * 0.26),
        Offset(square.width * 0.5, square.height * 0.74),
        const <Color>[
          ui.Color.fromARGB(183, 99, 99, 99),
          ui.Color.fromARGB(255, 94, 94, 94),
          Color(0xff676767),
          Color(0xff535353),
          Color(0xff535353),
          ui.Color.fromARGB(181, 83, 83, 83),
        ],
        <double>[0, 0.2, 0.49, 0.51, 0.8, 1],
      );

    final bodyPath = Path()
      ..moveTo(square.width * 0.32, square.height * 0.6)
      ..quadraticBezierTo(
        square.width * 0.06,
        square.height * 0.57846,
        0,
        square.height * 0.5,
      )
      ..quadraticBezierTo(
        square.width * 0.06,
        square.height * 0.42,
        square.width * 0.32,
        square.height * 0.4,
      )
      ..quadraticBezierTo(
        square.width * 0.34,
        square.height * 0.23,
        square.width * 0.52,
        square.height * 0.262,
      )
      ..quadraticBezierTo(
        square.width * 0.46,
        square.height * 0.32,
        square.width * 0.44,
        square.height * 0.37,
      )
      ..quadraticBezierTo(
        square.width * 0.435,
        square.height * 0.39,
        square.width * 0.42,
        square.height * 0.4,
      )
      ..quadraticBezierTo(
        square.width * 0.684,
        square.height * 0.44,
        square.width * 0.8,
        square.height * 0.48,
      )
      ..quadraticBezierTo(
        square.width * 0.817,
        square.height * 0.485,
        square.width * 0.84,
        square.height * 0.478,
      )
      ..quadraticBezierTo(
        square.width * 0.86,
        square.height * 0.467,
        square.width * 0.878,
        square.height * 0.44,
      )
      ..cubicTo(
        square.width * 0.92,
        square.height * 0.34,
        square.width * 0.98,
        square.height * 0.33,
        square.width,
        square.height * 0.34,
      )
      ..quadraticBezierTo(
        square.width * 0.97,
        square.height * 0.348,
        square.width * 0.928,
        square.height * 0.5,
      )
      ..quadraticBezierTo(
        square.width * 0.973,
        square.height * 0.65,
        square.width,
        square.height * 0.66,
      )
      ..cubicTo(
        square.width * 0.968,
        square.height * 0.658,
        square.width * 0.923,
        square.height * 0.66,
        square.width * 0.88,
        square.height * 0.56,
      )
      ..quadraticBezierTo(
        square.width * 0.868,
        square.height * 0.534,
        square.width * 0.84,
        square.height * 0.522,
      )
      ..quadraticBezierTo(
        square.width * 0.817,
        square.height * 0.51,
        square.width * 0.8,
        square.height * 0.52,
      )
      ..quadraticBezierTo(
        square.width * 0.6827,
        square.height * 0.576,
        square.width * 0.42,
        square.height * 0.6,
      )
      ..quadraticBezierTo(
        square.width * 0.434,
        square.height * 0.6,
        square.width * 0.44,
        square.height * 0.62,
      )
      ..quadraticBezierTo(
        square.width * 0.46,
        square.height * 0.68,
        square.width * 0.518,
        square.height * 0.742,
      )
      ..quadraticBezierTo(
        square.width * 0.3415,
        square.height * 0.67,
        square.width * 0.32,
        square.height * 0.598,
      )
      ..close();

    canvas
      ..drawPath(bodyPath, bodyPaint)
      ..drawCircle(
        Offset(square.width * 0.18, square.height * 0.5),
        0.6,
        holePaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
