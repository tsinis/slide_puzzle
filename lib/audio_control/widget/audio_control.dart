import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../layout/layout.dart';
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
    final audioMuted =
        // ignore: avoid_types_on_closure_parameters
        context.select((AudioControlBloc bloc) => bloc.state.muted);
    final audioIcon =
        audioMuted ? FontAwesomeIcons.volumeXmark : FontAwesomeIcons.volumeHigh;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<AudioControlBloc>().add(AudioToggled()),
        child: AnimatedSwitcher(
          duration: PuzzleThemeAnimationDuration.backgroundColorChange,
          child: SizedBox.square(
            dimension: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ResponsiveLayoutBuilder(
                small: (_, __) => FaIcon(
                  audioIcon,
                  key: const Key('audio_control_small'),
                  color: Colors.white,
                  size: 36,
                ),
                medium: (_, __) => FaIcon(
                  audioIcon,
                  key: const Key('audio_control_medium'),
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
