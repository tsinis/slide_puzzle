// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/app/app.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets(
      'renders PuzzlePage '
      'when the platform is Web',
      (tester) async {
        final platformHelper = MockPlatformHelper();
        when(() => platformHelper.isWeb).thenReturn(true);

        await tester.pumpWidget(
          App(
            platformHelperFactory: () => platformHelper,
          ),
        );

        await tester.pump(const Duration(milliseconds: 1020));

        expect(find.byType(PuzzlePage), findsOneWidget);
      },
    );
    test('audioAssets', () => expect(App.audioAssets.length, 4));
  });
}
