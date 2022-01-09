// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

class TimerState extends Equatable {
  final bool isRunning;
  final int secondsElapsed;

  @override
  List<Object> get props => [isRunning, secondsElapsed];

  const TimerState({
    this.isRunning = false,
    this.secondsElapsed = 0,
  });

  TimerState copyWith({
    bool? isRunning,
    int? secondsElapsed,
  }) =>
      TimerState(
        isRunning: isRunning ?? this.isRunning,
        secondsElapsed: secondsElapsed ?? this.secondsElapsed,
      );
}
