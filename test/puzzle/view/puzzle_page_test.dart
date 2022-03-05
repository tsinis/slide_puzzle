// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/layout/layout.dart';
import 'package:map_slide_puzzle/map/dashatar.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    testWidgets('renders PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('provides all Dashatar themes to PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final dashatarThemes =
          puzzleViewContext.read<DashatarThemeBloc>().state.themes;

      expect(
        dashatarThemes,
        equals([GreenDashatarTheme()]),
      );
    });

    testWidgets(
      'provides DashatarPuzzleBloc '
      'with secondsToBegin equal to 3',
      (tester) async {
        await tester.pumpApp(PuzzlePage());

        final BuildContext puzzleViewContext =
            tester.element(find.byType(PuzzleView));

        final secondsToBegin =
            puzzleViewContext.read<DashatarPuzzleBloc>().state.secondsToBegin;

        expect(
          secondsToBegin,
          equals(3),
        );
      },
    );

    testWidgets(
      'provides TimerBloc '
      'with initial state',
      (tester) async {
        await tester.pumpApp(PuzzlePage());

        final BuildContext puzzleViewContext =
            tester.element(find.byType(PuzzleView));

        expect(
          puzzleViewContext.read<TimerBloc>().state,
          equals(TimerState()),
        );
      },
    );

    testWidgets(
      'provides AudioControlBloc '
      'with initial state',
      (tester) async {
        await tester.pumpApp(PuzzlePage());

        final BuildContext puzzleViewContext =
            tester.element(find.byType(PuzzleView));

        expect(
          puzzleViewContext.read<AudioControlBloc>().state,
          equals(AudioControlState()),
        );
      },
    );
  });

  group('PuzzleView', () {
    late PuzzleTheme theme;
    late DashatarThemeBloc dashatarThemeBloc;
    late PuzzleLayoutDelegate layoutDelegate;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      theme = MockPuzzleTheme();
      layoutDelegate = MockPuzzleLayoutDelegate();

      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.endSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.backgroundBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.tileBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(layoutDelegate.whitespaceTileBuilder).thenReturn(SizedBox());

      when(() => theme.layoutDelegate).thenReturn(layoutDelegate);
      when(() => theme.backgroundColor).thenReturn(Colors.black);
      when(() => theme.isLogoColored).thenReturn(true);
      when(() => theme.menuActiveColor).thenReturn(Colors.black);
      when(() => theme.menuUnderlineColor).thenReturn(Colors.black);
      when(() => theme.menuInactiveColor).thenReturn(Colors.black);
      when(() => theme.hasTimer).thenReturn(true);
      when(() => theme.name).thenReturn('Name');

      dashatarThemeBloc = MockDashatarThemeBloc();
      when(() => dashatarThemeBloc.state)
          .thenReturn(DashatarThemeState(themes: [GreenDashatarTheme()]));

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    setUpAll(() {
      registerFallbackValue(MockPuzzleState());
      registerFallbackValue(MockTile());
    });

    testWidgets(
      'renders Scaffold with descendant AnimatedContainer  '
      'using PuzzleTheme.backgroundColor as background color',
      (tester) async {
        const backgroundColor = Colors.orange;
        when(() => theme.backgroundColor).thenReturn(backgroundColor);

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is AnimatedContainer &&
                  widget.decoration == BoxDecoration(color: backgroundColor),
            ),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders puzzle correctly '
      'on a medium display',
      (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
      },
    );

    testWidgets(
      'renders puzzle correctly '
      'on a small display',
      (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
      },
    );

    testWidgets('renders puzzle sections', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(PuzzleSections), findsOneWidget);
    });

    testWidgets(
      'builds background '
      'with layoutDelegate.backgroundBuilder',
      (tester) async {
        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        verify(() => layoutDelegate.backgroundBuilder(any())).called(1);
      },
    );

    testWidgets(
      'builds board '
      'with layoutDelegate.boardBuilder',
      (tester) async {
        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpAndSettle();

        verify(() => layoutDelegate.boardBuilder(any(), any())).called(1);
      },
    );

    testWidgets(
      'builds 15 tiles '
      'with layoutDelegate.tileBuilder',
      (tester) async {
        when(() => layoutDelegate.boardBuilder(any(), any()))
            .thenAnswer((invocation) {
          final tiles = invocation.positionalArguments[1] as List<Widget>;

          return Row(children: tiles);
        });

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpAndSettle();

        verify(() => layoutDelegate.tileBuilder(any(), any())).called(15);
      },
    );

    testWidgets(
      'builds 1 whitespace tile '
      'with layoutDelegate.whitespaceTileBuilder',
      (tester) async {
        when(() => layoutDelegate.boardBuilder(any(), any()))
            .thenAnswer((invocation) {
          final tiles = invocation.positionalArguments[1] as List<Widget>;

          return Row(children: tiles);
        });

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpAndSettle();

        verify(layoutDelegate.whitespaceTileBuilder).called(1);
      },
    );

    testWidgets(
      'may start a timer '
      'in layoutDelegate',
      (tester) async {
        when(() => layoutDelegate.startSectionBuilder(any())).thenAnswer(
          (invocation) => Builder(
            builder: (context) => TextButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted()),
              key: Key('__start_timer__'),
              child: Text('Start timer'),
            ),
          ),
        );

        await tester.pumpApp(
          PuzzleView(),
          dashatarThemeBloc: dashatarThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('__start_timer__')));
      },
    );

    group('PuzzleSections', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();
        puzzleBloc = MockPuzzleBloc();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      group('on a medium display', () {
        testWidgets(
          'builds start section '
          'with layoutDelegate.startSectionBuilder',
          (tester) async {
            tester.setMediumDisplaySize();

            await tester.pumpApp(
              PuzzleSections(),
              puzzleBloc: puzzleBloc,
              audioControlBloc: audioControlBloc,
            );

            verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
          },
        );

        testWidgets(
          'builds end section '
          'with layoutDelegate.endSectionBuilder',
          (tester) async {
            tester.setMediumDisplaySize();

            await tester.pumpApp(
              PuzzleSections(),
              puzzleBloc: puzzleBloc,
              audioControlBloc: audioControlBloc,
            );

            verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
          },
        );

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });

      group('on a small display', () {
        testWidgets(
          'builds start section '
          'with layoutDelegate.startSectionBuilder',
          (tester) async {
            tester.setSmallDisplaySize();

            await tester.pumpApp(
              PuzzleSections(),
              puzzleBloc: puzzleBloc,
              audioControlBloc: audioControlBloc,
            );

            verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
          },
        );

        testWidgets(
          'builds end section '
          'with layoutDelegate.endSectionBuilder',
          (tester) async {
            tester.setSmallDisplaySize();

            await tester.pumpApp(
              PuzzleSections(),
              puzzleBloc: puzzleBloc,
              audioControlBloc: audioControlBloc,
            );

            verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
          },
        );

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });
    });

    group('PuzzleBoard', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        puzzleBloc = MockPuzzleBloc();
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      testWidgets(
        'adds TimerStopped to TimerBloc '
        'when the puzzle completes',
        (tester) async {
          final timerBloc = MockTimerBloc();
          final timerState = MockTimerState();

          const secondsElapsed = 60;
          when(() => timerState.secondsElapsed).thenReturn(secondsElapsed);
          when(() => timerBloc.state).thenReturn(timerState);

          await tester.pumpApp(
            PuzzleBoard(),
            dashatarThemeBloc: dashatarThemeBloc,
            audioControlBloc: audioControlBloc,
            timerBloc: timerBloc,
            puzzleBloc: puzzleBloc,
          );

          verify(() => timerBloc.add(TimerStopped())).called(1);
        },
      );

      testWidgets('renders PuzzleKeyboardHandler', (tester) async {
        await tester.pumpApp(
          PuzzleBoard(),
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleKeyboardHandler), findsOneWidget);
      });
    });
  });
}
