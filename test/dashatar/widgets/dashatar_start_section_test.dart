// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/dashatar.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarStartSection', () {
    late DashatarPuzzleBloc dashatarPuzzleBloc;
    late DashatarPuzzleState dashatarPuzzleState;
    late DashatarThemeBloc dashatarThemeBloc;
    late DashatarTheme dashatarTheme;
    late TimerBloc timerBloc;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      dashatarPuzzleBloc = MockDashatarPuzzleBloc();
      dashatarPuzzleState = MockDashatarPuzzleState();

      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.notStarted);

      whenListen(
        dashatarPuzzleBloc,
        Stream.value(dashatarPuzzleState),
        initialState: dashatarPuzzleState,
      );

      dashatarThemeBloc = MockDashatarThemeBloc();
      dashatarTheme = GreenDashatarTheme();
      final dashatarThemeState = DashatarThemeState(
        themes: [dashatarTheme],
        theme: dashatarTheme,
      );

      when(() => dashatarThemeBloc.state).thenReturn(dashatarThemeState);

      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets(
      'renders PuzzleName',
      (tester) async {
        await tester.pumpApp(
          SingleChildScrollView(
            child: DashatarStartSection(
              state: PuzzleState(),
            ),
          ),
          dashatarPuzzleBloc: dashatarPuzzleBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PuzzleName), findsOneWidget);
      },
      skip: true,
    );

    testWidgets(
      'renders PuzzleTitle',
      (tester) async {
        await tester.pumpApp(
          SingleChildScrollView(
            child: DashatarStartSection(
              state: PuzzleState(),
            ),
          ),
          dashatarPuzzleBloc: dashatarPuzzleBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PuzzleTitle), findsOneWidget);
      },
      skip: true,
    );

    testWidgets(
      'renders NumberOfMovesAndTilesLeft '
      'when DashatarPuzzleStatus is started',
      (tester) async {
        const numberOfMoves = 10;
        const numberOfTilesLeft = 12;

        final puzzleState = MockPuzzleState();
        when(() => puzzleState.numberOfMoves).thenReturn(numberOfMoves);
        when(() => puzzleState.numberOfTilesLeft).thenReturn(numberOfTilesLeft);

        when(() => dashatarPuzzleState.status)
            .thenReturn(DashatarPuzzleStatus.started);

        await tester.pumpApp(
          SingleChildScrollView(
            child: DashatarStartSection(
              state: puzzleState,
            ),
          ),
          dashatarPuzzleBloc: dashatarPuzzleBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is NumberOfMovesAndTilesLeft &&
                widget.numberOfMoves == numberOfMoves &&
                widget.numberOfTilesLeft == numberOfTilesLeft,
          ),
          findsOneWidget,
        );
      },
      skip: true,
    );

    testWidgets(
      'renders NumberOfMovesAndTilesLeft '
      'when DashatarPuzzleStatus is notStarted',
      (tester) async {
        const numberOfMoves = 10;
        const numberOfTiles = 16;

        final puzzleState = MockPuzzleState();
        when(() => puzzleState.numberOfMoves).thenReturn(numberOfMoves);

        final puzzle = MockPuzzle();
        when(() => puzzle.tiles)
            .thenReturn(List.generate(numberOfTiles, (_) => MockTile()));
        when(() => puzzleState.puzzle).thenReturn(puzzle);

        when(() => dashatarPuzzleState.status)
            .thenReturn(DashatarPuzzleStatus.loading);

        await tester.pumpApp(
          SingleChildScrollView(
            child: DashatarStartSection(
              state: puzzleState,
            ),
          ),
          dashatarPuzzleBloc: dashatarPuzzleBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is NumberOfMovesAndTilesLeft &&
                widget.numberOfMoves == numberOfMoves &&
                widget.numberOfTilesLeft == numberOfTiles - 1,
          ),
          findsOneWidget,
        );
      },
      skip: true,
    );

    testWidgets(
      'renders DashatarTimer on a medium display',
      (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: DashatarStartSection(
              state: PuzzleState(),
            ),
          ),
          dashatarPuzzleBloc: dashatarPuzzleBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(DashatarPuzzleActionButton), findsNothing);
        expect(find.byType(DashatarTimer), findsOneWidget);
      },
      skip: true,
    );

    testWidgets('renders DashatarTimer on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarStartSection(
            state: PuzzleState(),
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        timerBloc: timerBloc,
      );

      expect(find.byType(DashatarPuzzleActionButton), findsNothing);
      expect(find.byType(DashatarTimer), findsOneWidget);
    });
  });
}
