// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemeState', () {
    test('supports value comparisons', () {
      final theme = MockDashatarTheme();
      final themes = [theme];

      expect(
        DashatarThemeState(themes: themes, theme: theme),
        equals(DashatarThemeState(themes: themes, theme: theme)),
      );

      expect(
        DashatarThemeState(themes: themes, theme: theme),
        isNot(DashatarThemeState(themes: themes, theme: MockDashatarTheme())),
      );
    });

    test('default theme is GreenDashatarTheme', () {
      expect(
        DashatarThemeState(themes: [MockDashatarTheme()]).theme,
        equals(GreenDashatarTheme()),
      );
    });
  });
}
