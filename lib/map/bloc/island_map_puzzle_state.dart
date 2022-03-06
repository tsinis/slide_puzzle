// ignore_for_file: public_member_api_docs

part of 'island_map_puzzle_bloc.dart';

/// The status of [IslandMapPuzzleState].
// ignore: prefer-match-file-name
enum IslandMapPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started,
}

class IslandMapPuzzleState extends Equatable {
  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  IslandMapPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? IslandMapPuzzleStatus.loading
      : (secondsToBegin == 0
          ? IslandMapPuzzleStatus.started
          : IslandMapPuzzleStatus.notStarted);

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  const IslandMapPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  IslandMapPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) =>
      IslandMapPuzzleState(
        isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
        secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      );
}
