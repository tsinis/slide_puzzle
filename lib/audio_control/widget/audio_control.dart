import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout.dart';
import '../../map/themes/green_dashatar_theme.dart';
import '../../theme/theme.dart';
import '../audio_control.dart';

/// {@template audio_control}
/// Displays and allows to update the current audio status of the puzzle.
/// {@endtemplate}
class AudioControl extends StatelessWidget {
  /// {@macro audio_control}
  const AudioControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    const theme = GreenDashatarTheme();
    final audioMuted =
        // ignore: avoid_types_on_closure_parameters
        context.select((AudioControlBloc bloc) => bloc.state.muted);
    final audioAsset =
        audioMuted ? theme.audioControlOffAsset : theme.audioControlOnAsset;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<AudioControlBloc>().add(AudioToggled()),
        child: AnimatedSwitcher(
          duration: PuzzleThemeAnimationDuration.backgroundColorChange,
          child: ResponsiveLayoutBuilder(
            key: Key(audioAsset),
            small: (_, __) => Image.asset(
              audioAsset,
              key: const Key('audio_control_small'),
              width: 24,
              height: 24,
            ),
            medium: (_, __) => Image.asset(
              audioAsset,
              key: const Key('audio_control_medium'),
              width: 33,
              height: 33,
            ),
          ),
        ),
      ),
    );
  }
}
