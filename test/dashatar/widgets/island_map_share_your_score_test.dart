// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapShareYourScore', () {
    late IslandMapShareDialogEnterAnimation animation;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      animation = IslandMapShareDialogEnterAnimation(
        AnimationController(vsync: TestVSync()),
      );

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_share_your_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_share_your_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders title', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_share_your_score_title')),
        findsOneWidget,
      );
    });

    testWidgets('renders message', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('island_map_share_your_score_message')),
        findsOneWidget,
      );
    });

    testWidgets('renders IslandMapTwitterButton', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byType(IslandMapTwitterButton),
        findsOneWidget,
      );
    });

    testWidgets('renders IslandMapFacebookButton', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: IslandMapShareYourScore(animation: animation),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byType(IslandMapFacebookButton),
        findsOneWidget,
      );
    });
  });
}
