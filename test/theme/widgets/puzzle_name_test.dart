// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() => group('PuzzleName', () {
      late PuzzleTheme theme;

      const themeName = 'Name';

      setUp(() {
        theme = MockPuzzleTheme();

        when(() => theme.name).thenReturn(themeName);
        when(() => theme.nameColor).thenReturn(Colors.black);
      });

      testWidgets(
        'renders an empty widget '
        'on a medium display',
        (tester) async {
          tester.setMediumDisplaySize();

          expect(find.byType(SizedBox), findsNothing);
          expect(find.text(themeName), findsOneWidget);
        },
      );

      testWidgets(
        'renders an empty widget '
        'on a small display',
        (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(PuzzleName());

          expect(find.byType(SizedBox), findsOneWidget);
          expect(find.text(themeName), findsNothing);
        },
      );
    });
