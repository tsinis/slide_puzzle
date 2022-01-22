import 'package:flutter/material.dart';

import '../../layout/layout.dart';
import '../themes/themes.dart';

/// {@template app_flutter_logo}
/// Variant of Flutter logo that can be either white or colored.
/// {@endtemplate}
class AppFlutterLogo extends StatelessWidget {
  /// Whether this logo is colored.
  final bool isColored;

  /// The optional height of this logo.
  final double? height;

  /// {@macro app_flutter_logo}
  const AppFlutterLogo({this.isColored = true, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetName = isColored
        ? 'assets/images/logo_flutter_color.png'
        : 'assets/images/logo_flutter_white.png';

    return AnimatedSwitcher(
      duration: PuzzleThemeAnimationDuration.logoChange,
      child: height != null
          ? Image.asset(
              assetName,
              height: height,
            )
          : ResponsiveLayoutBuilder(
              key: Key(assetName),
              small: (_, __) => Image.asset(
                assetName,
                height: 24,
              ),
              medium: (_, __) => Image.asset(
                assetName,
                height: 29,
              ),
            ),
    );
  }
}
