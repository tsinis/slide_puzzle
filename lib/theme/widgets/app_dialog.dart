import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../layout/layout.dart';

/// {@template app_dialog}
/// Displays a full screen dialog on a small display and
/// a fixed-width rounded dialog on a medium and large display.
/// {@endtemplate}
class AppDialog extends StatelessWidget {
  /// The content of this dialog.
  final Widget child;

  /// {@macro app_dialog}
  const AppDialog({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponsiveLayoutBuilder(
        small: (_, __) => Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ),
        medium: (_, child) => child!,
        child: (currentSize) => Dialog(
          clipBehavior: Clip.hardEdge,
          backgroundColor: PuzzleColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: SizedBox(width: 700, child: child),
        ),
      );
}
