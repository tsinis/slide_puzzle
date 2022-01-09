// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  @override
  List<Object> get props => [];

  const PuzzleEvent();
}

class PuzzleInitialized extends PuzzleEvent {
  final bool shufflePuzzle;

  @override
  List<Object> get props => [shufflePuzzle];

  const PuzzleInitialized({required this.shufflePuzzle});
}

class TileTapped extends PuzzleEvent {
  final Tile tile;

  @override
  List<Object> get props => [tile];

  const TileTapped(this.tile);
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset();
}
