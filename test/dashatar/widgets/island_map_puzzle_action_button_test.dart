// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapPuzzleActionButton', () {
    late IslandMapPuzzleBloc islandMapPuzzleBloc;
    late IslandMapPuzzleState islandMapPuzzleState;
    late IslandMapThemeBloc islandMapThemeBloc;
    late IslandMapTheme islandMapTheme;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      islandMapPuzzleBloc = MockIslandMapPuzzleBloc();
      islandMapPuzzleState = MockIslandMapPuzzleState();

      when(() => islandMapPuzzleState.status)
          .thenReturn(IslandMapPuzzleStatus.notStarted);

      whenListen(
        islandMapPuzzleBloc,
        Stream.value(islandMapPuzzleState),
        initialState: islandMapPuzzleState,
      );

      islandMapThemeBloc = MockIslandMapThemeBloc();
      islandMapTheme = MockIslandMapTheme();
      final islandMapThemeState = IslandMapThemeState(
        themes: [islandMapTheme],
        theme: islandMapTheme,
      );

      when(() => islandMapTheme.defaultColor).thenReturn(Colors.black);
      when(() => islandMapThemeBloc.state).thenReturn(islandMapThemeState);

      final theme = MockPuzzleTheme();

      when(() => theme.buttonColor).thenReturn(Colors.black);

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets(
      'adds TimerReset to TimerBloc '
      'when tapped',
      (tester) async {
        final timerBloc = MockTimerBloc();

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          timerBloc: timerBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(IslandMapPuzzleActionButton));

        verify(() => timerBloc.add(TimerReset())).called(1);
      },
    );

    testWidgets(
      'adds IslandMapCountdownReset to IslandMapPuzzleBloc '
      'with secondsToBegin equal to 5 '
      'when tapped and '
      'IslandMapPuzzleStatus is started',
      (tester) async {
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.started);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(IslandMapPuzzleActionButton));

        verify(
          () => islandMapPuzzleBloc
              .add(IslandMapCountdownReset(secondsToBegin: 5)),
        ).called(1);
      },
    );

    testWidgets(
      'adds IslandMapCountdownReset to IslandMapPuzzleBloc '
      'with secondsToBegin equal to 3 '
      'when tapped and '
      'IslandMapPuzzleStatus is notStarted',
      (tester) async {
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.notStarted);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(IslandMapPuzzleActionButton));

        verify(
          () => islandMapPuzzleBloc
              .add(IslandMapCountdownReset(secondsToBegin: 3)),
        ).called(1);
      },
    );

    testWidgets(
      'adds PuzzleInitialized to PuzzleBloc '
      'when tapped and '
      'IslandMapPuzzleStatus is started',
      (tester) async {
        final puzzleBloc = MockPuzzleBloc();

        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.started);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(IslandMapPuzzleActionButton));

        verify(() => puzzleBloc.add(PuzzleInitialized())).called(1);
      },
    );

    testWidgets(
      'plays the click sound '
      'when tapped and '
      'IslandMapPuzzleStatus is not loading',
      (tester) async {
        final audioPlayer = MockAudioPlayer();
        when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
        when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
        when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
        when(audioPlayer.play).thenAnswer((_) async {});
        when(audioPlayer.stop).thenAnswer((_) async {});
        when(audioPlayer.dispose).thenAnswer((_) async {});

        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.notStarted);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(
            audioPlayer: () => audioPlayer,
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(IslandMapPuzzleActionButton));

        verify(() => audioPlayer.setAsset('assets/audio/click.mp3')).called(1);
        verify(audioPlayer.play).called(1);
      },
    );

    testWidgets(
      'renders disabled PuzzleButton '
      'when IslandMapPuzzleStatus is loading',
      (tester) async {
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.loading);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) => widget is PuzzleButton && widget.onPressed == null,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders PuzzleButton '
      'using IslandMapTheme.defaultColor as text color '
      'when IslandMapPuzzleStatus is loading',
      (tester) async {
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.loading);

        await tester.pumpApp(
          IslandMapPuzzleActionButton(),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pump(const Duration(seconds: 2));

        expect(
          find.byWidgetPredicate(
            (widget) => widget is PuzzleButton,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('renders Tooltip', (tester) async {
      await tester.pumpApp(
        IslandMapPuzzleActionButton(),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byType(Tooltip),
        findsOneWidget,
      );
    });

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        IslandMapPuzzleActionButton(),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });
  });
}
