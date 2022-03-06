// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

void main() {
  group('IslandMapPuzzleState', () {
    test('supports value comparisons', () {
      expect(
        IslandMapPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
        equals(
          IslandMapPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
        ),
      );
    });

    test('default isCountdownRunning is false', () {
      expect(
        IslandMapPuzzleState(secondsToBegin: 3).isCountdownRunning,
        equals(false),
      );
    });

    group('status', () {
      test(
        'is loading '
        'when isCountdownRunning is true and '
        'secondsToBegin is greater than 0',
        () {
          expect(
            IslandMapPuzzleState(
              secondsToBegin: 1,
              isCountdownRunning: true,
            ).status,
            equals(IslandMapPuzzleStatus.loading),
          );
        },
      );

      test(
        'is started '
        'when isCountdownRunning is false and '
        'secondsToBegin is equal to 0',
        () {
          expect(
            IslandMapPuzzleState(
              secondsToBegin: 0,
            ).status,
            equals(IslandMapPuzzleStatus.started),
          );
        },
      );

      test(
        'is notStarted '
        'when isCountdownRunning is false and '
        'secondsToBegin is greater than 0',
        () {
          expect(
            IslandMapPuzzleState(
              secondsToBegin: 3,
            ).status,
            equals(IslandMapPuzzleStatus.notStarted),
          );
        },
      );
    });

    group('copyWith', () {
      test('updates isCountdownRunning', () {
        expect(
          IslandMapPuzzleState(
            secondsToBegin: 3,
            isCountdownRunning: true,
          ).copyWith(isCountdownRunning: false),
          equals(
            IslandMapPuzzleState(
              secondsToBegin: 3,
            ),
          ),
        );
      });

      test('updates secondsToBegin', () {
        expect(
          IslandMapPuzzleState(
            secondsToBegin: 3,
          ).copyWith(secondsToBegin: 1),
          equals(
            IslandMapPuzzleState(
              secondsToBegin: 1,
            ),
          ),
        );
      });
    });
  });
}
