import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../colors/colors.dart';
import '../../l10n/l10n.dart';
import '../../layout/layout.dart';
import '../../theme/theme.dart';
import '../../timer/timer.dart';
import '../../typography/typography.dart';

/// {@template dashatar_timer}
/// Displays how many seconds elapsed since starting the puzzle.
/// {@endtemplate}
class DashatarTimer extends StatelessWidget {
  /// The optional [TextStyle] of this timer.
  final TextStyle? textStyle;

  /// The optional icon [Size] of this timer.
  final Size? iconSize;

  /// The optional icon padding of this timer.
  final double? iconPadding;

  /// The optional [MainAxisAlignment] of this timer.
  /// Defaults to [MainAxisAlignment.center] if not provided.
  final MainAxisAlignment? mainAxisAlignment;

  /// {@macro dashatar_timer}
  const DashatarTimer({
    Key? key,
    this.textStyle,
    this.iconSize,
    this.iconPadding,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondsElapsed =
        // ignore: avoid_types_on_closure_parameters
        context.select((TimerBloc bloc) => bloc.state.secondsElapsed);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      child: (currentSize) {
        final currentTextStyle = textStyle ??
            (currentSize == ResponsiveLayoutSize.small
                ? PuzzleTextStyle.headline4
                : PuzzleTextStyle.headline3);

        final currentIconSize = iconSize?.width ??
            (currentSize == ResponsiveLayoutSize.small ? 18.0 : 22.0);

        final timeElapsed = Duration(seconds: secondsElapsed);

        return Row(
          key: const Key('dashatar_timer'),
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: currentTextStyle.copyWith(
                color: PuzzleColors.white,
              ),
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                _formatDuration(timeElapsed),
                key: ValueKey(secondsElapsed),
                semanticsLabel: _getDurationLabel(timeElapsed, context),
              ),
            ),
            Gap(iconPadding ?? 8),
            FaIcon(
              FontAwesomeIcons.clock,
              key: const Key('dashatar_timer_icon'),
              color: Colors.white,
              size: currentIconSize,
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _getDurationLabel(Duration duration, BuildContext context) =>
      context.l10n.dashatarPuzzleDurationLabelText(
        duration.inHours.toString(),
        duration.inMinutes.remainder(60).toString(),
        duration.inSeconds.remainder(60).toString(),
      );
}
