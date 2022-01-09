import 'dart:ui';

import '../../colors/colors.dart';
import '../../layout/layout.dart';
import 'themes.dart';

/// {@template simple_theme}
/// The simple puzzle theme.
/// {@endtemplate}
class SimpleTheme extends PuzzleTheme {
  @override
  String get name => 'Simple';

  @override
  bool get hasTimer => false;

  @override
  bool get hasCountdown => false;

  @override
  Color get backgroundColor => PuzzleColors.white;

  @override
  Color get defaultColor => PuzzleColors.primary5;

  @override
  Color get hoverColor => PuzzleColors.primary3;

  @override
  Color get pressedColor => PuzzleColors.primary7;

  @override
  PuzzleLayoutDelegate get layoutDelegate => const SimplePuzzleLayoutDelegate();

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        hasCountdown,
        backgroundColor,
        defaultColor,
        hoverColor,
        pressedColor,
        layoutDelegate,
      ];

  /// {@macro simple_theme}
  const SimpleTheme() : super();
}
