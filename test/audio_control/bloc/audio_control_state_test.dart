// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/audio_control/audio_control.dart';

void main() {
  group('AudioControlState', () {
    test('supports value comparisons', () {
      expect(AudioControlState(), equals(AudioControlState()));
      expect(AudioControlState(), isNot(AudioControlState(muted: true)));
    });
  });
}
