import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/animated_foreground_specs.dart';
import '../../models/animated_foreground_widget.dart';
import '../../models/user_control.dart';

class Smoke extends AnimatedForegroundWidget {
  final Size size;

  const Smoke({
    Stream<UserControl>? userControlStream,
    this.size = const Size(100, 100),
    bool isDone = false,
    Key? key,
  }) : super(
          specification: const AnimatedForegroundSpecs(
            firstColor: Colors.grey,
            loopDuration: Duration(seconds: 3),
          ),
          curve: Curves.decelerate,
          userControlStream: userControlStream,
          isDone: isDone,
          key: key,
          x: 120,
          y: -100,
        );

  @override
  AnimatedForegroundWidget copyWith({
    Stream<UserControl>? userControlStream,
    AnimatedForegroundSpecs? specification,
    bool? isDone,
    Key? key,
  }) =>
      Smoke(
        userControlStream: userControlStream ?? this.userControlStream,
        isDone: isDone ?? this.isDone,
        key: key ?? this.key,
      );

  @override
  State<StatefulWidget> createState() => _SmokeState();
}

class _SmokeState extends State<Smoke> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<SmokeCloud> _smokeClouds = <SmokeCloud>[];
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _generateClouds();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(() {
        for (var i = 0; i < _smokeClouds.length; i++) {
          _smokeClouds[i].move();

          if (_smokeClouds[i].remainingLife < 0) {
            if (!_isComplete) {
              _smokeClouds[i] = SmokeCloud(
                widget.size,
                widget.x,
                widget.y,
              );
            }
            if (_smokeClouds[i].radius > widget.size.width / 4 &&
                !widget.isDone) {
              _smokeClouds.removeAt(i);
            }
          }
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isComplete = true;
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed &&
            _smokeClouds.isNotEmpty) {
          _controller.forward();
        }
      })
      ..forward();
    if (widget.isDone) {
      _controller.repeat(reverse: true);
    }
    widget.userControlStream?.listen(_userControlListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: widget.size,
          painter: _DemoPainter(_smokeClouds),
        ),
      );

  void _generateClouds() => List<void>.generate(
        240,
        (_) => _smokeClouds.add(
          SmokeCloud(
            widget.size,
            widget.x,
            widget.y,
          ),
        ),
      );

  void _userControlListener(UserControl userEvent) => userEvent.maybeWhen(
        orElse: () {
          if (_smokeClouds.isEmpty) {
            _isComplete = false;
            _generateClouds();
            _controller.forward();
          }
        },
      );
}

class _DemoPainter extends CustomPainter {
  final List<SmokeCloud> _smokeClouds;

  _DemoPainter(this._smokeClouds);

  @override
  void paint(Canvas canvas, _) {
    for (final cloud in _smokeClouds) {
      cloud.display(canvas);
    }
  }

  @override
  bool shouldRepaint(_DemoPainter oldDelegate) => true;
}

class SmokeCloud {
  final double x;
  final double y;
  late Color color;
  late final double life;
  late Offset location;
  late double opacity;
  late double radius;
  late double remainingLife;
  final Size size;
  late final Offset speed;

  final List<Color> _colors = <Color>[];

  SmokeCloud(this.size, this.x, this.y) {
    final _generator = Random();
    final random = _generator.nextDouble();
    speed = Offset(-6 + _generator.nextDouble() * 10, -20 + random * 16);
    location = Offset((size.width / 2) + x, (size.height * 3) + y);
    radius = 12 + random * 20;
    life = 2 + random * 100;
    remainingLife = life;

    for (var i = 10; i < 100; i++) {
      _colors.add(HSLColor.fromAHSL(0, 0, 1, i / 100).toColor());
    }

    color = _colors.first;
  }

  void display(Canvas canvas) {
    opacity = (remainingLife / life * 40).round() / 100;
    final Gradient gradient = RadialGradient(
      colors: <Color>[
        Color.fromRGBO(200, 200, 200, opacity),
        Color.fromRGBO(200, 200, 200, opacity),
        const Color.fromRGBO(200, 200, 200, 0),
      ],
      stops: const <double>[0, 0.2, 0.8],
    );

    final painter = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
        Rect.fromCircle(center: location, radius: radius),
      );

    canvas.drawCircle(location, radius, painter);
  }

  void move() {
    remainingLife--;
    radius++;
    location = location + speed;
    final colorI =
        _colors.length - (remainingLife / life * _colors.length).round();
    if (colorI >= 0 && colorI < _colors.length) {
      color = _colors[colorI];
    }
  }
}
