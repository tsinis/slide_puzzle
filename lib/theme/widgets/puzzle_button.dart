import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../map/themes/green_island_map_theme.dart';
import '../../typography/typography.dart';
import '../theme.dart';

/// {@template puzzle_button}
/// Displays the puzzle action button.
/// {@endtemplate}
class PuzzleButton extends StatelessWidget {
  /// The background color of this button.
  /// Defaults to [PuzzleTheme.buttonColor].
  final Color? backgroundColor;

  /// The text color of this button.
  /// Defaults to [PuzzleColors.white].
  final Color? textColor;

  /// Called when this button is tapped.
  final VoidCallback? onPressed;

  /// The label of this button.
  final Widget child;

  /// {@macro puzzle_button}
  const PuzzleButton({
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();
    final buttonTextColor = textColor ?? PuzzleColors.white;
    final buttonBackgroundColor = backgroundColor ?? theme.buttonColor;

    return SizedBox(
      width: 145,
      height: 44,
      child: AnimatedTextButton(
        duration: PuzzleThemeAnimationDuration.textStyle,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: PuzzleTextStyle.headline5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.all(buttonBackgroundColor),
          foregroundColor: MaterialStateProperty.all(buttonTextColor),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
