// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  final ticker = MockTicker();
  // ignore: close_sinks
  final streamController = StreamController<int>.broadcast();

  setUp(() => when(ticker.tick).thenAnswer((_) => streamController.stream));

  group('IslandMapPuzzleBloc', () {
    test('initial state is correct', () {
      expect(
        IslandMapPuzzleBloc(
          secondsToBegin: 3,
          ticker: ticker,
        ).state,
        equals(IslandMapPuzzleState(secondsToBegin: 3)),
      );
    });

    group('IslandMapCountdownStarted', () {
      test(
        'emits 4 sequential countdown states and '
        'then stops then countdown '
        'when secondsToBegin is 3',
        () async {
          final bloc = IslandMapPuzzleBloc(secondsToBegin: 3, ticker: ticker)
            ..add(IslandMapCountdownStarted());

          final state = await bloc.stream.first;
          expect(
            state,
            equals(
              IslandMapPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
            ),
          );

          streamController
            ..add(1)
            ..add(2)
            ..add(3)
            ..add(4)
            ..add(5);

          await expectLater(
            bloc.stream,
            emitsInOrder(<IslandMapPuzzleState>[
              IslandMapPuzzleState(secondsToBegin: 2, isCountdownRunning: true),
              IslandMapPuzzleState(secondsToBegin: 1, isCountdownRunning: true),
              IslandMapPuzzleState(secondsToBegin: 0, isCountdownRunning: true),
              IslandMapPuzzleState(
                secondsToBegin: 0,
                isCountdownRunning: false,
              ),
            ]),
          );
        },
      );
    });

    group('IslandMapCountdownTicked', () {
      blocTest<IslandMapPuzzleBloc, IslandMapPuzzleState>(
        'decreases secondsToBegin by 1 '
        'if secondsToBegin is greater than 0',
        build: () => IslandMapPuzzleBloc(secondsToBegin: 3, ticker: ticker),
        act: (bloc) => bloc.add(IslandMapCountdownTicked()),
        expect: () => [IslandMapPuzzleState(secondsToBegin: 2)],
      );

      blocTest<IslandMapPuzzleBloc, IslandMapPuzzleState>(
        'stops the countdown '
        'if secondsToBegin is equal to 0',
        build: () => IslandMapPuzzleBloc(secondsToBegin: 0, ticker: ticker),
        seed: () =>
            IslandMapPuzzleState(secondsToBegin: 0, isCountdownRunning: true),
        act: (bloc) => bloc..add(IslandMapCountdownTicked()),
        expect: () => [
          IslandMapPuzzleState(secondsToBegin: 0, isCountdownRunning: false),
        ],
      );
    });

    group('IslandMapCountdownStopped', () {
      test(
        'stops the countdown and '
        'resets secondsToBegin',
        () async {
          final bloc = IslandMapPuzzleBloc(secondsToBegin: 3, ticker: ticker)
            ..add(IslandMapCountdownStarted());

          expect(
            await bloc.stream.first,
            equals(
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 3),
            ),
          );

          streamController.add(1);
          expect(
            await bloc.stream.first,
            equals(
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 2),
            ),
          );

          bloc.add(IslandMapCountdownStopped());
          streamController.add(2);

          expect(
            await bloc.stream.first,
            equals(
              IslandMapPuzzleState(
                isCountdownRunning: false,
                secondsToBegin: 3,
              ),
            ),
          );
        },
      );
    });

    group('IslandMapCountdownReset', () {
      test(
        'restarts the countdown '
        'with the given secondsToBegin',
        () async {
          final bloc = IslandMapPuzzleBloc(secondsToBegin: 3, ticker: ticker)
            ..add(IslandMapCountdownReset(secondsToBegin: 5));

          final state = await bloc.stream.first;
          expect(
            state,
            equals(
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 5),
            ),
          );

          streamController
            ..add(1)
            ..add(2)
            ..add(3)
            ..add(4)
            ..add(5)
            ..add(6)
            ..add(7)
            ..add(8)
            ..add(9)
            ..add(10);

          await expectLater(
            bloc.stream,
            emitsInOrder(<IslandMapPuzzleState>[
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 4),
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 3),
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 2),
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 1),
              IslandMapPuzzleState(isCountdownRunning: true, secondsToBegin: 0),
              IslandMapPuzzleState(
                isCountdownRunning: false,
                secondsToBegin: 0,
              ),
            ]),
          );
        },
      );
    });
  });
}
