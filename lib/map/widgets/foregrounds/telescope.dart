import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/animated_widget_key.dart';
import '../../models/user_control.dart';

class Telescope extends AnimatedForegroundWidget {
  const Telescope({
    AnimatedWidgetKey status = const AnimatedWidgetKey.telescope(),
    Stream<UserControl>? userControlStream,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            secondColor: Colors.white,
            thirdColor: Color(0xFF5F5F5F),
            fourthColor: Color(0xFF777777),
            loopDuration: Duration(milliseconds: 2500),
          ),
          curve: Curves.decelerate,
          userControlStream: userControlStream,
          status: status,
          y: 30,
          x: 70,
        );

  @override
  AnimatedForegroundWidget copyWith({
    bool isDone = false,
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
  }) =>
      Telescope(
        userControlStream: userControlStream ?? this.userControlStream,
        status: status.copyWith(isDone: isDone),
      );

  @override
  State<Telescope> createState() => _TelescopeState();
}

class _TelescopeState extends State<Telescope>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      upperBound: 0.13,
      vsync: this,
    );
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
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 12,
              left: 14,
              child: SizedBox(
                width: 72,
                height: 72,
                child: Transform.rotate(
                  angle: -45 * (math.pi / 180),
                  child: RotationTransition(
                    turns: _animation,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 54,
                          child: Transform.rotate(
                            angle: -45 * (math.pi / 180),
                            child: Container(
                              width: 2,
                              height: 43.5,
                              decoration: BoxDecoration(
                                color: widget.specification.secondColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 16,
                          child: Transform.rotate(
                            angle: 45 * (math.pi / 180),
                            child: Container(
                              width: 2,
                              height: 43.5,
                              decoration: BoxDecoration(
                                color: widget.specification.secondColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 35,
                          child: Container(
                            width: 2,
                            height: 30,
                            decoration: BoxDecoration(
                              color: widget.specification.secondColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: ClipPath(
                              clipper: const _HalfCircleClipper(),
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: widget.specification.firstColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPaint(
                          size: const Size(72, 72),
                          painter:
                              _Groove(color: widget.specification.fourthColor),
                        ),
                        Positioned(
                          top: 0,
                          left: 31.5,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: widget.specification.firstColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 65,
              left: 22,
              child: SizedBox(
                width: 56,
                height: 35,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 19,
                      child: Container(
                        width: 18,
                        height: 35,
                        decoration: BoxDecoration(
                          color: widget.specification.thirdColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(17.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 0,
                      child: Container(
                        width: 56,
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.specification.fourthColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(17.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 23,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.specification.secondColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 26,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: widget.specification.fourthColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class _HalfCircleClipper extends CustomClipper<Path> {
  const _HalfCircleClipper();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _Groove extends CustomPainter {
  final Color color;
  const _Groove({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = color
      ..strokeWidth = 8;

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.66)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.85,
        size.width * 0.5,
        size.height * 0.86,
      )
      ..quadraticBezierTo(
        size.width * 0.74,
        size.height * 0.85,
        size.width * 0.82,
        size.height * 0.66,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
