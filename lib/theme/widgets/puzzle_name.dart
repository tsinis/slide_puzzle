import 'package:flutter/material.dart';

import '../../layout/layout.dart';
import '../../map/themes/green_island_map_theme.dart';
import '../../typography/typography.dart';
import '../theme.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class PuzzleName extends StatelessWidget {
  /// The color of this name, defaults to [PuzzleTheme.nameColor].
  final Color? color;

  /// {@macro puzzle_name}
  const PuzzleName({this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();
    final nameColor = color ?? theme.nameColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => AnimatedDefaultTextStyle(
        style: PuzzleTextStyle.headline5.copyWith(
          color: nameColor,
        ),
        duration: PuzzleThemeAnimationDuration.textStyle,
        child: Text(
          theme.name,
          key: const Key('puzzle_name_theme'),
        ),
      ),
    );
  }
}
