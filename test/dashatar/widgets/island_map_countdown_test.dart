// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapCountdown', () {
    late IslandMapPuzzleBloc islandMapPuzzleBloc;
    late IslandMapThemeBloc islandMapThemeBloc;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      islandMapPuzzleBloc = MockIslandMapPuzzleBloc();
      final islandMapPuzzleState = IslandMapPuzzleState(secondsToBegin: 3);
      whenListen(
        islandMapPuzzleBloc,
        Stream.value(islandMapPuzzleState),
        initialState: islandMapPuzzleState,
      );

      islandMapThemeBloc = MockIslandMapThemeBloc();
      final themes = [GreenIslandMapTheme()];
      final islandMapThemeState = IslandMapThemeState(themes: themes);
      whenListen(
        islandMapThemeBloc,
        Stream.value(islandMapThemeState),
        initialState: islandMapThemeState,
      );

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets(
      'adds PuzzleReset to PuzzleBloc '
      'when isCountdownRunning is true and '
      'secondsToBegin is between 1 and 3 (inclusive)',
      (tester) async {
        final puzzleBloc = MockPuzzleBloc();

        final state = IslandMapPuzzleState(
          isCountdownRunning: true,
          secondsToBegin: 4,
        );

        // ignore: close_sinks
        final streamController = StreamController<IslandMapPuzzleState>();

        whenListen(
          islandMapPuzzleBloc,
          streamController.stream,
        );

        streamController
          ..add(state)
          ..add(state.copyWith(secondsToBegin: 3))
          ..add(state.copyWith(secondsToBegin: 2))
          ..add(state.copyWith(secondsToBegin: 1))
          ..add(state.copyWith(secondsToBegin: 0))
          ..add(state.copyWith(isCountdownRunning: false));

        await tester.pumpApp(
          IslandMapCountdown(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        verify(() => puzzleBloc.add(PuzzleReset())).called(3);
      },
    );

    testWidgets(
      'plays the shuffle sound '
      'when secondsToBegin is 3',
      (tester) async {
        final audioPlayer = MockAudioPlayer();
        when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
        when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
        when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
        when(audioPlayer.play).thenAnswer((_) async {});
        when(audioPlayer.stop).thenAnswer((_) async {});
        when(audioPlayer.dispose).thenAnswer((_) async {});

        final state = IslandMapPuzzleState(
          isCountdownRunning: true,
          secondsToBegin: 3,
        );

        whenListen(
          islandMapPuzzleBloc,
          Stream.value(state),
          initialState: state,
        );

        await tester.pumpApp(
          IslandMapCountdown(
            audioPlayer: () => audioPlayer,
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setAsset('assets/audio/shuffle.mp3'))
            .called(1);
        verify(audioPlayer.play).called(1);
      },
    );

    testWidgets('renders SizedBox on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        IslandMapCountdown(),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(IslandMapCountdownSecondsToBegin), findsNothing);
      expect(find.byType(IslandMapCountdownGo), findsNothing);
    });

    testWidgets('renders SizedBox on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        IslandMapCountdown(),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(IslandMapCountdownSecondsToBegin), findsNothing);
      expect(find.byType(IslandMapCountdownGo), findsNothing);
    });

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        IslandMapCountdown(),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });
  });

  group('IslandMapCountdownSecondsToBegin', () {
    late IslandMapThemeBloc islandMapThemeBloc;
    late IslandMapTheme islandMapTheme;

    setUp(() {
      islandMapThemeBloc = MockIslandMapThemeBloc();
      islandMapTheme = MockIslandMapTheme();
      final islandMapThemeState = IslandMapThemeState(
        themes: [islandMapTheme],
        theme: islandMapTheme,
      );

      when(() => islandMapTheme.defaultColor).thenReturn(Colors.black);
      when(() => islandMapTheme.countdownColor).thenReturn(Colors.black);
      when(() => islandMapThemeBloc.state).thenReturn(islandMapThemeState);
    });

    testWidgets(
      'renders secondsToBegin '
      'using IslandMapTheme.countdownColor as text color',
      (tester) async {
        const countdownColor = Colors.white;
        when(() => islandMapTheme.countdownColor).thenReturn(countdownColor);

        await tester.pumpApp(
          IslandMapCountdownSecondsToBegin(
            secondsToBegin: 3,
          ),
          islandMapThemeBloc: islandMapThemeBloc,
        );

        final text = tester.widget<Text>(find.text('3'));

        expect(text.style?.color, equals(countdownColor));
      },
    );
  });
}
