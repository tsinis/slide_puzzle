// ignore: lines_longer_than_80_chars
// ignore_for_file: avoid_implementing_value_types, depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';
import 'package:map_slide_puzzle/helpers/helpers.dart';
import 'package:map_slide_puzzle/layout/layout.dart';
import 'package:map_slide_puzzle/map/island_map.dart';
import 'package:map_slide_puzzle/models/models.dart';
import 'package:map_slide_puzzle/puzzle/puzzle.dart';
import 'package:map_slide_puzzle/theme/theme.dart';
import 'package:map_slide_puzzle/timer/timer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

// ignore: prefer-match-file-name
class MockPuzzleTheme extends Mock implements PuzzleTheme {}

class MockIslandMapTheme extends Mock implements IslandMapTheme {}

class MockIslandMapThemeBloc
    extends MockBloc<IslandMapThemeEvent, IslandMapThemeState>
    implements IslandMapThemeBloc {}

class MockIslandMapPuzzleBloc
    extends MockBloc<IslandMapPuzzleEvent, IslandMapPuzzleState>
    implements IslandMapPuzzleBloc {}

class MockIslandMapPuzzleState extends Mock implements IslandMapPuzzleState {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}

class MockPuzzleEvent extends Mock implements PuzzleEvent {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockTimerState extends Mock implements TimerState {}

class MockPuzzle extends Mock implements Puzzle {}

class MockTile extends Mock implements Tile {}

class MockPuzzleLayoutDelegate extends Mock implements PuzzleLayoutDelegate {}

class MockTicker extends Mock implements Ticker {}

class MockUrlLauncher extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        UrlLauncherPlatform {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

class MockPlatformHelper extends Mock implements PlatformHelper {}

class MockAudioControlBloc
    extends MockBloc<AudioControlEvent, AudioControlState>
    implements AudioControlBloc {}
