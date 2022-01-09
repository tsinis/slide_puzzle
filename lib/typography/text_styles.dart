import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/colors.dart';
import 'typography.dart';

// ignore: avoid_classes_with_only_static_members
/// Defines text styles for the puzzle UI.
class PuzzleTextStyle {
  static const _baseTextStyle = TextStyle(
    fontFamily: 'GoogleSans',
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );

  static final _bodyTextStyle = GoogleFonts.roboto(
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );

  /// Body text style
  static TextStyle get body => _bodyTextStyle.copyWith(
        fontSize: 24,
        height: 1.33,
        fontWeight: PuzzleFontWeight.regular,
      );

  /// Body Large text style
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 46,
        height: 1.17,
        fontWeight: PuzzleFontWeight.regular,
      );

  /// Body Large Bold text style
  static TextStyle get bodyLargeBold => _baseTextStyle.copyWith(
        fontSize: 46,
        height: 1.17,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Body Small text style
  static TextStyle get bodySmall => _bodyTextStyle.copyWith(
        fontSize: 18,
        height: 1.22,
        fontWeight: PuzzleFontWeight.regular,
      );

  /// Body XSmall text style
  static TextStyle get bodyXSmall => _bodyTextStyle.copyWith(
        fontSize: 14,
        height: 1.27,
        fontWeight: PuzzleFontWeight.regular,
      );

  /// Headline 1 text style
  static TextStyle get headline1 => _baseTextStyle.copyWith(
        fontSize: 74,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Headline 2 text style
  static TextStyle get headline2 => _baseTextStyle.copyWith(
        fontSize: 54,
        height: 1.1,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Headline 3 text style
  static TextStyle get headline3 => _baseTextStyle.copyWith(
        fontSize: 34,
        height: 1.12,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Headline 3 Soft text style
  static TextStyle get headline3Soft => _baseTextStyle.copyWith(
        fontSize: 34,
        height: 1.17,
        fontWeight: PuzzleFontWeight.regular,
      );

  /// Headline 4 text style
  static TextStyle get headline4 => _baseTextStyle.copyWith(
        fontSize: 24,
        height: 1.15,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Headline 5 text style
  static TextStyle get headline5 => _baseTextStyle.copyWith(
        fontSize: 16,
        height: 1.25,
        fontWeight: PuzzleFontWeight.bold,
      );

  /// Label text style
  static TextStyle get label => _baseTextStyle.copyWith(
        fontSize: 14,
        height: 1.27,
        fontWeight: PuzzleFontWeight.regular,
      );
}
