// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapShareDialog', () {
    late IslandMapThemeBloc islandMapThemeBloc;
    late PuzzleBloc puzzleBloc;
    late TimerBloc timerBloc;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      islandMapThemeBloc = MockIslandMapThemeBloc();
      when(() => islandMapThemeBloc.state).thenReturn(
        IslandMapThemeState(themes: [GreenIslandMapTheme()]),
      );

      puzzleBloc = MockPuzzleBloc();
      when(() => puzzleBloc.state).thenReturn(PuzzleState());

      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byKey(Key('island_map_share_dialog')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byKey(Key('island_map_share_dialog')),
        findsOneWidget,
      );
    });

    testWidgets('renders IslandMapShareDialogAnimatedBuilder', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byType(IslandMapShareDialogAnimatedBuilder),
        findsOneWidget,
      );
    });

    testWidgets('renders IslandMapScore', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byType(IslandMapScore),
        findsOneWidget,
      );
    });

    testWidgets('renders IslandMapShareYourScore', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byType(IslandMapShareYourScore),
        findsOneWidget,
      );
    });

    testWidgets('renders close button', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byKey(Key('island_map_share_dialog_close_button')),
        findsOneWidget,
      );
    });

    testWidgets('renders AudioControlListeners', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      expect(
        find.byKey(Key('island_map_share_dialog_success_audio_player')),
        findsOneWidget,
      );

      expect(
        find.byKey(Key('island_map_share_dialog_click_audio_player')),
        findsOneWidget,
      );
    });

    testWidgets('pops when tapped on close button', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: IslandMapShareDialog(),
        ),
        islandMapThemeBloc: islandMapThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the animation to complete.
      await tester.pump(Duration(milliseconds: 1100 + 140));

      await tester.tap(find.byKey(Key('island_map_share_dialog_close_button')));
      await tester.pumpAndSettle();

      expect(find.byType(IslandMapShareDialog), findsNothing);
    });
  });
}
