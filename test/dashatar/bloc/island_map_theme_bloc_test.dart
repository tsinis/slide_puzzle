// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/map/island_map.dart';

import '../../helpers/helpers.dart';

void main() {
  group('IslandMapThemeBloc', () {
    test('initial state is correct', () {
      final themes = [MockIslandMapTheme()];

      expect(
        IslandMapThemeBloc(themes: themes).state,
        equals(
          IslandMapThemeState(themes: themes),
        ),
      );
    });

    group('IslandMapThemeChanged', () {
      late IslandMapTheme theme;
      late List<IslandMapTheme> themes;

      blocTest<IslandMapThemeBloc, IslandMapThemeState>(
        'emits new theme',
        setUp: () {
          theme = MockIslandMapTheme();
          themes = [MockIslandMapTheme(), theme];
        },
        build: () => IslandMapThemeBloc(themes: themes),
        act: (bloc) => bloc.add(IslandMapThemeChanged(themeIndex: 1)),
        expect: () => <IslandMapThemeState>[
          IslandMapThemeState(themes: themes, theme: theme),
        ],
      );
    });
  });
}
