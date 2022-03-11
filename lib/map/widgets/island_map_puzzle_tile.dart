// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../layout/layout.dart';
import '../../models/models.dart';
import '../../puzzle/puzzle.dart';
import '../island_map.dart';
import 'animated_tile.dart';

abstract class _TileSize {
  static const double small = 77;
  static const double medium = 105;
}

/// {@template island_map_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class IslandMapPuzzleTile extends StatefulWidget {
  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  /// {@macro island_map_puzzle_tile}
  const IslandMapPuzzleTile({
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
    Key? key,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  @override
  State<IslandMapPuzzleTile> createState() => IslandMapPuzzleTileState();
}

/// The state of [IslandMapPuzzleTile].
@visibleForTesting
class IslandMapPuzzleTileState extends State<IslandMapPuzzleTile>
    with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/move_tile.mp3');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final status =
        context.select((IslandMapPuzzleBloc bloc) => bloc.state.status);

    final isStarted = status == IslandMapPuzzleStatus.started;

    final movementDuration = status == IslandMapPuzzleStatus.loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedAlign(
        alignment: FractionalOffset(
          (widget.tile.currentPosition.x - 1) / (size - 1),
          (widget.tile.currentPosition.y - 1) / (size - 1),
        ),
        duration: movementDuration,
        curve: Curves.easeInOut,
        child: ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox.square(
            key: Key('island_map_puzzle_tile_small_${widget.tile.value}'),
            dimension: _TileSize.small,
            child: child,
          ),
          medium: (_, child) => SizedBox.square(
            key: Key('island_map_puzzle_tile_medium_${widget.tile.value}'),
            dimension: _TileSize.medium,
            child: child,
          ),
          child: (_) => AnimatedTile(
            onPressed: isStarted
                ? () {
                    context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                    unawaited(_audioPlayer?.replay());
                  }
                : () {},
            index: ValueKey<int>(widget.tile.value),
          ),
        ),
      ),
    );
  }
}
