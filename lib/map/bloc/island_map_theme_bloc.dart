import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../island_map.dart';

part 'island_map_theme_event.dart';
part 'island_map_theme_state.dart';

/// {@template island_map_theme_bloc}
/// Bloc responsible for the currently selected [IslandMapTheme].
/// {@endtemplate}
class IslandMapThemeBloc
    extends Bloc<IslandMapThemeEvent, IslandMapThemeState> {
  /// {@macro island_map_theme_bloc}
  IslandMapThemeBloc({required List<IslandMapTheme> themes})
      : super(IslandMapThemeState(themes: themes)) {
    on<IslandMapThemeChanged>(_onIslandMapThemeChanged);
  }

  void _onIslandMapThemeChanged(
    IslandMapThemeChanged event,
    Emitter<IslandMapThemeState> emit,
  ) =>
      emit(state.copyWith(theme: state.themes[event.themeIndex]));
}
