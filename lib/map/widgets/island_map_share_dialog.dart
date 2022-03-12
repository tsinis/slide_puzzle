import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_control/audio_control.dart';
import '../../colors/colors.dart';
import '../../helpers/helpers.dart';
import '../../layout/layout.dart';
import '../island_map.dart';

/// {@template island_map_share_dialog}
/// Displays a IslandMap share dialog with a score of the completed puzzle
/// and an option to share the score using Twitter or Facebook.
/// {@endtemplate}
class IslandMapShareDialog extends StatefulWidget {
  final AudioPlayerFactory _audioPlayerFactory;

  /// {@macro island_map_share_dialog}
  const IslandMapShareDialog({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  @override
  State<IslandMapShareDialog> createState() => _IslandMapShareDialogState();
}

class _IslandMapShareDialogState extends State<IslandMapShareDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AudioPlayer _successAudioPlayer;
  late final AudioPlayer _clickAudioPlayer;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 8));

    _successAudioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/success.mp3');
    unawaited(_successAudioPlayer.play());

    _clickAudioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/click.mp3');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future.delayed(const Duration(milliseconds: 140), () {
      _controller.forward();
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _successAudioPlayer.dispose();
    _clickAudioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 700,
        child: AudioControlListener(
          key: const Key('island_map_share_dialog_success_audio_player'),
          audioPlayer: _successAudioPlayer,
          child: AudioControlListener(
            key: const Key('island_map_share_dialog_click_audio_player'),
            audioPlayer: _clickAudioPlayer,
            child: ResponsiveLayoutBuilder(
              small: (_, child) => child!,
              medium: (_, child) => child!,
              child: (currentSize) {
                final padding = currentSize == ResponsiveLayoutSize.medium
                    ? const EdgeInsets.fromLTRB(48, 54, 48, 53)
                    : const EdgeInsets.fromLTRB(20, 99, 20, 76);

                final closeIconOffset =
                    currentSize == ResponsiveLayoutSize.medium
                        ? const Offset(25, 28)
                        : const Offset(17, 63);

                return Stack(
                  alignment: Alignment.center,
                  key: const Key('island_map_share_dialog'),
                  children: [
                    SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, constraints) => SizedBox(
                          width: constraints.maxWidth,
                          child: Padding(
                            padding: padding,
                            child: IslandMapShareDialogAnimatedBuilder(
                              animation: _controller,
                              builder: (context, child, animation) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SlideTransition(
                                    position: animation.scoreOffset,
                                    child: Opacity(
                                      opacity: animation.scoreOpacity.value,
                                      child: const IslandMapScore(),
                                    ),
                                  ),
                                  const ResponsiveGap(small: 32, medium: 32),
                                  IslandMapShareYourScore(
                                    animation: animation,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                      ),
                    ),
                    Positioned(
                      right: closeIconOffset.dx,
                      top: closeIconOffset.dy,
                      child: IconButton(
                        key: const Key('island_map_share_dialog_close_button'),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 18,
                        icon: const Icon(
                          Icons.close,
                          color: PuzzleColors.black,
                        ),
                        onPressed: () {
                          unawaited(_clickAudioPlayer.play());
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
