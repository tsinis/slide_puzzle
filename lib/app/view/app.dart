// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefetch_web_to_memory.dart';
import '../../l10n/l10n.dart';
import '../../map/models/illustration_colors.dart';
import '../../puzzle/puzzle.dart';

/// Main app configuration
class App extends StatefulWidget {
  /// The path to local assets folder.
  static const localAssetsPrefix = 'assets/';

  /// The path to audio assets.
  static const audioAssets = [
    'assets/audio/shuffle.mp3',
    'assets/audio/click.mp3',
    'assets/audio/success.mp3',
    'assets/audio/move_tile.mp3',
  ];

  final ValueGetter<PlatformHelper> _platformHelperFactory;

  // ignore: public_member_api_docs
  const App({Key? key, ValueGetter<PlatformHelper>? platformHelperFactory})
      : _platformHelperFactory = platformHelperFactory ?? getPlatformHelper,
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final PlatformHelper _platformHelper;
  late final Timer _timer;

  @override
  // ignore: long-method
  void initState() {
    super.initState();

    _platformHelper = widget._platformHelperFactory();

    _timer = Timer(const Duration(milliseconds: 20), () {
      for (var i = 1; i <= 16; i++) {
        precachePicture(
          ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder,
            'assets/vectors/$i.svg',
          ),
          context,
        );
      }
      precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          'assets/vectors/prize.svg',
        ),
        context,
      );
      precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          'assets/vectors/windstar.svg',
        ),
        context,
      );

      if (kIsWeb) {
        for (final audio in App.audioAssets) {
          prefetchWebToMemory(audio, _platformHelper);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: IllustrationColors.seaColor,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: IllustrationColors.seaColor,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PuzzlePage(),
      );
}
