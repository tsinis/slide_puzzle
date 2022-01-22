import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../layout/layout.dart';
import '../../puzzle/puzzle.dart';
import '../../timer/timer.dart';
import '../dashatar.dart';

// ignore: avoid_classes_with_only_static_members
abstract class _BoardSize {
  static const double small = 312;
  static const double medium = 424;
}

/// {@template dashatar_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class DashatarPuzzleBoard extends StatefulWidget {
  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// {@macro dashatar_puzzle_board}
  const DashatarPuzzleBoard({required this.tiles, Key? key}) : super(key: key);

  @override
  State<DashatarPuzzleBoard> createState() => _DashatarPuzzleBoardState();
}

class _DashatarPuzzleBoardState extends State<DashatarPuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    _completePuzzleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<PuzzleBloc, PuzzleState>(
        listener: (context, state) async {
          if (state.puzzleStatus == PuzzleStatus.complete) {
            _completePuzzleTimer =
                Timer(const Duration(milliseconds: 370), () async {
              await showAppDialog<void>(
                context: context,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<PuzzleBloc>()),
                    BlocProvider.value(value: context.read<TimerBloc>()),
                    BlocProvider.value(value: context.read<AudioControlBloc>()),
                    BlocProvider.value(
                      value: context.read<DashatarThemeBloc>(),
                    ),
                  ],
                  child: const DashatarShareDialog(),
                ),
              );
            });
          }
        },
        child: ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox.square(
            key: const Key('dashatar_puzzle_board_small'),
            dimension: _BoardSize.small,
            child: child,
          ),
          medium: (_, child) => SizedBox.square(
            key: const Key('dashatar_puzzle_board_medium'),
            dimension: _BoardSize.medium,
            child: child,
          ),
          child: (_) => Stack(children: widget.tiles),
        ),
      );
}
