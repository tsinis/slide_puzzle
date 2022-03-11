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
  group('IslandMapStartSection', () {
    late IslandMapPuzzleBloc islandMapPuzzleBloc;
    late IslandMapPuzzleState islandMapPuzzleState;
    late IslandMapThemeBloc islandMapThemeBloc;
    late IslandMapTheme islandMapTheme;
    late TimerBloc timerBloc;
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
      islandMapTheme = GreenIslandMapTheme();
      final islandMapThemeState = IslandMapThemeState(
        themes: [islandMapTheme],
        theme: islandMapTheme,
      );

      when(() => islandMapThemeBloc.state).thenReturn(islandMapThemeState);

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
            child: IslandMapStartSection(
              state: PuzzleState(),
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
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
            child: IslandMapStartSection(
              state: PuzzleState(),
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PuzzleTitle), findsOneWidget);
      },
      skip: true,
    );

    testWidgets(
      'renders NumberOfMovesAndTilesLeft '
      'when IslandMapPuzzleStatus is started',
      (tester) async {
        const numberOfMoves = 10;
        const numberOfTilesLeft = 12;

        final puzzleState = MockPuzzleState();
        when(() => puzzleState.numberOfMoves).thenReturn(numberOfMoves);
        when(() => puzzleState.numberOfTilesLeft).thenReturn(numberOfTilesLeft);

        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.started);

        await tester.pumpApp(
          SingleChildScrollView(
            child: IslandMapStartSection(
              state: puzzleState,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
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
    );

    testWidgets(
      'renders NumberOfMovesAndTilesLeft '
      'when IslandMapPuzzleStatus is notStarted',
      (tester) async {
        const numberOfMoves = 10;
        const numberOfTiles = 16;

        final puzzleState = MockPuzzleState();
        when(() => puzzleState.numberOfMoves).thenReturn(numberOfMoves);

        final puzzle = MockPuzzle();
        when(() => puzzle.tiles)
            .thenReturn(List.generate(numberOfTiles, (_) => MockTile()));
        when(() => puzzleState.puzzle).thenReturn(puzzle);

        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.loading);

        await tester.pumpApp(
          SingleChildScrollView(
            child: IslandMapStartSection(
              state: puzzleState,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
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
    );

    testWidgets(
      'renders IslandMapTimer on a medium display',
      (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: IslandMapStartSection(
              state: PuzzleState(),
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(IslandMapPuzzleActionButton), findsNothing);
        expect(find.byType(IslandMapTimer), findsOneWidget);
      },
    );

    testWidgets('renders IslandMapTimer on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapStartSection(
            state: PuzzleState(),
          ),
        ),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        timerBloc: timerBloc,
      );

      expect(find.byType(IslandMapPuzzleActionButton), findsNothing);
      expect(find.byType(IslandMapTimer), findsOneWidget);
    });
  });
}
