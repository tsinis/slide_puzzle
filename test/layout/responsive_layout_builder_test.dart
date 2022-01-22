import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/layout/layout.dart';

import '../helpers/helpers.dart';

void main() => group('ResponsiveLayout', () {
      group('on a medium display', () {
        testWidgets('displays a medium layout', (tester) async {
          tester.setMediumDisplaySize();

          const smallKey = Key('__small__');
          const mediumKey = Key('__medium__');
          const largeKey = Key('__large__');

          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, __) => const SizedBox(key: smallKey),
              medium: (_, __) => const SizedBox(key: mediumKey),
            ),
          );

          expect(find.byKey(smallKey), findsNothing);
          expect(find.byKey(mediumKey), findsOneWidget);
          expect(find.byKey(largeKey), findsNothing);
        });

        testWidgets('displays child when available', (tester) async {
          tester.setMediumDisplaySize();

          const smallKey = Key('__small__');
          const mediumKey = Key('__medium__');
          const childKey = Key('__child__');

          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, child) => SizedBox(key: smallKey, child: child),
              medium: (_, child) => SizedBox(key: mediumKey, child: child),
              child: (_) => const SizedBox(key: childKey),
            ),
          );

          expect(find.byKey(smallKey), findsNothing);
          expect(find.byKey(mediumKey), findsOneWidget);
          expect(find.byKey(childKey), findsOneWidget);
        });

        testWidgets('returns medium layout size for child', (tester) async {
          tester.setMediumDisplaySize();

          ResponsiveLayoutSize? layoutSize;
          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, child) => child!,
              medium: (_, child) => child!,
              child: (currentLayoutSize) {
                layoutSize = currentLayoutSize;

                return const SizedBox();
              },
            ),
          );

          expect(
            layoutSize,
            equals(ResponsiveLayoutSize.medium),
          );
        });
      });

      group('on a small display', () {
        testWidgets('displays a small layout', (tester) async {
          tester.setSmallDisplaySize();

          const smallKey = Key('__small__');
          const mediumKey = Key('__medium__');
          const largeKey = Key('__large__');

          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, __) => const SizedBox(key: smallKey),
              medium: (_, __) => const SizedBox(key: mediumKey),
            ),
          );

          expect(find.byKey(smallKey), findsOneWidget);
          expect(find.byKey(mediumKey), findsNothing);
          expect(find.byKey(largeKey), findsNothing);
        });

        testWidgets('displays child when available', (tester) async {
          tester.setSmallDisplaySize();

          const smallKey = Key('__small__');
          const mediumKey = Key('__medium__');
          const largeKey = Key('__large__');
          const childKey = Key('__child__');

          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, child) => SizedBox(key: smallKey, child: child),
              medium: (_, child) => SizedBox(key: mediumKey, child: child),
              child: (_) => const SizedBox(key: childKey),
            ),
          );

          expect(find.byKey(smallKey), findsOneWidget);
          expect(find.byKey(mediumKey), findsNothing);
          expect(find.byKey(largeKey), findsNothing);
          expect(find.byKey(childKey), findsOneWidget);

          addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        });

        testWidgets('returns small layout size for child', (tester) async {
          tester.setSmallDisplaySize();

          ResponsiveLayoutSize? layoutSize;
          await tester.pumpApp(
            ResponsiveLayoutBuilder(
              small: (_, child) => child!,
              medium: (_, child) => child!,
              child: (currentLayoutSize) {
                layoutSize = currentLayoutSize;

                return const SizedBox();
              },
            ),
          );

          expect(
            layoutSize,
            equals(ResponsiveLayoutSize.small),
          );
        });
      });
    });
