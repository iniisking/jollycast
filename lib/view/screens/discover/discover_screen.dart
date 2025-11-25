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
            SizedBox(height: 57.spMin),
            // Editor's pick section
            Padding(
              padding: EdgeInsets.only(left: 23.spMin, bottom: 16.spMin),
              child: Row(
                children: [
                  Assets.svg.purpleStar.svg(width: 27.spMin, height: 27.spMin),
                  SizedBox(width: 5.spMin),
                  CustomTextWidget(
                    text: "Editor's pick",
                    fontSize: 24,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
            ),
            SizedBox(height: 17.spMin),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.spMin),
              child: _buildEditorsPickCard(),
            ),
            SizedBox(height: 60.spMin),
            // Top jolly section
            Padding(
              padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: 'Top jolly',
                    fontSize: 24,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  Container(
                    width: 78.spMin,
                    height: 30.spMin,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18.spMin),
                      border: Border.all(color: whiteColor, width: 1.spMin),
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'See all',
                        fontSize: 13,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 23.spMin),
            // Top jolly cards row
            SizedBox(
              height: 237.spMin,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 14.spMin),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildTopJollyCard();
                },
              ),
            ),
            SizedBox(height: 32.spMin),
          ],
        ),
      ),
    );
  }

  Widget _buildTopJollyCard() {
    return Container(
      width: 185.spMin,
      height: 237.spMin,
      margin: EdgeInsets.only(right: 10.spMin),
      decoration: BoxDecoration(
        color: topJollyCardColor,
        borderRadius: BorderRadius.circular(12.spMin),
        border: Border.all(color: topJollyBorderColor, width: 1.spMin),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.spMin,
          top: 7.spMin,
          right: 7.spMin,
          bottom: 10.spMin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.spMin),
              child: Assets.images.topJollyImage.image(
                height: 133.spMin,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 7.spMin),
            // Title
            CustomTextWidget(
              text: 'The NDL Show',
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: 0),
            // Author
            CustomTextWidget(
              text: 'Nathaniel Bassey',
              fontSize: 13,
              color: greyTextColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 7.spMin),
            // Buttons row
            Row(
              children: [
                // Follow button
                Container(
                  width: 78.5.spMin,
                  height: 30.spMin,
                  decoration: BoxDecoration(
                    color: buttonGreyColor,
                    borderRadius: BorderRadius.circular(18.spMin),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svg.add.svg(
                          width: 18.spMin,
                          height: 18.spMin,
                          colorFilter: ColorFilter.mode(
                            greyTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.spMin),
                        CustomTextWidget(
                          text: 'Follow:',
                          fontSize: 13,
                          color: greyTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.spMin),
                // Share button
                Container(
                  width: 30.spMin,
                  height: 30.spMin,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: offWhiteColor, width: 1.spMin),
                  ),
                  child: Center(
                    child: Assets.svg.share.svg(
                      width: 12.spMin,
                      height: 12.spMin,
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
    );
  }

  Widget _buildEditorsPickCard() {
    return Container(
      height: 206.spMin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [editorsPickGradientStart, editorsPickGradientEnd],
          stops: const [0.4362, 0.9953],
        ),
        borderRadius: BorderRadius.circular(16.spMin),
      ),
      child: Row(
        children: [
          // Image with 7px padding all around
          Padding(
            padding: EdgeInsets.all(7.spMin),
            child: Container(
              width: 192.spMin,
              height: 192.spMin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.spMin),
                image: DecorationImage(
                  image: AssetImage(Assets.images.editorsPickImage.path),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  width: 48.spMin,
                  height: 48.spMin,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(color: whiteColor, width: 2.spMin),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: whiteColor,
                    size: 26.spMin,
                  ),
                ),
              ),
            ),
          ),
          // Column on the right
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 14.spMin,
                right: 7.spMin,
                bottom: 12.spMin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomTextWidget(
                    text: 'Reliable Takes on Africa...',
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 1.spMin),
                  // Author
                  CustomTextWidget(
                    text: 'By: Sema Nasi',
                    fontSize: 13,
                    color: greyTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 6.spMin),
                  // Description
                  CustomTextWidget(
                    text:
                        'A South African podcast that celebrates local art and music while fostering pivotal and timeless conversations surrounding socio-political issues that affect young...',
                    fontSize: 13,
                    color: descriptionTextColor,
                    fontWeight: FontWeight.w500,
                    maxLines: 5,
                  ),
                  SizedBox(height: 11.spMin),
                  // Row with buttons
                  Row(
                    children: [
                      // First button
                      Container(
                        width: 78.5.spMin,
                        height: 30.spMin,
                        decoration: BoxDecoration(
                          color: buttonGreyColor,
                          borderRadius: BorderRadius.circular(18.spMin),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6.spMin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.svg.add.svg(
                                width: 18.spMin,
                                height: 18.spMin,
                                colorFilter: ColorFilter.mode(
                                  greyTextColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 4.spMin),
                              CustomTextWidget(
                                text: 'Follow',
                                fontSize: 13,
                                color: greyTextColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10.spMin),
                      // Second button - Share button
                      Container(
                        width: 30.spMin,
                        height: 30.spMin,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: offWhiteColor,
                            width: 1.spMin,
                          ),
                        ),
                        child: Center(
                          child: Assets.svg.share.svg(
                            width: 12.spMin,
                            height: 12.spMin,
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
          ),
        ],
      ),
    );
  }
}
