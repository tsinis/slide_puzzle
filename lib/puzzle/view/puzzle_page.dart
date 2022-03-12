// ignore_for_file: avoid_types_on_closure_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../layout/layout.dart';
import '../../map/island_map.dart';
import '../../map/models/illustration_colors.dart';
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
            create: (_) => IslandMapThemeBloc(
              themes: const [GreenIslandMapTheme()],
            )..add(const IslandMapThemeChanged(themeIndex: 0)),
          ),
          BlocProvider(
            create: (_) =>
                IslandMapPuzzleBloc(secondsToBegin: 3, ticker: const Ticker()),
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
    const theme = GreenIslandMapTheme();

    return Scaffold(
      body: AnimatedContainer(
        duration: PuzzleThemeAnimationDuration.backgroundColorChange,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: BlocListener<IslandMapThemeBloc, IslandMapThemeState>(
          listener: (context, state) {},
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => TimerBloc(ticker: const Ticker())),
              BlocProvider(
                create: (_) => PuzzleBloc(4)
                  ..add(const PuzzleInitialized(isFirstRun: true)),
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
    const theme = GreenIslandMapTheme();
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return LayoutBuilder(
      builder: (context, constraints) => InteractiveViewer(
        maxScale: 4,
        minScale: 1,
        child: Stack(
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
            const WindStar(),
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
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class WindStar extends StatelessWidget {
  static const _url = 'github.com/tsinis/slide_puzzle';
  Widget get _logo => Hero(
        tag: 'hero',
        child: SvgPicture.asset('assets/vectors/windstar.svg'),
      );

  const WindStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      bottom: 0,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 1600),
        sizeCurve: Curves.easeInOutCubicEmphasized,
        crossFadeState: ((size.width / size.height) > 1)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        secondChild: const SizedBox.shrink(),
        firstChild: InkWell(
          child: SizedBox.square(
            dimension: 200,
            child: Opacity(opacity: 0.8, child: _logo),
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => Theme(
              data: ThemeData(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // This is a custom color variable
                    textStyle: const TextStyle(fontFamily: 'GoogleSans'),
                  ),
                ),
              ),
              child: AboutDialog(
                applicationIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: IllustrationColors.seaColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  width: 80,
                  height: 80,
                  child: _logo,
                ),
                applicationName: 'Map Slide Puzzle',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'A slide puzzle built for Flutter Challenge.',
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 4),
                    child: Center(
                      child: Text(
                        'Source code and more info:',
                        style: TextStyle(
                          color: IllustrationColors.midBlueCastle,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => openLink('https://$_url'),
                    child: const Text(_url),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    const theme = GreenIslandMapTheme();

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
class PuzzleSections extends StatefulWidget {
  /// {@macro puzzle_sections}
  const PuzzleSections({Key? key}) : super(key: key);

  @override
  State<PuzzleSections> createState() => _PuzzleSectionsState();
}

class _PuzzleSectionsState extends State<PuzzleSections> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return AnimatedOpacity(
      opacity: _isVisible ? 1 : 0,
      curve: Curves.easeIn,
      duration: const Duration(seconds: 1),
      child: Center(
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
      ),
    );
  }

  void _startAnimation() => Future<void>.delayed(
        const Duration(milliseconds: 600),
        () => setState(() => _isVisible = true),
      );
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
    const theme = GreenIslandMapTheme();
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.getDimension();
    if (size == 0) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white38,
          border:
              Border.all(color: IllustrationColors.lightBlueCastle, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
    const theme = GreenIslandMapTheme();
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
