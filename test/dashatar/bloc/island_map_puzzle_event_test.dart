// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

void main() {
  group('IslandMapPuzzleEvent', () {
    group('IslandMapCountdownStarted', () {
      test('supports value comparisons', () {
        expect(
          IslandMapCountdownStarted(),
          equals(IslandMapCountdownStarted()),
        );
      });
    });

    group('IslandMapCountdownTicked', () {
      test('supports value comparisons', () {
        expect(
          IslandMapCountdownTicked(),
          equals(IslandMapCountdownTicked()),
        );
      });
    });

    group('IslandMapCountdownStopped', () {
      test('supports value comparisons', () {
        expect(
          IslandMapCountdownStopped(),
          equals(IslandMapCountdownStopped()),
        );
      });
    });

    group('IslandMapCountdownReset', () {
      test('supports value comparisons', () {
        expect(
          IslandMapCountdownReset(secondsToBegin: 3),
          equals(IslandMapCountdownReset(secondsToBegin: 3)),
        );

        expect(
          IslandMapCountdownReset(secondsToBegin: 3),
          isNot(IslandMapCountdownReset(secondsToBegin: 2)),
        );
      });
    });
  });
}
