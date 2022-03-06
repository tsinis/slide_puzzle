// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

void main() {
  group('IslandMapThemeEvent', () {
    group('IslandMapThemeChanged', () {
      test('supports value comparisons', () {
        expect(
          IslandMapThemeChanged(themeIndex: 1),
          equals(IslandMapThemeChanged(themeIndex: 1)),
        );
        expect(
          IslandMapThemeChanged(themeIndex: 2),
          isNot(IslandMapThemeChanged(themeIndex: 1)),
        );
      });
    });
  });
}
