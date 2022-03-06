import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../l10n/l10n.dart';
import '../../puzzle/puzzle.dart';
import '../../theme/theme.dart';
import '../../timer/timer.dart';
import '../island_map.dart';

/// {@template island_map_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class IslandMapPuzzleActionButton extends StatefulWidget {
  final AudioPlayerFactory _audioPlayerFactory;

  /// {@macro island_map_puzzle_action_button}
  const IslandMapPuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  @override
  State<IslandMapPuzzleActionButton> createState() =>
      _IslandMapPuzzleActionButtonState();
}

class _IslandMapPuzzleActionButtonState
    extends State<IslandMapPuzzleActionButton> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/click.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();

    final status =
        // ignore: avoid_types_on_closure_parameters
        context.select((IslandMapPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == IslandMapPuzzleStatus.loading;
    final isStarted = status == IslandMapPuzzleStatus.started;

    final text = isStarted
        ? context.l10n.islandMapRestart
        : (isLoading
            ? context.l10n.islandMapGetReady
            : context.l10n.islandMapStartGame);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(status),
          message: isStarted ? context.l10n.puzzleRestartTooltip : '',
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: isLoading
                ? null
                : () async {
                    final hasStarted = status == IslandMapPuzzleStatus.started;

                    // Reset the timer and the countdown.
                    context.read<TimerBloc>().add(const TimerReset());
                    context.read<IslandMapPuzzleBloc>().add(
                          IslandMapCountdownReset(
                            secondsToBegin: hasStarted ? 5 : 3,
                          ),
                        );

                    if (hasStarted) {
                      context.read<PuzzleBloc>().add(const PuzzleInitialized());
                    }

                    unawaited(_audioPlayer.replay());
                  },
            textColor: isLoading ? theme.defaultColor : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
