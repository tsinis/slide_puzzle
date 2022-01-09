// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  @override
  List<Object> get props => [];

  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  const TimerStarted();
}

class TimerTicked extends TimerEvent {
  final int secondsElapsed;

  @override
  List<Object> get props => [secondsElapsed];

  const TimerTicked(this.secondsElapsed);
}

class TimerStopped extends TimerEvent {
  const TimerStopped();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}
