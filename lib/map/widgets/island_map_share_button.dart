import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_control/audio_control.dart';
import '../../helpers/helpers.dart';
import '../../l10n/l10n.dart';
import '../../typography/typography.dart';

/// The url to share for this Flutter Puzzle challenge.
const _shareUrl = 'https://flutterhack.devpost.com/';

/// {@template island_map_twitter_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Twitter when tapped.
/// {@endtemplate}
// ignore: prefer-match-file-name
class IslandMapTwitterButton extends StatelessWidget {
  /// {@macro island_map_twitter_button}
  const IslandMapTwitterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IslandMapShareButton(
        title: 'Twitter',
        icon: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.white,
          size: 16,
        ),
        color: const Color(0xFF13B9FD),
        onPressed: () => openLink(_twitterShareUrl(context)),
      );

  String _twitterShareUrl(BuildContext context) {
    final shareText = context.l10n.islandMapSuccessShareText;
    final encodedShareText = Uri.encodeComponent(shareText);

    return 'https://twitter.com/intent/tweet?url=$_shareUrl&text=$encodedShareText';
  }
}

/// {@template island_map_facebook_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Facebook when tapped.
/// {@endtemplate}

// ignore: prefer-single-widget-per-file
class IslandMapFacebookButton extends StatelessWidget {
  /// {@macro island_map_facebook_button}
  const IslandMapFacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IslandMapShareButton(
        title: 'Facebook',
        icon: const FaIcon(
          FontAwesomeIcons.facebookF,
          color: Colors.white,
          size: 16,
        ),
        color: const Color(0xFF0468D7),
        onPressed: () => openLink(_facebookShareUrl(context)),
      );

  String _facebookShareUrl(BuildContext context) {
    final shareText = context.l10n.islandMapSuccessShareText;
    final encodedShareText = Uri.encodeComponent(shareText);

    return 'https://www.facebook.com/sharer.php?u=$_shareUrl&quote=$encodedShareText';
  }
}

/// {@template island_map_share_button}
/// Displays a share button colored with [color] which
/// displays the [icon] and [title] as its content.
/// {@endtemplate}
@visibleForTesting
// ignore: prefer-single-widget-per-file
class IslandMapShareButton extends StatefulWidget {
  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The title of this button.
  final String title;

  /// The icon of this button.
  final Widget icon;

  /// The color of this button.
  final Color color;

  final AudioPlayerFactory _audioPlayerFactory;

  /// {@macro island_map_share_button}
  const IslandMapShareButton({
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.color,
    AudioPlayerFactory? audioPlayer,
    Key? key,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  @override
  State<IslandMapShareButton> createState() => _IslandMapShareButtonState();
}

class _IslandMapShareButtonState extends State<IslandMapShareButton> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/click.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AudioControlListener(
        audioPlayer: _audioPlayer,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: widget.color),
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: widget.color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () async {
              widget.onPressed();
              unawaited(_audioPlayer.replay());
            },
            icon: Container(
              margin: const EdgeInsets.only(left: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
              width: 32,
              height: 32,
              child: widget.icon,
            ),
            label: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Text(
                widget.title,
                style: PuzzleTextStyle.headline5.copyWith(
                  color: widget.color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
}
