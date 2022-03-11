import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../app/view/app.dart';
import 'platform_helper.dart';

/// Prefetches the given [filePath] to memory.
Future<void> prefetchWebToMemory(
  String filePath,
  PlatformHelper platformHelper,
) async {
  if (platformHelper.isWeb) {
    // We rely on browser caching here. Once the browser downloads the file,
    // the native implementation should be able to access it from cache.
    await http.get(Uri.parse('${App.localAssetsPrefix}$filePath'));
  } else {
    throw UnimplementedError(
      'The function `prefetchToMemory` is not implemented '
      'for platforms other than Web.',
    );
  }
}
