import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../layout/layout.dart';
import '../../theme/theme.dart';
import '../dashatar.dart';

/// {@template dashatar_theme}
/// The dashatar puzzle theme.
/// {@endtemplate}
abstract class DashatarTheme extends PuzzleTheme {
  @override
  String get name => 'Dashatar';

  @override
  bool get hasTimer => true;

  @override
  Color get nameColor => PuzzleColors.white;

  @override
  Color get titleColor => PuzzleColors.white;

  @override
  Color get hoverColor => PuzzleColors.black2;

  @override
  Color get pressedColor => PuzzleColors.white2;

  @override
  bool get isLogoColored => false;

  @override
  Color get menuActiveColor => PuzzleColors.white;

  @override
  Color get menuUnderlineColor => PuzzleColors.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const DashatarPuzzleLayoutDelegate();

  /// The text color of the countdown timer.
  Color get countdownColor;


  /// The path to the success image asset of this theme.
  ///
  /// This asset is shown in the success state of the Dashatar puzzle.
  String get successThemeAsset;

  /// The path to the audio asset of this theme.
  String get audioAsset;

  /// The path to the directory with dash assets for all puzzle tiles.
  String get dashAssetsDirectory;

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        layoutDelegate,
        countdownColor,
        successThemeAsset,
        audioAsset,
        dashAssetsDirectory,
      ];

  /// {@macro dashatar_theme}
  const DashatarTheme() : super();

  /// The semantics label of this theme.
  String semanticsLabel(BuildContext context);
}
