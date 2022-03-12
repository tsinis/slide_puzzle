import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:window_size/src/window_size_channel.dart';

class SystemUI {
  final double _height;
  final WindowSizeChannel? _sizeChannel;
  final double _width;
  final double _windowsHeightCompensation;
  final String _windowTitle;

  const SystemUI({
    double height = 740,
    WindowSizeChannel? sizeChannel,
    double width = 577,
    double windowsHeightCompensation = 92,
    String windowTitle = 'Map Slide Puzzle',
  })  : _height = height,
        _sizeChannel = sizeChannel,
        _width = width,
        _windowsHeightCompensation = windowsHeightCompensation,
        _windowTitle = windowTitle;

  bool init() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      try {
        (_sizeChannel ?? WindowSizeChannel.instance)
          ..setWindowTitle(_windowTitle)
          ..setWindowMinSize(
            Size(
              _width,
              _height + (Platform.isWindows ? _windowsHeightCompensation : 0),
            ),
          );

        return true;
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {
        return false;
      }
    }

    return false;
  }
}
