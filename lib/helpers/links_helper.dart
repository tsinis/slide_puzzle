import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the given [url] in a new tab of the host browser
Future<void> openLink(String url, {VoidCallback? onError}) async {
  final maybeUrl = Uri.tryParse(url);
  if (maybeUrl != null && await canLaunchUrl(maybeUrl)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else if (onError != null) {
    onError();
  }
}
