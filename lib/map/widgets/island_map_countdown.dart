import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../l10n/l10n.dart';
import '../../layout/layout.dart';
import '../../puzzle/puzzle.dart';
import '../../timer/timer.dart';
import '../../typography/typography.dart';
import '../island_map.dart';

/// {@template island_map_countdown}
/// Displays the countdown before the puzzle is started.
/// {@endtemplate}
class IslandMapCountdown extends StatefulWidget {
  final AudioPlayerFactory _audioPlayerFactory;

  /// {@macro island_map_countdown}
  const IslandMapCountdown({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  @override
  State<IslandMapCountdown> createState() => _IslandMapCountdownState();
}

class _IslandMapCountdownState extends State<IslandMapCountdown> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/shuffle.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AudioControlListener(
        audioPlayer: _audioPlayer,
        child: BlocListener<IslandMapPuzzleBloc, IslandMapPuzzleState>(
          listener: (context, state) {
            if (!state.isCountdownRunning) {
              return;
            }

            // Play the shuffle sound when the countdown from 3 to 1 begins.
            if (state.secondsToBegin == 3) {
              unawaited(_audioPlayer.replay());
            }

            // Start the puzzle timer when the countdown finishes.
            if (state.status == IslandMapPuzzleStatus.started) {
              context.read<TimerBloc>().add(const TimerStarted());
            }

            // Shuffle the puzzle on every countdown tick.
            if (state.secondsToBegin >= 1 && state.secondsToBegin <= 3) {
              context.read<PuzzleBloc>().add(const PuzzleReset());
            }
          },
          child: ResponsiveLayoutBuilder(
            small: (_, __) =>
                BlocBuilder<IslandMapPuzzleBloc, IslandMapPuzzleState>(
              builder: (context, state) {
                if (!state.isCountdownRunning || state.secondsToBegin > 3) {
                  return const SizedBox();
                }

                if (state.secondsToBegin > 0) {
                  return IslandMapCountdownSecondsToBegin(
                    key: ValueKey(state.secondsToBegin),
                    secondsToBegin: state.secondsToBegin,
                  );
                } else {
                  return const IslandMapCountdownGo();
                }
              },
            ),
            medium: (_, __) =>
                BlocBuilder<IslandMapPuzzleBloc, IslandMapPuzzleState>(
              builder: (context, state) {
                if (!state.isCountdownRunning || state.secondsToBegin > 3) {
                  return const SizedBox();
                }

                if (state.secondsToBegin > 0) {
                  return IslandMapCountdownSecondsToBegin(
                    key: ValueKey(state.secondsToBegin),
                    secondsToBegin: state.secondsToBegin,
                  );
                } else {
                  return const IslandMapCountdownGo();
                }
              },
            ),
          ),
        ),
      );
}

/// {@template island_map_countdown_seconds_to_begin}
/// Display how many seconds are left to begin the puzzle.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class IslandMapCountdownSecondsToBegin extends StatefulWidget {
  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// {@macro island_map_countdown_seconds_to_begin}
  const IslandMapCountdownSecondsToBegin({
    required this.secondsToBegin,
    Key? key,
  }) : super(key: key);

  @override
  State<IslandMapCountdownSecondsToBegin> createState() =>
      _IslandMapCountdownSecondsToBeginState();
}

class _IslandMapCountdownSecondsToBeginState
    extends State<IslandMapCountdownSecondsToBegin>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.81, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();

    return FadeTransition(
      opacity: outOpacity,
      child: FadeTransition(
        opacity: inOpacity,
        child: ScaleTransition(
          scale: inScale,
          child: Text(
            widget.secondsToBegin.toString(),
            style: PuzzleTextStyle.countdownTime.copyWith(
              color: theme.countdownColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// {@template island_map_countdown_go}
/// Displays a "Go!" text when the countdown reaches 0 seconds.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class IslandMapCountdownGo extends StatefulWidget {
  /// {@macro island_map_countdown_go}
  const IslandMapCountdownGo({Key? key}) : super(key: key);

  @override
  State<IslandMapCountdownGo> createState() => _IslandMapCountdownGoState();
}

class _IslandMapCountdownGoState extends State<IslandMapCountdownGo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const theme = GreenIslandMapTheme();

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: FadeTransition(
        opacity: outOpacity,
        child: FadeTransition(
          opacity: inOpacity,
          child: ScaleTransition(
            scale: outScale,
            child: ScaleTransition(
              scale: inScale,
              child: Text(
                context.l10n.islandMapCountdownGo,
                style: PuzzleTextStyle.countdownTime.copyWith(
                  fontSize: 100,
                  color: theme.defaultColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
