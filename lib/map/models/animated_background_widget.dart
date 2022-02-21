import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'animated_stateful_widget.dart';
import 'animated_widget_key.dart';

class AnimatedBackgroundWidget extends AnimatedStatefulWidget {
  const AnimatedBackgroundWidget({
    required AnimatedWidgetKey status,
    Curve curve = Curves.easeOutSine,
  }) : super(status: status, curve: curve);

  @override
  State<AnimatedBackgroundWidget> createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.moveDuration,
      vsync: this,
    )..value = 1;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    widget.status.isDone ? _controller.reverse() : _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onHover(PointerEvent event) {
    event is PointerExitEvent ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: onHover,
        onExit: onHover,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) => ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey.withOpacity(
                widget.status.isDone ? 0 : _controller.value,
              ),
              BlendMode.saturation,
            ),
            child: SvgPicture.asset(
              'assets/vectors/${widget.status.backgroundIndex}.svg',
            ),
          ),
        ),
      );
}
