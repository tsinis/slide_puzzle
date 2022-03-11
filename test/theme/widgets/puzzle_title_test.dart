// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleTitle', () {
    late PuzzleTheme theme;

    setUp(() {
      theme = MockPuzzleTheme();

      when(() => theme.titleColor).thenReturn(Colors.black);
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(PuzzleTitle(title: 'Title'));

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(PuzzleTitle(title: 'Title'));

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders text in the given color', (tester) async {
      const color = Colors.purple;

      await tester.pumpApp(
        PuzzleTitle(title: 'Title', color: color),
      );

      final textStyle = tester.firstWidget<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      expect(textStyle.style.color, equals(color));
    });
  });
}
