import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../l10n/l10n.dart';
import '../island_map.dart';
import '../models/illustration_colors.dart';

/// {@template green_island_map_theme}
/// The green islandMap puzzle theme.
/// {@endtemplate}
class GreenIslandMapTheme extends IslandMapTheme {
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
  String get dashAssetsDirectory => '';

  /// {@macro green_island_map_theme}
  const GreenIslandMapTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.islandMapGreenDashLabelText;
}
