import 'dart:async';

import 'package:flutter/material.dart';

import '../models/animated_background_widget.dart';
import '../models/animated_foreground_widget.dart';
import '../models/user_control.dart';
import 'foregrounds/balloon.dart';
import 'foregrounds/bridge.dart';
import 'foregrounds/crane.dart';
import 'foregrounds/gate.dart';
import 'foregrounds/lighthouse.dart';
import 'foregrounds/smoke.dart';
import 'foregrounds/submarine.dart';
import 'foregrounds/telescope.dart';
import 'foregrounds/train.dart';
import 'foregrounds/wheel.dart';
import 'foregrounds/windmill.dart';

class AnimatedTile extends StatefulWidget {
  final ValueKey<int> index;
  final VoidCallback onPressed;
  final Size? size;

  const AnimatedTile({
    required this.index,
    required this.onPressed,
    this.size = const Size.square(250),
  }) : super(key: index);

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  final StreamController<UserControl> _userControl =
      StreamController<UserControl>();
  final List<AnimatedForegroundWidget> _types =
      const <AnimatedForegroundWidget>[
    Bridge(),
    Balloon(),
    Train(),
    Gate(),
    Submarine(),
    Crane(),
    Lighthouse(),
    Windmill(),
    Smoke(),
    Telescope(),
    Wheel(),
    Balloon(),
    Bridge(),
    Balloon(),
    Train(),
    Gate(),
  ];

  AnimatedForegroundWidget get foreground =>
      _types.elementAt(widget.index.value).copyWith(
            userControlStream: _userControl.stream,
          );

  @override
  void dispose() {
    _userControl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          _userControl.add(UserControl.singlePress);
          widget.onPressed();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: FittedBox(
            child: ColoredBox(
              color: Colors.orange, //TODO: Remove.
              child: SizedBox.fromSize(
                size: widget.size,
                child: Stack(
                  children: <Widget>[
                    AnimatedBackgroundWidget(widget.index.value),
                    foreground,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
