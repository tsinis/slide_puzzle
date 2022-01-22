// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AudioControl', () {
    late AudioControlBloc audioControlBloc;

    setUp(() {
      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state)
          .thenReturn(AudioControlState(muted: false));
    });

    testWidgets(
      'adds AudioToggled to AudioControlBloc '
      'when tapped and '
      'the audio is unmuted',
      (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: false));

        await tester.pumpApp(
          AudioControl(),
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(AudioControl));

        verify(() => audioControlBloc.add(AudioToggled())).called(1);
      },
    );

    testWidgets(
      'adds AudioToggled to AudioControlBloc '
      'when tapped and '
      'the audio is muted',
      (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: true));

        await tester.pumpApp(
          AudioControl(),
          audioControlBloc: audioControlBloc,
        );

        await tester.tap(find.byType(AudioControl));

        verify(() => audioControlBloc.add(AudioToggled())).called(1);
      },
    );

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        AudioControl(),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('audio_control_medium')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        AudioControl(),
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('audio_control_small')),
        findsOneWidget,
      );
    });
  });
}
