// ignore_for_file: avoid_types_on_closure_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout.dart';
import '../../models/models.dart';
import '../../theme/theme.dart';
import '../../timer/timer.dart';
import '../puzzle.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ThemeBloc(
          themes: const [
            SimpleTheme(),
          ],
        ),
        child: const PuzzleView(),
      );
}

/// {@template puzzle_view}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
// ignore: prefer-single-widget-per-file
class PuzzleView extends StatelessWidget {
  /// {@macro puzzle_view}
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    /// Shuffle only if the current theme is Simple.
    final shufflePuzzle = theme is SimpleTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: BlocProvider(
        create: (context) => TimerBloc(
          ticker: const Ticker(),
        ),
        child: BlocProvider(
          create: (context) => PuzzleBloc(4)
            ..add(PuzzleInitialized(shufflePuzzle: shufflePuzzle)),
          child: const _Puzzle(
            key: Key('puzzle_view_puzzle'),
          ),
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return GridPaper(
      interval: 1000,
      divisions: 3,
      subdivisions: 3,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: [
            theme.layoutDelegate.backgroundBuilder(state),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: const Center(
                  child: _PuzzleSections(
                    key: Key('puzzle_sections'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class _PuzzleSections extends StatelessWidget {
  const _PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return Padding(
      padding: const EdgeInsets.all(66),
      child: ResponsiveLayoutBuilder(
        small: (context, child) => Column(
          children: [
            theme.layoutDelegate.startSectionBuilder(state),
            const PuzzleBoard(),
            theme.layoutDelegate.endSectionBuilder(state),
          ],
        ),
        medium: (context, child) => Column(
          children: [
            theme.layoutDelegate.startSectionBuilder(state),
            const PuzzleBoard(),
            theme.layoutDelegate.endSectionBuilder(state),
          ],
        ),
      ),
    );
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
// ignore: prefer-single-widget-per-file
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.getDimension();
    if (size == 0) {
      return const CircularProgressIndicator();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white60,
        border: Border.all(color: Colors.blue, width: 4),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: BlocListener<PuzzleBloc, PuzzleState>(
            listener: (context, state) {
              if (theme.hasTimer &&
                  state.puzzleStatus == PuzzleStatus.complete) {
                context.read<TimerBloc>().add(const TimerStopped());
              }
            },
            child: theme.layoutDelegate.boardBuilder(
              size,
              puzzle.tiles
                  .map(
                    (tile) => _PuzzleTile(
                      key: Key('puzzle_tile_${tile.value.toString()}'),
                      tile: tile,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class _PuzzleTile extends StatelessWidget {
  /// The tile to be displayed.
  final Tile tile;

  const _PuzzleTile({required this.tile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return tile.isWhitespace
        ? theme.layoutDelegate.whitespaceTileBuilder()
        : theme.layoutDelegate.tileBuilder(tile, state);
  }
}
