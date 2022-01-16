import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../layout/layout.dart';
import '../../typography/typography.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// The title to be displayed.
  final String title;

  /// The color of the [title], defaults to [PuzzleColors.primary1].
  final Color? color;

  /// {@macro puzzle_title}
  const PuzzleTitle({
    required this.title,
    this.color = PuzzleColors.primary1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponsiveLayoutBuilder(
        small: (context, child) => Center(
          child: SizedBox(
            width: 300,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: PuzzleTextStyle.headline3.copyWith(
                  color: color,
                ),
              ),
            ),
          ),
        ),
        medium: (context, child) => Center(
          child: Text(
            title,
            style: PuzzleTextStyle.headline3.copyWith(
              color: color,
            ),
          ),
        ),
      );
}
