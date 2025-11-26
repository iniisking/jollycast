import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/screens/player/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerController>(
      builder: (context, audioController, child) {
        final episode = audioController.currentEpisode;
        if (episode == null) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (_, animation, __) => FadeTransition(
                  opacity: animation,
                  child: PlayerScreen(episode: episode),
                ),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation =
                      Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        ),
                      );
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Container(
            height: 70.spMin,
            decoration: BoxDecoration(
              color: darkGreyColor,
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
              ),
            ),
            child: Row(
              children: [
                // Episode image
                Padding(
                  padding: EdgeInsets.all(8.spMin),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.spMin),
                    child: CachedNetworkImage(
                      imageUrl: episode.pictureUrl,
                      width: 54.spMin,
                      height: 54.spMin,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 54.spMin,
                        height: 54.spMin,
                        color: blackColor3,
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 54.spMin,
                        height: 54.spMin,
                        color: blackColor3,
                        child: Icon(
                          Icons.music_note,
                          color: whiteColor,
                          size: 24.spMin,
                        ),
                      ),
                    ),
                  ),
                ),
                // Episode info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: episode.title.length > 30
                            ? '${episode.title.substring(0, 30)}...'
                            : episode.title,
                        fontSize: 14,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                      ),
                      SizedBox(height: 2.spMin),
                      CustomTextWidget(
                        text: episode.podcast.author,
                        fontSize: 12,
                        color: greyTextColor,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // Play/Pause button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.spMin),
                  child: GestureDetector(
                    onTap: () {
                      audioController.togglePlayPause();
                    },
                    child: Container(
                      width: 40.spMin,
                      height: 40.spMin,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        audioController.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: whiteColor,
                        size: 20.spMin,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
