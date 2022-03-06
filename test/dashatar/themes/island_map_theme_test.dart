// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

void main() {
  group('IslandMapTheme', () {
    group('GreenIslandMapTheme', () {
      test('supports value comparisons', () {
        expect(
          GreenIslandMapTheme(),
          equals(GreenIslandMapTheme()),
        );
      });

      test('uses IslandMapPuzzleLayoutDelegate', () {
        expect(
          GreenIslandMapTheme().layoutDelegate,
          equals(IslandMapPuzzleLayoutDelegate()),
        );
      });
    });
  });
}
