// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:map_slide_puzzle/layout/layout.dart';

import '../helpers/helpers.dart';

void main() {
  group('ResponsiveGap', () {
    const smallGap = 10.0;
    const mediumGap = 20.0;

    testWidgets('renders a medium gap on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: ResponsiveGap(small: smallGap, medium: mediumGap),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Gap && widget.mainAxisExtent == mediumGap,
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders a small gap on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: ResponsiveGap(small: smallGap, medium: mediumGap),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Gap && widget.mainAxisExtent == smallGap,
        ),
        findsOneWidget,
      );
    });
  });
}
