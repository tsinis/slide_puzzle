// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../themes/puzzle_theme.dart';
import '../themes/simple_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final List<PuzzleTheme> themes;

  ThemeBloc({required this.themes}) : super(const ThemeState()) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(ThemeState(theme: themes[event.themeIndex]));
  }
}
