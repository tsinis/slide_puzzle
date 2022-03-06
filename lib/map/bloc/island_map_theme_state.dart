// ignore_for_file: public_member_api_docs

part of 'island_map_theme_bloc.dart';

class IslandMapThemeState extends Equatable {
  /// The list of all available [IslandMapTheme]s.
  final List<IslandMapTheme> themes;

  /// Currently selected [IslandMapTheme].
  final IslandMapTheme theme;

  @override
  List<Object> get props => [themes, theme];
  const IslandMapThemeState({
    required this.themes,
    this.theme = const GreenIslandMapTheme(),
  });

  IslandMapThemeState copyWith({
    List<IslandMapTheme>? themes,
    IslandMapTheme? theme,
  }) =>
      IslandMapThemeState(
        themes: themes ?? this.themes,
        theme: theme ?? this.theme,
      );
}
