import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../layout/layout.dart';
import '../../map/themes/green_dashatar_theme.dart';
import '../../typography/typography.dart';
import '../theme.dart';

/// {@template number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class NumberOfMovesAndTilesLeft extends StatelessWidget {
  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The number of tiles left to be displayed.
  final int numberOfTilesLeft;

  /// The color of texts that display [numberOfMoves] and [numberOfTilesLeft].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  /// {@macro number_of_moves_and_tiles_left}
  const NumberOfMovesAndTilesLeft({
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenDashatarTheme();
    final l10n = context.l10n;
    final textColor = color ?? theme.defaultColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      child: (currentSize) {
        final bodyTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.body;

        return Semantics(
          label: l10n.puzzleNumberOfMovesAndTilesLeftLabelText(
            numberOfMoves.toString(),
            numberOfTilesLeft.toString(),
          ),
          child: ExcludeSemantics(
            child: Row(
              key: const Key('number_of_moves_and_tiles_left'),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AnimatedDefaultTextStyle(
                  key: const Key('number_of_moves_and_tiles_left_moves'),
                  style: PuzzleTextStyle.headline4.copyWith(
                    color: textColor,
                  ),
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text(numberOfMoves.toString()),
                ),
                AnimatedDefaultTextStyle(
                  style: bodyTextStyle.copyWith(
                    color: textColor,
                  ),
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text(' ${l10n.puzzleNumberOfMoves} | '),
                ),
                AnimatedDefaultTextStyle(
                  key: const Key('number_of_moves_and_tiles_left_tiles_left'),
                  style: PuzzleTextStyle.headline4.copyWith(
                    color: textColor,
                  ),
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text(numberOfTilesLeft.toString()),
                ),
                AnimatedDefaultTextStyle(
                  style: bodyTextStyle.copyWith(
                    color: textColor,
                  ),
                  duration: PuzzleThemeAnimationDuration.textStyle,
                  child: Text(' ${l10n.puzzleNumberOfTilesLeft}'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
