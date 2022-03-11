// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/map/widgets/animated_tile.dart';
import 'package:map_slide_puzzle/models/models.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapPuzzleTile', () {
    late IslandMapPuzzleBloc islandMapPuzzleBloc;
    late IslandMapPuzzleState islandMapPuzzleState;
    late IslandMapThemeBloc islandMapThemeBloc;
    late IslandMapTheme islandMapTheme;
    late AudioControlBloc audioControlBloc;
    late PuzzleBloc puzzleBloc;
    late PuzzleState puzzleState;
    late Tile tile;

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

      tile = Tile(
        correctPosition: Position(x: 1, y: 1),
        currentPosition: Position(x: 1, y: 1),
        value: 1,
      );

      puzzleBloc = MockPuzzleBloc();
      puzzleState = MockPuzzleState();

      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      whenListen(
        puzzleBloc,
        Stream.value(puzzleState),
        initialState: puzzleState,
      );

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    setUpAll(() {
      registerFallbackValue(MockTile());
      registerFallbackValue(MockPuzzleEvent());
    });

    testWidgets(
      'adds TileTapped to PuzzleBloc '
      'and plays the move_tile sound '
      'when tapped and '
      'IslandMapPuzzleStatus is started and '
      'PuzzleStatus is incomplete',
      (tester) async {
        final audioPlayer = MockAudioPlayer();
        when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
        when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
        when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
        when(audioPlayer.play).thenAnswer((_) async {});
        when(audioPlayer.stop).thenAnswer((_) async {});
        when(audioPlayer.dispose).thenAnswer((_) async {});

        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus)
            .thenReturn(PuzzleStatus.incomplete);
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.started);

        await tester.pumpApp(
          Scaffold(
            body: IslandMapPuzzleTile(
              state: puzzleState,
              tile: tile,
              audioPlayer: () => audioPlayer,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        // Wait for the initialization of the audio player.
        await tester.pump(Duration(seconds: 1));

        await tester.tap(find.byType(AnimatedTile));
        await tester.pumpAndSettle();

        verify(() => puzzleBloc.add(TileTapped(tile))).called(1);
        verify(() => audioPlayer.setAsset('assets/audio/move_tile.mp3'))
            .called(1);
        verify(audioPlayer.play).called(1);
      },
    );

    testWidgets(
      'does not add TileTapped to PuzzleBloc '
      'when tapped and IslandMapPuzzleStatus is notStarted',
      (tester) async {
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus)
            .thenReturn(PuzzleStatus.incomplete);
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.notStarted);

        await tester.pumpApp(
          Scaffold(
            body: IslandMapPuzzleTile(
              state: puzzleState,
              tile: tile,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(AnimatedTile));
        await tester.pumpAndSettle();

        verifyNever(() => puzzleBloc.add(TileTapped(tile)));
      },
    );

    testWidgets(
      'does not add TileTapped to PuzzleBloc '
      'when tapped and PuzzleStatus is complete',
      (tester) async {
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.started);

        await tester.pumpApp(
          Scaffold(
            body: IslandMapPuzzleTile(
              state: puzzleState,
              tile: tile,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(AnimatedTile));
        await tester.pumpAndSettle();

        verify(() => puzzleBloc.add(TileTapped(tile)));
      },
    );

    testWidgets('renders a medium tile on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: IslandMapPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_puzzle_tile_medium_${tile.value}')),
        findsOneWidget,
      );
    });

    testWidgets('renders a small tile on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: IslandMapPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_puzzle_tile_small_${tile.value}')),
        findsOneWidget,
      );
    });

    testWidgets(
      'renders AnimatedTile '
      'with IslandMap icon',
      (tester) async {
        await tester.pumpApp(
          Scaffold(
            body: IslandMapPuzzleTile(
              state: PuzzleState(),
              tile: tile,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );
      },
    );

    testWidgets(
      'renders disabled AnimatedTile '
      'when IslandMapPuzzleStatus is loading',
      (tester) async {
        when(() => islandMapPuzzleState.status)
            .thenReturn(IslandMapPuzzleStatus.loading);

        await tester.pumpApp(
          Scaffold(
            body: IslandMapPuzzleTile(
              state: PuzzleState(),
              tile: tile,
            ),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) => widget is AnimatedTile,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        islandMapPuzzleBloc: islandMapPuzzleBloc,
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });
  });
}
