import 'dart:async';

import 'package:flutter/material.dart';

import '../models/animated_background_widget.dart';
import '../models/animated_foreground_widget.dart';
import '../models/user_control.dart';
import 'foregrounds/smoke.dart';
import 'foregrounds/telescope.dart';
import 'foregrounds/wheel.dart';

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
    Smoke(),
    Telescope(),
    Wheel(),
    Smoke(),
    Telescope(),
    Wheel(),
    Smoke(),
    Telescope(),
    Wheel(),
    Smoke(),
    Telescope(),
    Wheel(),
    Smoke(),
    Telescope(),
    Wheel(),
    Smoke(),
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