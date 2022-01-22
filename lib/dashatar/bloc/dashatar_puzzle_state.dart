// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

/// The status of [DashatarPuzzleState].
// ignore: prefer-match-file-name
enum DashatarPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started,
}

class DashatarPuzzleState extends Equatable {
  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  DashatarPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? DashatarPuzzleStatus.loading
      : (secondsToBegin == 0
          ? DashatarPuzzleStatus.started
          : DashatarPuzzleStatus.notStarted);

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  const DashatarPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  DashatarPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) =>
      DashatarPuzzleState(
        isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
        secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      );
}
