import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../models/animated_foreground_widget.dart';
import 'balloon.dart';
import 'bridge.dart';
import 'crane.dart';
import 'gate.dart';
import 'lighthouse.dart';
import 'plane.dart';
import 'rainbow.dart';
import 'ski_tow.dart';
import 'smoke.dart';
import 'submarine.dart';
import 'telescope.dart';
import 'train.dart';
import 'web_rainbow.dart';
import 'whale.dart';
import 'wheel.dart';
import 'windmill.dart';

const foregrounds = <AnimatedForegroundWidget?>[
  Wheel(),
  SkiTow(),
  Gate(),
  Telescope(),
  Windmill(),
  Smoke(),
  Crane(),
  Plane(),
  Submarine(),
  Bridge(),
  Train(),
  if (kIsWeb) WebRainbow() else Rainbow(),
  Whale(),
  Lighthouse(),
  Balloon(),
  null,
];

const Color seaColor = Colors.teal;
