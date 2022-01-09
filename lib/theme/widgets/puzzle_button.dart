import 'package:flutter/material.dart';

import '../../typography/text_styles.dart';

/// {@template puzzle_button}
/// Displays the puzzle action button.
/// {@endtemplate}
class PuzzleButton extends StatelessWidget {
  /// The background color of this button.
  final Color? backgroundColor;

  /// The text color of this button.
  final Color? textColor;

  /// Called when this button is tapped.
  final VoidCallback onPressed;

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
  Widget build(BuildContext context) => SizedBox(
        width: 145,
        height: 44,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: textColor,
            backgroundColor: backgroundColor,
            onSurface: backgroundColor,
            textStyle: PuzzleTextStyle.headline5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      );
}
