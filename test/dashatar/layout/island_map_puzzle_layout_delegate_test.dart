// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/models/models.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapPuzzleLayoutDelegate', () {
    late IslandMapPuzzleLayoutDelegate layoutDelegate;
    late IslandMapPuzzleBloc islandMapPuzzleBloc;
    late IslandMapThemeBloc islandMapThemeBloc;
    late PuzzleBloc puzzleBloc;
    late PuzzleState state;
    late TimerBloc timerBloc;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      layoutDelegate = IslandMapPuzzleLayoutDelegate();

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

      puzzleBloc = MockPuzzleBloc();
      state = PuzzleState();
      when(() => puzzleBloc.state).thenReturn(state);

      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    group('startSectionBuilder', () {
      testWidgets(
        'renders IslandMapStartSection '
        'on a medium display',
        (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            SingleChildScrollView(
              child: layoutDelegate.startSectionBuilder(state),
            ),
            islandMapPuzzleBloc: islandMapPuzzleBloc,
            islandMapThemeBloc: islandMapThemeBloc,
            puzzleBloc: puzzleBloc,
            timerBloc: timerBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IslandMapStartSection && widget.state == state,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders IslandMapStartSection '
        'on a small display',
        (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            SingleChildScrollView(
              child: layoutDelegate.startSectionBuilder(state),
            ),
            islandMapPuzzleBloc: islandMapPuzzleBloc,
            islandMapThemeBloc: islandMapThemeBloc,
            puzzleBloc: puzzleBloc,
            timerBloc: timerBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IslandMapStartSection && widget.state == state,
            ),
            findsOneWidget,
          );
        },
      );
    });

    group(
      'endSectionBuilder',
      () {
        group('on a medium display', () {
          testWidgets('renders IslandMapPuzzleActionButton', (tester) async {
            tester.setMediumDisplaySize();

            await tester.pumpApp(
              SingleChildScrollView(
                child: layoutDelegate.endSectionBuilder(state),
              ),
              islandMapPuzzleBloc: islandMapPuzzleBloc,
              islandMapThemeBloc: islandMapThemeBloc,
              puzzleBloc: puzzleBloc,
              timerBloc: timerBloc,
              audioControlBloc: audioControlBloc,
            );

            expect(find.byType(IslandMapPuzzleActionButton), findsOneWidget);
          });

          testWidgets(
            'renders IslandMapCountdown',
            (tester) async {
              tester.setMediumDisplaySize();

              await tester.pumpApp(
                SingleChildScrollView(
                  child: layoutDelegate.endSectionBuilder(state),
                ),
                islandMapPuzzleBloc: islandMapPuzzleBloc,
                islandMapThemeBloc: islandMapThemeBloc,
                puzzleBloc: puzzleBloc,
                timerBloc: timerBloc,
                audioControlBloc: audioControlBloc,
              );

              expect(find.byType(IslandMapCountdown), findsOneWidget);
            },
            skip: true,
          );
        });

        group('on a small display', () {
          testWidgets('renders IslandMapPuzzleActionButton', (tester) async {
            tester.setSmallDisplaySize();

            await tester.pumpApp(
              SingleChildScrollView(
                child: layoutDelegate.endSectionBuilder(state),
              ),
              islandMapPuzzleBloc: islandMapPuzzleBloc,
              islandMapThemeBloc: islandMapThemeBloc,
              puzzleBloc: puzzleBloc,
              timerBloc: timerBloc,
              audioControlBloc: audioControlBloc,
            );

            expect(find.byType(IslandMapPuzzleActionButton), findsOneWidget);
          });

          testWidgets(
            'renders IslandMapCountdown',
            (tester) async {
              tester.setSmallDisplaySize();

              await tester.pumpApp(
                SingleChildScrollView(
                  child: layoutDelegate.endSectionBuilder(state),
                ),
                islandMapPuzzleBloc: islandMapPuzzleBloc,
                islandMapThemeBloc: islandMapThemeBloc,
                puzzleBloc: puzzleBloc,
                timerBloc: timerBloc,
                audioControlBloc: audioControlBloc,
              );

              expect(find.byType(IslandMapCountdown), findsOneWidget);
            },
            skip: true,
          );
        });
      },
    );

    group(
      'backgroundBuilder',
      () {
        testWidgets(
          'renders SizedBox '
          'on a medium display',
          (tester) async {
            tester.setMediumDisplaySize();

            await tester.pumpApp(
              Stack(
                children: [
                  layoutDelegate.backgroundBuilder(state),
                ],
              ),
              islandMapPuzzleBloc: islandMapPuzzleBloc,
              islandMapThemeBloc: islandMapThemeBloc,
              puzzleBloc: puzzleBloc,
              timerBloc: timerBloc,
              audioControlBloc: audioControlBloc,
            );

            expect(find.byType(SizedBox), findsOneWidget);
          },
        );

        testWidgets(
          'renders SizedBox '
          'on a small display',
          (tester) async {
            tester.setSmallDisplaySize();

            await tester.pumpApp(
              Stack(
                children: [
                  layoutDelegate.backgroundBuilder(state),
                ],
              ),
              islandMapPuzzleBloc: islandMapPuzzleBloc,
              islandMapThemeBloc: islandMapThemeBloc,
              puzzleBloc: puzzleBloc,
              timerBloc: timerBloc,
              audioControlBloc: audioControlBloc,
            );

            expect(find.byType(SizedBox), findsOneWidget);
          },
        );
      },
      skip: true,
    );

    group('boardBuilder', () {
      final tiles = [const SizedBox()];

      testWidgets(
        'renders IslandMapPuzzleBoard '
        'on a medium display',
        (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            SingleChildScrollView(
              child: layoutDelegate.boardBuilder(4, tiles),
            ),
            islandMapPuzzleBloc: islandMapPuzzleBloc,
            islandMapThemeBloc: islandMapThemeBloc,
            puzzleBloc: puzzleBloc,
            timerBloc: timerBloc,
            audioControlBloc: audioControlBloc,
          );

          await tester.pump(const Duration(seconds: 1));

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IslandMapPuzzleBoard && widget.tiles == tiles,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders IslandMapPuzzleBoard '
        'on a small display',
        (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            SingleChildScrollView(
              child: layoutDelegate.boardBuilder(4, tiles),
            ),
            islandMapPuzzleBloc: islandMapPuzzleBloc,
            islandMapThemeBloc: islandMapThemeBloc,
            puzzleBloc: puzzleBloc,
            timerBloc: timerBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(IslandMapTimer), findsNothing);
          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IslandMapPuzzleBoard && widget.tiles == tiles,
            ),
            findsOneWidget,
          );
        },
      );
    });

    group('tileBuilder', () {
      testWidgets('renders IslandMapPuzzleTile', (tester) async {
        final tile = Tile(
          value: 1,
          correctPosition: Position(x: 1, y: 1),
          currentPosition: Position(x: 1, y: 2),
        );

        await tester.pumpApp(
          Material(
            child: layoutDelegate.tileBuilder(tile, state),
          ),
          islandMapPuzzleBloc: islandMapPuzzleBloc,
          islandMapThemeBloc: islandMapThemeBloc,
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is IslandMapPuzzleTile &&
                widget.tile == tile &&
                widget.state == state,
          ),
          findsOneWidget,
        );
      });
    });

    group('whitespaceTileBuilder', () {
      testWidgets('renders SizedBox', (tester) async {
        await tester.pumpApp(
          layoutDelegate.whitespaceTileBuilder(),
        );

        expect(
          find.byType(SizedBox),
          findsOneWidget,
        );
      });
    });

    test('supports value comparisons', () {
      expect(
        IslandMapPuzzleLayoutDelegate(),
        equals(IslandMapPuzzleLayoutDelegate()),
      );
    });
  });
}
