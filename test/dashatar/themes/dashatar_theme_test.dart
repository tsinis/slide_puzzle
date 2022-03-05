// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/dashatar.dart';

void main() {
  group('DashatarTheme', () {
    group('GreenDashatarTheme', () {
      test('supports value comparisons', () {
        expect(
          GreenDashatarTheme(),
          equals(GreenDashatarTheme()),
        );
      });

      test('uses DashatarPuzzleLayoutDelegate', () {
        expect(
          GreenDashatarTheme().layoutDelegate,
          equals(DashatarPuzzleLayoutDelegate()),
        );
      });
    });
  });
}
