// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppFlutterLogo', () {
    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(AppFlutterLogo());

      expect(
        find.byType(FlutterLogo),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(AppFlutterLogo());

      expect(
        find.byType(FlutterLogo),
        findsOneWidget,
      );
    });

    testWidgets(
      'renders colored Image '
      'when isColored is true',
      (tester) async {
        await tester.pumpApp(
          AppFlutterLogo(
            isColored: true,
            height: 18,
          ),
        );

        expect(
          find.byType(FlutterLogo),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders white Image '
      'when isColored is false',
      (tester) async {
        await tester.pumpApp(
          AppFlutterLogo(
            isColored: false,
          ),
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is ShaderMask && widget.blendMode == BlendMode.srcIn,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders white Image '
      'when isColored is true',
      (tester) async {
        await tester.pumpApp(
          AppFlutterLogo(
            isColored: true,
          ),
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is ShaderMask && widget.blendMode == BlendMode.overlay,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
