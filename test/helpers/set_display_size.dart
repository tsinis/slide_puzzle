import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_slide_puzzle/layout/layout.dart';

// ignore: prefer-match-file-name
extension PuzzleWidgetTester on WidgetTester {
  void setDisplaySize(Size size) {
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });
  }

  void setMediumDisplaySize() {
    setDisplaySize(const Size(PuzzleBreakpoints.medium, 1000));
  }

  void setSmallDisplaySize() {
    setDisplaySize(const Size(PuzzleBreakpoints.small, 1000));
  }
}
