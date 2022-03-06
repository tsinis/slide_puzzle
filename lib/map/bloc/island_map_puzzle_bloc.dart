import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'island_map_puzzle_event.dart';
part 'island_map_puzzle_state.dart';

/// {@template island_map_puzzle_bloc}
/// A bloc responsible for starting the IslandMap puzzle.
/// {@endtemplate}
class IslandMapPuzzleBloc
    extends Bloc<IslandMapPuzzleEvent, IslandMapPuzzleState> {
  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  /// {@macro island_map_puzzle_bloc}
  IslandMapPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(IslandMapPuzzleState(secondsToBegin: secondsToBegin)) {
    on<IslandMapCountdownStarted>(_onCountdownStarted);
    on<IslandMapCountdownTicked>(_onCountdownTicked);
    on<IslandMapCountdownStopped>(_onCountdownStopped);
    on<IslandMapCountdownReset>(_onCountdownReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();

    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const IslandMapCountdownTicked()));
  }

  void _onCountdownStarted(
    IslandMapCountdownStarted _,
    Emitter<IslandMapPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    IslandMapCountdownTicked _,
    Emitter<IslandMapPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    IslandMapCountdownStopped _,
    Emitter<IslandMapPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    IslandMapCountdownReset event,
    Emitter<IslandMapPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
