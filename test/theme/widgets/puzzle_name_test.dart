// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleName', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;

    const themeName = 'Name';

    setUp(() {
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      final themeState = MockThemeState();

      when(() => theme.name).thenReturn(themeName);
      when(() => themeState.theme).thenReturn(theme);
      when(() => themeBloc.state).thenReturn(themeState);
    });
  });
}
