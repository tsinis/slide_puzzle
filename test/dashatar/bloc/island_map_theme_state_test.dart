// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapThemeState', () {
    test('supports value comparisons', () {
      final theme = MockIslandMapTheme();
      final themes = [theme];

      expect(
        IslandMapThemeState(themes: themes, theme: theme),
        equals(IslandMapThemeState(themes: themes, theme: theme)),
      );

      expect(
        IslandMapThemeState(themes: themes, theme: theme),
        isNot(IslandMapThemeState(themes: themes, theme: MockIslandMapTheme())),
      );
    });

    test('default theme is GreenIslandMapTheme', () {
      expect(
        IslandMapThemeState(themes: [MockIslandMapTheme()]).theme,
        equals(GreenIslandMapTheme()),
      );
    });
  });
}
