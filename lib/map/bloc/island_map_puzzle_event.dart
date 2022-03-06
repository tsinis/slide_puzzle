// ignore_for_file: public_member_api_docs

part of 'island_map_puzzle_bloc.dart';

abstract class IslandMapPuzzleEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const IslandMapPuzzleEvent();
}

class IslandMapCountdownStarted extends IslandMapPuzzleEvent {
  const IslandMapCountdownStarted();
}

class IslandMapCountdownTicked extends IslandMapPuzzleEvent {
  const IslandMapCountdownTicked();
}

class IslandMapCountdownStopped extends IslandMapPuzzleEvent {
  const IslandMapCountdownStopped();
}

class IslandMapCountdownReset extends IslandMapPuzzleEvent {
  /// The number of seconds to countdown from.
  /// Defaults to [IslandMapPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];

  const IslandMapCountdownReset({this.secondsToBegin});
}
