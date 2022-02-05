// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/dashatar.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

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

      test('dashAssetForTile returns correct assets', () {
        final tile = MockTile();
        const tileValue = 6;
        when(() => tile.value).thenReturn(tileValue);
        expect(
          GreenDashatarTheme().dashAssetForTile(tile),
          equals('assets/images/map/green/6.png'),
        );
      });
    });
  });
}
