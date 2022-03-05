import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../l10n/l10n.dart';
import '../dashatar.dart';
import '../models/illustration_colors.dart';

/// {@template green_dashatar_theme}
/// The green dashatar puzzle theme.
/// {@endtemplate}
class GreenDashatarTheme extends DashatarTheme {
  @override
  Color get backgroundColor => IllustrationColors.seaColor;

  @override
  Color get defaultColor => IllustrationColors.lightYellow;

  @override
  Color get buttonColor => IllustrationColors.darkBlueCastle;

  @override
  Color get menuInactiveColor => PuzzleColors.green50;

  @override
  Color get countdownColor => PuzzleColors.green50;

  @override
  String get successThemeAsset => 'assets/vectors/prize.svg';

  @override
  String get audioAsset => 'assets/audio/skateboard.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/green';

  /// {@macro green_dashatar_theme}
  const GreenDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.dashatarGreenDashLabelText;
}
