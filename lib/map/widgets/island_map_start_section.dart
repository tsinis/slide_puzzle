import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout.dart';
import '../../puzzle/puzzle.dart';
import '../../theme/theme.dart';
import '../island_map.dart';

/// {@template island_map_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class IslandMapStartSection extends StatelessWidget {
  /// The state of the puzzle.
  final PuzzleState state;

  /// {@macro island_map_start_section}
  const IslandMapStartSection({required this.state, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        // ignore: avoid_types_on_closure_parameters
        context.select((IslandMapPuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(small: 8, medium: 18),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == IslandMapPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(small: 8, medium: 18),
        const IslandMapTimer(),
      ],
    );
  }
}
