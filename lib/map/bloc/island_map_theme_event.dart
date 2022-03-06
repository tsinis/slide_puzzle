// ignore_for_file: public_member_api_docs

part of 'island_map_theme_bloc.dart';

abstract class IslandMapThemeEvent extends Equatable {
  const IslandMapThemeEvent();
}

class IslandMapThemeChanged extends IslandMapThemeEvent {
  /// The index of the changed theme in [IslandMapThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];

  const IslandMapThemeChanged({required this.themeIndex});
}
