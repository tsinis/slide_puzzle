import 'package:flutter/widgets.dart';

import 'layout.dart';

/// Represents the layout size passed to [ResponsiveLayoutBuilder.child].
// ignore: prefer-match-file-name
enum ResponsiveLayoutSize {
  /// Small layout
  small,

  /// Medium layout
  medium,
}

/// Signature for the individual builders (`small`, `medium`, ).
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

/// {@template responsive_layout_builder}
/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
/// {@endtemplate}
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// [ResponsiveLayoutWidgetBuilder] for small layout.
  final ResponsiveLayoutWidgetBuilder small;

  /// [ResponsiveLayoutWidgetBuilder] for medium layout.
  final ResponsiveLayoutWidgetBuilder medium;

  /// Optional child widget builder based on the current layout size
  /// which will be passed to the `small`, `medium` builders
  /// as a way to share/optimize shared layout.
  final Widget Function(ResponsiveLayoutSize currentSize)? child;

  /// {@macro responsive_layout_builder}
  const ResponsiveLayoutBuilder({
    required this.small,
    required this.medium,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;

          if (screenWidth <= PuzzleBreakpoints.small) {
            return small(context, child?.call(ResponsiveLayoutSize.small));
          }

          return medium(context, child?.call(ResponsiveLayoutSize.medium));
        },
      );
}
