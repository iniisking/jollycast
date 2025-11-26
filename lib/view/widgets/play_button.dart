import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/view/widgets/color.dart';

enum PlayButtonSize { small, medium, large }

class PlayButton extends StatelessWidget {
  final Episode episode;
  final VoidCallback? onTap;
  final PlayButtonSize size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderWidth;

  const PlayButton({
    super.key,
    required this.episode,
    this.onTap,
    this.size = PlayButtonSize.medium,
    this.backgroundColor,
    this.iconColor,
    this.borderWidth,
  });

  double get _buttonSize {
    switch (size) {
      case PlayButtonSize.small:
        return 35.55;
      case PlayButtonSize.medium:
        return 48;
      case PlayButtonSize.large:
        return 78.5;
    }
  }

  double get _iconSize {
    switch (size) {
      case PlayButtonSize.small:
        return 20;
      case PlayButtonSize.medium:
        return 26;
      case PlayButtonSize.large:
        return 22.31;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerController>(
      builder: (context, audioController, child) {
        final isPlaying =
            audioController.currentEpisode?.id == episode.id &&
            audioController.isPlaying;

        return GestureDetector(
          onTap:
              onTap ??
              () {
                if (audioController.currentEpisode?.id == episode.id) {
                  audioController.togglePlayPause();
                } else {
                  // This should be handled by parent widget
                  onTap?.call();
                }
              },
          child: Container(
            width: _buttonSize.spMin,
            height: size == PlayButtonSize.large ? 30.spMin : _buttonSize.spMin,
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  (size == PlayButtonSize.large
                      ? playButtonGreen
                      : primaryColor.withOpacity(0.7)),
              shape: size == PlayButtonSize.large
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              borderRadius: size == PlayButtonSize.large
                  ? BorderRadius.circular(18.spMin)
                  : null,
              border: size == PlayButtonSize.large
                  ? null
                  : Border.all(
                      color: whiteColor,
                      width: (borderWidth ?? 2).spMin,
                    ),
            ),
            child: size == PlayButtonSize.large
                ? Padding(
                    padding: EdgeInsets.all(6.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: iconColor ?? whiteColor,
                          size: _iconSize.spMin,
                        ),
                        SizedBox(width: 4.spMin),
                        Text(
                          isPlaying ? 'Pause' : 'Play',
                          style: TextStyle(
                            color: iconColor ?? whiteColor,
                            fontSize: 13.spMin,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                : Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: iconColor ?? whiteColor,
                    size: _iconSize.spMin,
                  ),
          ),
        );
      },
    );
  }
}
