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
  Widget build(BuildContext context) => ShaderMask(
        blendMode: isColored ? BlendMode.overlay : BlendMode.srcIn,
        shaderCallback: (bounds) {
          final color = isColored ? Colors.transparent : Colors.white;

          return LinearGradient(colors: [color, color]).createShader(bounds);
        },
        child: AnimatedSwitcher(
          duration: PuzzleThemeAnimationDuration.logoChange,
          child: height != null
              ? FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  size: height! * 3.6,
                )
              : ResponsiveLayoutBuilder(
                  small: (_, __) => const FlutterLogo(
                    style: FlutterLogoStyle.horizontal,
                    size: 48,
                  ),
                  medium: (_, __) => const FlutterLogo(
                    style: FlutterLogoStyle.horizontal,
                    size: 60,
                  ),
                ),
        ),
      );
}
