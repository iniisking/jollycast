import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/appbar.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor3,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hot & trending episodes section
            Padding(
              padding: EdgeInsets.only(
                left: 23.spMin,
                top: 24.spMin,
                bottom: 17.spMin,
              ),
              child: Row(
                children: [
                  Assets.images.fire.image(width: 27.spMin, height: 36.spMin),
                  SizedBox(width: 8.spMin),
                  CustomTextWidget(
                    text: 'Hot & trending episodes',
                    fontSize: 24,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400.spMin,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TrendingCard(
                    imagePath: Assets.images.cardImage1.path,
                    podcastName: 'Change Africa Podcast',
                    episodeTitle: 'Caleb Maru: Navigating Afric...',
                    description:
                        'In this episode of the Change Africa Podcast, we host Tarek Mouganie, the multifaceted founder and CEO of Affinity Africa. The epi...',
                  );
                },
              ),
            ),
            SizedBox(height: 32.spMin),
            // Editor's pick section
            Padding(
              padding: EdgeInsets.only(left: 24.spMin, bottom: 16.spMin),
              child: Row(
                children: [
                  Assets.svg.purpleStar.svg(width: 20.spMin, height: 20.spMin),
                  SizedBox(width: 8.spMin),
                  CustomTextWidget(
                    text: "Editor's pick",
                    fontSize: 20,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.spMin),
              child: _buildEditorsPickCard(),
            ),
            SizedBox(height: 32.spMin),
          ],
        ),
      ),
    );
  }

  Widget _buildEditorsPickCard() {
    return Container(
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(16.spMin),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              Container(
                height: 200.spMin,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.spMin),
                    topRight: Radius.circular(16.spMin),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.image, color: whiteColor, size: 60.spMin),
                ),
              ),
              // Play button overlay
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 50.spMin,
                    height: 50.spMin,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: whiteColor,
                      size: 30.spMin,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content section
          Padding(
            padding: EdgeInsets.all(16.spMin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Reliable Takes on Africa...',
                  fontSize: 18,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.spMin),
                CustomTextWidget(
                  text: 'By: Sema Nasi',
                  fontSize: 14,
                  color: lightGreyColor2,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: 8.spMin),
                CustomTextWidget(
                  text:
                      'A South African podcast that celebrates local art and music while fostering pivotal and timeless conversations surrounding socio-political issues that affect young...',
                  fontSize: 14,
                  color: lightGreyColor2,
                  fontWeight: FontWeight.normal,
                  maxLines: 3,
                ),
                SizedBox(height: 16.spMin),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.spMin,
                        decoration: BoxDecoration(
                          color: darkGreyColor2,
                          borderRadius: BorderRadius.circular(8.spMin),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.svg.add.svg(
                              width: 18.spMin,
                              height: 18.spMin,
                              colorFilter: ColorFilter.mode(
                                whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8.spMin),
                            CustomTextWidget(
                              text: 'Follow',
                              fontSize: 14,
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.spMin),
                    Container(
                      width: 40.spMin,
                      height: 40.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor2,
                        borderRadius: BorderRadius.circular(8.spMin),
                      ),
                      child: Center(
                        child: Assets.svg.share.svg(
                          width: 18.spMin,
                          height: 18.spMin,
                          colorFilter: ColorFilter.mode(
                            whiteColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
