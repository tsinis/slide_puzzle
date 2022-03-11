import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/helpers/prefetch_web_to_memory.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  group('prefetchWebToMemory', () {
    test(
      'throws no UnimplementedError '
      'when the platform is Web',
      () async {
        final platformHelper = MockPlatformHelper();
        when(() => platformHelper.isWeb).thenReturn(true);
        await prefetchWebToMemory('', platformHelper).catchError(
          expectAsync1((e) => expect(e, isArgumentError)),
        );
      },
    );

    test(
      'throws UnimplementedError '
      'when the platform is not Web',
      () async {
        final platformHelper = MockPlatformHelper();
        when(() => platformHelper.isWeb).thenReturn(false);
        await prefetchWebToMemory('', platformHelper).catchError(
          expectAsync1((e) => expect(e, isUnimplementedError)),
        );
      },
    );
  });
}
