// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/colors/colors.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleButton', () {
    late PuzzleTheme theme;

    setUp(() {
      theme = MockPuzzleTheme();
    });

    testWidgets('renders AnimatedTextButton', (tester) async {
      await tester.pumpApp(
        PuzzleButton(
          onPressed: () {},
          child: SizedBox(),
        ),
      );

      expect(find.byType(AnimatedTextButton), findsOneWidget);
    });

    testWidgets('renders child', (tester) async {
      await tester.pumpApp(
        PuzzleButton(
          onPressed: () {},
          child: SizedBox(
            key: Key('__text__'),
          ),
        ),
      );

      expect(find.byKey(Key('__text__')), findsOneWidget);
    });

    testWidgets(
      'calls onPressed '
      'when tapped',
      (tester) async {
        var onPressedCalled = false;

        await tester.pumpApp(
          PuzzleButton(
            onPressed: () => onPressedCalled = true,
            child: SizedBox(),
          ),
        );

        await tester.tap(find.byType(PuzzleButton));

        expect(onPressedCalled, isTrue);
      },
    );

    group('backgroundColor', () {
      testWidgets('defaults to PuzzleTheme.buttonColor', (tester) async {
        const themeBackgroundColor = Colors.orange;
        when(() => theme.buttonColor).thenReturn(themeBackgroundColor);

        await tester.pumpApp(
          PuzzleButton(
            onPressed: () {},
            child: SizedBox(),
          ),
        );

        expect(
          tester.firstWidget<Material>(find.byType(Material)).color,
          equals(themeBackgroundColor),
        );
      });

      testWidgets('can be overriden with a property', (tester) async {
        const backgroundColor = Colors.purple;
        const themeBackgroundColor = Colors.orange;
        when(() => theme.buttonColor).thenReturn(themeBackgroundColor);

        await tester.pumpApp(
          PuzzleButton(
            onPressed: () {},
            backgroundColor: backgroundColor,
            child: SizedBox(),
          ),
        );

        expect(
          tester.firstWidget<Material>(find.byType(Material)).color,
          equals(backgroundColor),
        );
      });
    });

    group('textColor', () {
      testWidgets('defaults to PuzzleColors.white', (tester) async {
        await tester.pumpApp(
          PuzzleButton(
            onPressed: () {},
            child: SizedBox(),
          ),
        );

        expect(
          tester.firstWidget<Material>(find.byType(Material)).textStyle?.color,
          equals(PuzzleColors.white),
        );
      });

      testWidgets('can be overriden with a property', (tester) async {
        const textColor = Colors.orange;

        await tester.pumpApp(
          PuzzleButton(
            onPressed: () {},
            textColor: textColor,
            child: SizedBox(),
          ),
        );

        expect(
          tester.firstWidget<Material>(find.byType(Material)).textStyle?.color,
          equals(textColor),
        );
      });
    });
  });
}
