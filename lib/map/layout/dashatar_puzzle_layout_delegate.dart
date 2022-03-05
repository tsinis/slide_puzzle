import 'package:flutter/material.dart';

import '../../audio_control/widget/widget.dart';
import '../../layout/layout.dart';
import '../../models/models.dart';
import '../../puzzle/puzzle.dart';
import '../dashatar.dart';
import '../models/illustration_colors.dart';

/// {@template dashatar_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [DashatarTheme].
/// {@endtemplate}
class DashatarPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  @override
  List<Object?> get props => [];

  /// {@macro dashatar_puzzle_layout_delegate}
  const DashatarPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) =>
      DashatarStartSection(state: state);

  @override
  Widget endSectionBuilder(PuzzleState state) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DashatarPuzzleActionButton(),
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
          DashatarPuzzleBoard(tiles: tiles),
          const Positioned(
            top: 0,
            right: 0,
            child: DashatarCountdown(),
          ),
        ],
      );

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) =>
      DashatarPuzzleTile(tile: tile, state: state);

  @override
  Widget whitespaceTileBuilder() => const SizedBox();
}
