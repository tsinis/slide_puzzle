import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors/colors.dart';
import '../../l10n/l10n.dart';
import '../../layout/layout.dart';
import '../../puzzle/puzzle.dart';
import '../../theme/themes/themes.dart';
import '../../theme/widgets/widgets.dart';
import '../../typography/typography.dart';
import '../island_map.dart';

/// {@template island_map_score}
/// Displays the score of the solved IslandMap puzzle.
/// {@endtemplate}
class IslandMapScore extends StatelessWidget {
  static const _smallImageOffset = Offset(124, 36);
  static const _mediumImageOffset = Offset(215, -47);

  /// {@macro island_map_score}
  const IslandMapScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    const theme = GreenIslandMapTheme();
    final state = context.watch<PuzzleBloc>().state;
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      child: (currentSize) {
        final height =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 355.0;

        final imageOffset = currentSize == ResponsiveLayoutSize.medium
            ? _mediumImageOffset
            : _smallImageOffset;

        final imageHeight =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 437.0;

        final completedTextWidth =
            currentSize == ResponsiveLayoutSize.small ? 160.0 : double.infinity;

        final wellDoneTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4Soft
            : PuzzleTextStyle.headline3;

        final timerTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        final timerIconSize = currentSize == ResponsiveLayoutSize.small
            ? const Size(18, 18)
            : const Size(22, 22);

        final timerIconPadding =
            currentSize == ResponsiveLayoutSize.small ? 4.0 : 6.0;

        final numberOfMovesTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        return ClipRRect(
          key: const Key('island_map_score'),
          borderRadius: const BorderRadius.all(Radius.circular(22)),
          child: Container(
            width: double.infinity,
            height: height,
            color: theme.backgroundColor,
            child: Stack(
              children: [
                Positioned(
                  left: imageOffset.dx,
                  top: imageOffset.dy,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40, right: 120),
                    child: SvgPicture.asset(
                      theme.successThemeAsset,
                      height: imageHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppFlutterLogo(
                        height: 18,
                        isColored: false,
                      ),
                      SizedBox(
                        key: const Key('island_map_score_completed'),
                        width: completedTextWidth,
                        child: AnimatedDefaultTextStyle(
                          style: PuzzleTextStyle.headline5.copyWith(
                            color: theme.defaultColor,
                          ),
                          duration: PuzzleThemeAnimationDuration.textStyle,
                          child: Text(l10n.islandMapSuccessCompleted),
                        ),
                      ),
                      const ResponsiveGap(small: 8, medium: 16),
                      AnimatedDefaultTextStyle(
                        key: const Key('island_map_score_well_done'),
                        style: wellDoneTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(l10n.islandMapSuccessWellDone),
                      ),
                      const ResponsiveGap(small: 24, medium: 32),
                      AnimatedDefaultTextStyle(
                        key: const Key('island_map_score_score'),
                        style: PuzzleTextStyle.headline5.copyWith(
                          color: theme.defaultColor,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(l10n.islandMapSuccessScore),
                      ),
                      const ResponsiveGap(small: 8, medium: 9),
                      IslandMapTimer(
                        textStyle: timerTextStyle,
                        iconSize: timerIconSize,
                        iconPadding: timerIconPadding,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      const ResponsiveGap(small: 2, medium: 8),
                      AnimatedDefaultTextStyle(
                        key: const Key('island_map_score_number_of_moves'),
                        style: numberOfMovesTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(
                          l10n.islandMapSuccessNumberOfMoves(
                            state.numberOfMoves.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
