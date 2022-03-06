import 'package:flutter/material.dart';

import '../../audio_control/widget/widget.dart';
import '../../layout/layout.dart';
import '../../models/models.dart';
import '../../puzzle/puzzle.dart';
import '../island_map.dart';
import '../models/illustration_colors.dart';

/// {@template island_map_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [IslandMapTheme].
/// {@endtemplate}
class IslandMapPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  @override
  List<Object?> get props => [];

  /// {@macro island_map_puzzle_layout_delegate}
  const IslandMapPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) =>
      IslandMapStartSection(state: state);

  @override
  Widget endSectionBuilder(PuzzleState state) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IslandMapPuzzleActionButton(),
              const SizedBox(width: 16),
              AudioControl(key: audioControlKey),
            ],
          ),
          const ResponsiveGap(small: 23, medium: 32),
        ],
      );

  @override
  Widget backgroundBuilder(PuzzleState state) =>
      const ColoredBox(color: IllustrationColors.seaColor);

  @override
  Widget boardBuilder(int size, List<Widget> tiles) => Stack(
        children: [
          IslandMapPuzzleBoard(tiles: tiles),
          const Positioned(
            top: 0,
            right: 0,
            child: IslandMapCountdown(),
          ),
        ],
      );

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) =>
      IslandMapPuzzleTile(tile: tile, state: state);

  @override
  Widget whitespaceTileBuilder() => const SizedBox();
}
