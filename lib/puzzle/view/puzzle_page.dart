// ignore_for_file: avoid_types_on_closure_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../audio_control/audio_control.dart';
import '../../layout/layout.dart';
import '../../map/dashatar.dart';
import '../../models/models.dart';
import '../../theme/theme.dart';
import '../../timer/timer.dart';
import '../puzzle.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]

/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DashatarThemeBloc(
              themes: const [GreenDashatarTheme()],
            )..add(const DashatarThemeChanged(themeIndex: 0)),
          ),
          BlocProvider(
            create: (_) =>
                DashatarPuzzleBloc(secondsToBegin: 3, ticker: const Ticker()),
          ),
          BlocProvider(create: (_) => TimerBloc(ticker: const Ticker())),
          BlocProvider(create: (_) => AudioControlBloc()),
        ],
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
    const theme = GreenDashatarTheme();

    return Scaffold(
      body: AnimatedContainer(
        duration: PuzzleThemeAnimationDuration.backgroundColorChange,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: BlocListener<DashatarThemeBloc, DashatarThemeState>(
          listener: (context, state) {},
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => TimerBloc(ticker: const Ticker())),
              BlocProvider(
                create: (_) => PuzzleBloc(4)..add(const PuzzleInitialized()),
              ),
            ],
            child: const _Puzzle(key: Key('puzzle_view_puzzle')),
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
    const theme = GreenDashatarTheme();
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        alignment: Alignment.center,
        children: [
          GridPaper(
            interval: 1000,
            divisions: 3,
            subdivisions: 3,
            child: UnconstrainedBox(
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: theme.layoutDelegate.backgroundBuilder(state),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox.square(
              dimension: 240,
              child: SvgPicture.asset('assets/vectors/windstar.svg'),
            ),
          ),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: const FittedBox(
                  child: PuzzleSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template puzzle_logo}
/// Displays the logo of the puzzle.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class PuzzleLogo extends StatelessWidget {
  /// {@macro puzzle_logo}
  const PuzzleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenDashatarTheme();

    return AppFlutterLogo(
      key: puzzleLogoKey,
      isColored: theme.isLogoColored,
    );
  }
}

/// {@template puzzle_sections}
/// Displays start and end sections of the puzzle.
/// {@endtemplate}
// ignore: prefer-single-widget-per-file
class PuzzleSections extends StatelessWidget {
  /// {@macro puzzle_sections}
  const PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenDashatarTheme();
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return Center(
      child: Column(
        children: [
          UnconstrainedBox(
            child: theme.layoutDelegate.startSectionBuilder(state),
          ),
          const ResponsiveGap(small: 8, medium: 16),
          const PuzzleBoard(),
          const ResponsiveGap(small: 16, medium: 24),
          theme.layoutDelegate.endSectionBuilder(state),
        ],
      ),
    );
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenDashatarTheme();
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.getDimension();
    if (size == 0) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white60,
          border: Border.all(color: Colors.blue, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: PuzzleKeyboardHandler(
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
    const theme = GreenDashatarTheme();
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    final isComplete = state.puzzleStatus == PuzzleStatus.complete;

    if (isComplete) {
      return theme.layoutDelegate.tileBuilder(tile, state);
    }

    return tile.isWhitespace
        ? theme.layoutDelegate.whitespaceTileBuilder()
        : theme.layoutDelegate.tileBuilder(tile, state);
  }
}

/// The global key of [PuzzleLogo].
///
/// Used to animate the transition of [PuzzleLogo] when changing a theme.
final puzzleLogoKey = GlobalKey(debugLabel: 'puzzle_logo');

/// The global key of [PuzzleName].
///
/// Used to animate the transition of [PuzzleName] when changing a theme.
final puzzleNameKey = GlobalKey(debugLabel: 'puzzle_name');

/// The global key of [PuzzleTitle].
///
/// Used to animate the transition of [PuzzleTitle] when changing a theme.
final puzzleTitleKey = GlobalKey(debugLabel: 'puzzle_title');

/// The global key of [NumberOfMovesAndTilesLeft].
///
/// Used to animate the transition of [NumberOfMovesAndTilesLeft]
/// when changing a theme.
final numberOfMovesAndTilesLeftKey =
    GlobalKey(debugLabel: 'number_of_moves_and_tiles_left');

/// The global key of [AudioControl].
///
/// Used to animate the transition of [AudioControl]
/// when changing a theme.
final audioControlKey = GlobalKey(debugLabel: 'audio_control');
