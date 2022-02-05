import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout.dart';
import '../../puzzle/puzzle.dart';
import '../../theme/theme.dart';
import '../dashatar.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class DashatarStartSection extends StatelessWidget {
  /// The state of the puzzle.
  final PuzzleState state;

  /// {@macro dashatar_start_section}
  const DashatarStartSection({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        // ignore: avoid_types_on_closure_parameters
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(small: 8, medium: 18),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == DashatarPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(small: 8, medium: 18),
        const DashatarTimer(),
      ],
    );
  }
}
