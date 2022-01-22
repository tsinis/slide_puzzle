import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../colors/colors.dart';
import '../../l10n/l10n.dart';
import '../../layout/layout.dart';
import '../../typography/typography.dart';
import '../dashatar.dart';

/// {@template dashatar_share_your_score}
/// Displays buttons to share a score of the completed puzzle.
/// {@endtemplate}
class DashatarShareYourScore extends StatelessWidget {
  /// The entry animation of this widget.
  final DashatarShareDialogEnterAnimation animation;

  /// {@macro dashatar_share_your_score}
  const DashatarShareYourScore({required this.animation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      child: (currentSize) {
        final titleTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4
            : PuzzleTextStyle.headline3;

        final messageTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodyXSmall
            : PuzzleTextStyle.bodySmall;

        const textAlign = TextAlign.center;

        final messageWidth =
            currentSize == ResponsiveLayoutSize.medium ? 434.0 : 307.0;

        const buttonsMainAxisAlignment = MainAxisAlignment.center;

        return Column(
          key: const Key('dashatar_share_your_score'),
          children: [
            SlideTransition(
              position: animation.shareYourScoreOffset,
              child: Opacity(
                opacity: animation.shareYourScoreOpacity.value,
                child: Column(
                  children: [
                    Text(
                      l10n.dashatarSuccessShareYourScoreTitle,
                      key: const Key('dashatar_share_your_score_title'),
                      textAlign: textAlign,
                      style: titleTextStyle.copyWith(
                        color: PuzzleColors.black,
                      ),
                    ),
                    const Gap(16),
                    SizedBox(
                      width: messageWidth,
                      child: Text(
                        l10n.dashatarSuccessShareYourScoreMessage,
                        key: const Key('dashatar_share_your_score_message'),
                        textAlign: textAlign,
                        style: messageTextStyle.copyWith(
                          color: PuzzleColors.grey1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const ResponsiveGap(small: 40, medium: 40),
            SlideTransition(
              position: animation.socialButtonsOffset,
              child: Opacity(
                opacity: animation.socialButtonsOpacity.value,
                child: Row(
                  mainAxisAlignment: buttonsMainAxisAlignment,
                  children: const [
                    DashatarTwitterButton(),
                    Gap(16),
                    DashatarFacebookButton(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
