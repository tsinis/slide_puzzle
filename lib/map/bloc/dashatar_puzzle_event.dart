// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

abstract class DashatarPuzzleEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const DashatarPuzzleEvent();
}

class DashatarCountdownStarted extends DashatarPuzzleEvent {
  const DashatarCountdownStarted();
}

class DashatarCountdownTicked extends DashatarPuzzleEvent {
  const DashatarCountdownTicked();
}

class DashatarCountdownStopped extends DashatarPuzzleEvent {
  const DashatarCountdownStopped();
}

class DashatarCountdownReset extends DashatarPuzzleEvent {
  /// The number of seconds to countdown from.
  /// Defaults to [DashatarPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];

  const DashatarCountdownReset({this.secondsToBegin});
}
