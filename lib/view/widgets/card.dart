import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class TrendingCard extends StatelessWidget {
  final String imagePath;
  final String podcastName;
  final String episodeTitle;
  final String description;
  final VoidCallback? onPlay;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onShare;
  final VoidCallback? onAdd;

  const TrendingCard({
    super.key,
    required this.imagePath,
    required this.podcastName,
    required this.episodeTitle,
    required this.description,
    this.onPlay,
    this.onLike,
    this.onSave,
    this.onShare,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 283.spMin,
      height: 351.spMin,
      margin: EdgeInsets.only(right: 16.spMin),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.spMin)),
      child: Stack(
        children: [
          // Image fills entire card
          ClipRRect(
            borderRadius: BorderRadius.circular(12.spMin),
            child:
                imagePath.startsWith('http://') ||
                    imagePath.startsWith('https://')
                ? Image.network(
                    imagePath,
                    height: 351.spMin,
                    width: 283.spMin,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 351.spMin,
                        width: 283.spMin,
                        color: darkGreyColor,
                      );
                    },
                  )
                : Image.asset(
                    imagePath,
                    height: 351.spMin,
                    width: 283.spMin,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 351.spMin,
                        width: 283.spMin,
                        color: darkGreyColor,
                      );
                    },
                  ),
          ),
          // Gradient overlay at bottom
          Positioned(
            bottom: 40.spMin,
            left: 0,
            right: 0,
            child: Container(
              height: 340.spMin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.spMin),
                  bottomRight: Radius.circular(12.spMin),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    darkGreenColor,
                    darkGreenColor,
                    darkGreenColor.withOpacity(0.9),
                    darkGreenColor.withOpacity(0.7),
                    darkGreenColor.withOpacity(0.4),
                    darkGreenColor.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.2, 0.4, 0.6, 0.8, 0.95, 1.0],
                ),
              ),
            ),
          ),
          // Content column - starts 8px below play button container
          Positioned(
            top: 191.spMin,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Podcast name - left 14px
                Padding(
                  padding: EdgeInsets.only(left: 14.spMin),
                  child: CustomTextWidget(
                    text: podcastName,
                    fontSize: 13,
                    color: greyTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.spMin),
                // Episode title - 12px symmetric padding
                Padding(
                  padding: EdgeInsets.only(left: 12.spMin, right: 12.spMin),
                  child: CustomTextWidget(
                    text: episodeTitle,
                    fontSize: 18,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 1.spMin),
                // Description - left 13px, right 7px
                Padding(
                  padding: EdgeInsets.only(left: 13.spMin, right: 7.spMin),
                  child: CustomTextWidget(
                    text: description,
                    fontSize: 13,
                    color: descriptionTextColor,
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 10.spMin),
                // Action buttons row - left padding 13px
                Padding(
                  padding: EdgeInsets.only(left: 13.spMin),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildActionButton(
                        icon: Icons.favorite,
                        size: 18.spMin,
                        onTap: onLike,
                      ),
                      SizedBox(width: 10.spMin),
                      _buildActionButton(
                        svg: Assets.svg.save,
                        size: 18.spMin,
                        onTap: onSave,
                      ),
                      SizedBox(width: 10.spMin),
                      _buildActionButton(
                        svg: Assets.svg.share,
                        size: 18.spMin,
                        onTap: onShare,
                      ),
                      SizedBox(width: 10.spMin),
                      _buildActionButton(
                        svg: Assets.svg.add,
                        size: 18.spMin,
                        onTap: onAdd,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.spMin),
              ],
            ),
          ),
          // Play button container - 83px from top, 14px from left
          Positioned(
            top: 83.spMin,
            left: 14.spMin,
            child: GestureDetector(
              onTap: onPlay,
              child: Container(
                width: 100.spMin,
                height: 100.spMin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.spMin),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.spMin),
                  child: Stack(
                    children: [
                      // Background image
                      imagePath.startsWith('http://') ||
                              imagePath.startsWith('https://')
                          ? Image.network(
                              imagePath,
                              width: 100.spMin,
                              height: 100.spMin,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100.spMin,
                                  height: 100.spMin,
                                  color: darkGreyColor,
                                );
                              },
                            )
                          : Image.asset(
                              imagePath,
                              width: 100.spMin,
                              height: 100.spMin,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100.spMin,
                                  height: 100.spMin,
                                  color: darkGreyColor,
                                );
                              },
                            ),
                      // Centered play button
                      Center(
                        child: Container(
                          width: 45.spMin,
                          height: 45.spMin,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.7),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: whiteColor,
                              width: 2.spMin,
                            ),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: whiteColor,
                            size: 26.spMin,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    IconData? icon,
    SvgGenImage? svg,
    required double size,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43.spMin,
        height: 43.spMin,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: offWhiteColor, width: 1.spMin),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: whiteColor, size: size)
              : svg!.svg(
                  width: size,
                  height: size,
                  colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn),
                ),
        ),
      ),
    );
  }
}
