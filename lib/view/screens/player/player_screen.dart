import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/gen/assets.gen.dart';

class PlayerScreen extends StatefulWidget {
  final Episode episode;

  const PlayerScreen({super.key, required this.episode});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioPlayerController>().playEpisode(widget.episode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _PlayerBackground(),
          SafeArea(
            child: NotificationListener<OverscrollNotification>(
              onNotification: (notification) {
                final isAtTop =
                    notification.metrics.pixels <=
                    notification.metrics.minScrollExtent + 4;
                if (isAtTop && notification.overscroll < -12) {
                  Navigator.of(context).maybePop();
                  return true;
                }
                return false;
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(horizontal: 22.spMin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.spMin),
                    _CloseHandle(onClose: () => Navigator.of(context).pop()),
                    SizedBox(height: 35.spMin),
                    _Artwork(episode: widget.episode),
                    SizedBox(height: 30.spMin),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.spMin),
                      child: CustomTextWidget(
                        text: widget.episode.title,
                        fontSize: 18,
                        color: whiteColor,
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 12.spMin),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.spMin),
                      child: CustomTextWidget(
                        text: widget.episode.podcast.author,
                        fontSize: 16,
                        color: Colors.white.withOpacity(.85),
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 3.spMin),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.spMin),
                      child: CustomTextWidget(
                        text: widget.episode.description,
                        fontSize: 15,
                        color: const Color(0xFFCECECE),
                        fontWeight: FontWeight.w500,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 27.spMin),
                    _Progress(
                      position: audioController.position,
                      duration: audioController.duration,
                      onSeek: audioController.seekToFraction,
                    ),
                    SizedBox(height: 21.spMin),
                    _TransportControls(controller: audioController),
                    SizedBox(height: 34.spMin),
                    const _ActionGrid(),
                    SizedBox(height: 32.spMin),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/account set up background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black.withOpacity(0.65),
              Colors.black.withOpacity(0.35),
              Colors.black.withOpacity(0.65),
            ],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }
}

class _CloseHandle extends StatelessWidget {
  final VoidCallback onClose;

  const _CloseHandle({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        width: 43.spMin,
        height: 43.spMin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE4E4E4), width: 1.spMin),
        ),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: const Color(0xFFE4E4E4),
          size: 18.spMin,
        ),
      ),
    );
  }
}

class _Artwork extends StatelessWidget {
  final Episode episode;

  const _Artwork({required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 321.spMin,
      height: 321.spMin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.spMin),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.spMin),
        child: CachedNetworkImage(
          imageUrl: episode.pictureUrl,
          width: 321.spMin,
          height: 321.spMin,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Container(
            color: Colors.black26,
            alignment: Alignment.center,
            child: Icon(Icons.music_note, color: whiteColor, size: 42.spMin),
          ),
          placeholder: (_, __) => Container(
            color: Colors.black26,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: primaryColor),
          ),
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<double> onSeek;

  const _Progress({
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final progress = duration.inMilliseconds == 0
        ? 0.0
        : position.inMilliseconds / duration.inMilliseconds;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (details) =>
                  _handleSeek(details.localPosition.dx, constraints.maxWidth),
              onPanUpdate: (details) =>
                  _handleSeek(details.localPosition.dx, constraints.maxWidth),
              child: Container(
                height: 22.spMin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB9F89C), Color(0xFFE7E7E7)],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.5.spMin),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progress.clamp(0, 1),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFB9F89C), Color(0xFFE7E7E7)],
                            ),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(999),
                              right: Radius.circular(999),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.spMin, vertical: 6.spMin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timeLabel(_formatDuration(position)),
              _timeLabel(_formatDuration(duration)),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSeek(double dx, double maxWidth) {
    final ratio = (dx / maxWidth).clamp(0.0, 1.0).toDouble();
    onSeek(ratio);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  Widget _timeLabel(String text) {
    return CustomTextWidget(
      text: text,
      fontSize: 14,
      color: Colors.white70,
      fontWeight: FontWeight.w700,
    );
  }
}

class _TransportControls extends StatelessWidget {
  final AudioPlayerController controller;

  const _TransportControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconButton(
          Assets.svg.rewind,
          size: 28.spMin,
          onTap: () => controller.seekRelative(const Duration(seconds: -30)),
        ),
        SizedBox(width: 18.spMin),
        _iconButton(
          Assets.svg.rewind10Sec,
          size: 32.spMin,
          onTap: () => controller.seekRelative(const Duration(seconds: -10)),
        ),
        SizedBox(width: 18.spMin),
        _PlayButton(controller: controller),
        SizedBox(width: 18.spMin),
        _iconButton(
          Assets.svg.fastForward10Sec,
          size: 32.spMin,
          onTap: () => controller.seekRelative(const Duration(seconds: 10)),
        ),
        SizedBox(width: 18.spMin),
        _iconButton(
          Assets.svg.fastForward,
          size: 28.spMin,
          onTap: () => controller.seekRelative(const Duration(seconds: 30)),
        ),
      ],
    );
  }

  Widget _iconButton(
    SvgGenImage icon, {
    required double size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: icon.svg(
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final AudioPlayerController controller;

  const _PlayButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    final showPause = controller.isPlaying;

    return GestureDetector(
      onTap: controller.togglePlayPause,
      child: Container(
        width: 48.spMin,
        height: 48.spMin,
        decoration: BoxDecoration(
          color: const Color(0x9C20A726),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.spMin),
        ),
        child: Icon(
          showPause ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Colors.white,
          size: 30.spMin,
        ),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      ('Add to queue', Icons.queue_music),
      ('Save', Icons.favorite_border),
      ('Share episode', Icons.share_outlined),
      ('Add to playlist', Icons.playlist_add),
      ('Go to episode page', Icons.open_in_new),
    ];

    return Wrap(
      spacing: 12.spMin,
      runSpacing: 12.spMin,
      alignment: WrapAlignment.center,
      children: actions
          .map((action) => _GlassButton(label: action.$1, icon: action.$2))
          .toList(),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _GlassButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.spMin, vertical: 12.spMin),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(26.spMin),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: whiteColor, size: 18.spMin),
          SizedBox(width: 8.spMin),
          CustomTextWidget(
            text: label,
            fontSize: 15,
            color: whiteColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
