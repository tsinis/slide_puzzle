import 'package:flutter/material.dart';

import '../../layout/layout.dart';
import '../../map/themes/green_island_map_theme.dart';
import '../../typography/typography.dart';
import '../theme.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// The title to be displayed.
  final String title;

  /// The color of [title], defaults to [PuzzleTheme.titleColor].
  final Color? color;

  /// {@macro puzzle_title}
  const PuzzleTitle({required this.title, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();
    final titleColor = color ?? theme.titleColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: child,
      ),
      child: (currentSize) {
        final textStyle = PuzzleTextStyle.headline3.copyWith(color: titleColor);

        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: textStyle,
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            title,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
