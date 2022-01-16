import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../colors/colors.dart';
import '../l10n/l10n.dart';
import '../models/models.dart';
import '../puzzle/puzzle.dart';
import '../theme/theme.dart';
import '../typography/typography.dart';
import 'layout.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  @override
  List<Object?> get props => [];

  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) => Column(
        children: [
          const ResponsiveGap(small: 3, medium: 6),
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            child: (_) => SimpleStartSection(state: state),
          ),
          const ResponsiveGap(small: 12, medium: 24),
        ],
      );

  @override
  Widget endSectionBuilder(PuzzleState state) => Column(
        children: [
          const ResponsiveGap(small: 18, medium: 36),
          ResponsiveLayoutBuilder(
            small: (_, child) => const SimplePuzzleShuffleButton(),
            medium: (_, child) => const SimplePuzzleShuffleButton(),
          ),
          const ResponsiveGap(small: 3, medium: 6),
        ],
      );

  @override
  Widget backgroundBuilder(PuzzleState state) => Positioned(
        right: 0,
        bottom: 0,
        child: ResponsiveLayoutBuilder(
          small: (_, __) => SizedBox(
            width: 184,
            height: 118,
            child: Image.asset(
              'assets/images/simple_dash_small.png',
              key: const Key('simple_puzzle_dash_small'),
            ),
          ),
          medium: (_, __) => SizedBox(
            width: 380.44,
            height: 214,
            child: Image.asset(
              'assets/images/simple_dash_medium.png',
              key: const Key('simple_puzzle_dash_medium'),
            ),
          ),
        ),
      );

  @override
  Widget boardBuilder(int size, List<Widget> tiles) => Column(
        children: [
          ResponsiveLayoutBuilder(
            small: (_, __) => SizedBox.square(
              dimension: _BoardSize.small,
              child: SimplePuzzleBoard(
                key: const Key('simple_puzzle_board_small'),
                size: size,
                tiles: tiles,
                spacing: 5,
              ),
            ),
            medium: (_, __) => SizedBox.square(
              dimension: _BoardSize.medium,
              child: SimplePuzzleBoard(
                key: const Key('simple_puzzle_board_medium'),
                size: size,
                tiles: tiles,
              ),
            ),
          ),
          const ResponsiveGap(large: 96),
        ],
      );

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) => ResponsiveLayoutBuilder(
        small: (_, __) => SimplePuzzleTile(
          key: Key('simple_puzzle_tile_${tile.value}_small'),
          tile: tile,
          tileFontSize: _TileFontSize.small,
          state: state,
        ),
        medium: (_, __) => SimplePuzzleTile(
          key: Key('simple_puzzle_tile_${tile.value}_medium'),
          tile: tile,
          tileFontSize: _TileFontSize.medium,
          state: state,
        ),
      );

  @override
  Widget whitespaceTileBuilder() => const SizedBox();
}

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class SimpleStartSection extends StatelessWidget {
  /// The state of the puzzle.
  final PuzzleState state;

  /// {@macro simple_start_section}
  const SimpleStartSection({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberOfMovesAndTilesLeft(
              numberOfMoves: state.numberOfMoves,
              numberOfTilesLeft: state.numberOfTilesLeft,
            ),
            const ResponsiveGap(large: 32),
            ResponsiveLayoutBuilder(
              small: (_, __) => const SizedBox(),
              medium: (_, __) => const SizedBox(),
            ),
          ],
        ),
      );
}

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class SimplePuzzleTitle extends StatelessWidget {
  /// The state of the puzzle.
  final PuzzleStatus status;

  /// {@macro simple_puzzle_title}
  const SimplePuzzleTitle({
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PuzzleTitle(
        title: status == PuzzleStatus.complete
            ? context.l10n.puzzleCompleted
            : context.l10n.puzzleChallengeTitle,
      );
}

// ignore: avoid_classes_with_only_static_members
abstract class _BoardSize {
  static const double small = 312;
  static const double medium = 424;
}

/// {@template simple_puzzle_board}
/// Display the board of the puzzle in a [size]x[size] layout
/// filled with [tiles]. Each tile is spaced with [spacing].
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class SimplePuzzleBoard extends StatelessWidget {
  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The spacing between each tile from [tiles].
  final double spacing;

  /// {@macro simple_puzzle_board}
  const SimplePuzzleBoard({
    required this.size,
    required this.tiles,
    this.spacing = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: size,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        children: tiles,
      );
}

// ignore: avoid_classes_with_only_static_members
abstract class _TileFontSize {
  static const double small = 36;
  static const double medium = 50;
}

/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class SimplePuzzleTile extends StatelessWidget {
  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  /// {@macro simple_puzzle_tile}
  const SimplePuzzleTile({
    required this.tile,
    required this.tileFontSize,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    return TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(
          fontSize: tileFontSize,
        ),
        shape: const RoundedRectangleBorder(),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (tile.value == state.lastTappedTile?.value) {
              return theme.pressedColor;
            } else if (states.contains(MaterialState.hovered)) {
              return theme.hoverColor;
            } else {
              return theme.defaultColor;
            }
          },
        ),
      ),
      onPressed: state.puzzleStatus == PuzzleStatus.incomplete
          ? () => context.read<PuzzleBloc>().add(TileTapped(tile))
          : null,
      child: Text(tile.value.toString()),
    );
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PuzzleButton(
        textColor: PuzzleColors.primary0,
        backgroundColor: PuzzleColors.primary6,
        onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/shuffle_icon.png',
              width: 17,
              height: 17,
            ),
            const Gap(10),
            Text(context.l10n.puzzleShuffle),
          ],
        ),
      );
}
