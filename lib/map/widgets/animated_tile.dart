import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../puzzle/bloc/puzzle_bloc.dart';
import '../models/animated_background_widget.dart';
import '../models/animated_foreground_widget.dart';
import '../models/animated_widget_key.dart';
import '../models/user_control.dart';
import 'foregrounds/constants.dart';

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
      StreamController<UserControl>.broadcast();

  AnimatedForegroundWidget? _foreground;

  bool get isSeaForeground => index == 8;
  int get index => widget.index.value - 1;

  @override
  void initState() {
    super.initState();
    _foreground = foregrounds.elementAt(index)?.copyWith(
          userControlStream: _userControl.stream,
        );
  }

  Widget foreground({bool isComplete = false}) {
    if (_foreground?.status.isDone != isComplete) {
      _foreground = _foreground?.copyWith(isDone: isComplete);
    }

    return _foreground ?? const SizedBox.shrink();
  }

  @override
  void dispose() {
    _userControl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    final isComplete = state.puzzleStatus == PuzzleStatus.complete;

    return InkWell(
      onTap: () {
        _userControl.add(UserControl.singlePress);
        widget.onPressed();
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FittedBox(
          child: ColoredBox(
            color: seaColor, //TODO: Remove.
            child: SizedBox.fromSize(
              size: widget.size,
              child: Stack(
                children: <Widget>[
                  if (isSeaForeground) foreground(isComplete: isComplete),
                  AnimatedBackgroundWidget(
                    status: AnimatedWidgetKey.background(
                      widget.index.value,
                      isDone: isComplete,
                    ),
                  ),
                  if (!isSeaForeground) foreground(isComplete: isComplete),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
