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
            SizedBox(height: 50.spMin),
            // Newest episodes section
            Padding(
              padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: 'Newest episodes',
                    fontSize: 24,
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  Container(
                    width: 101.spMin,
                    height: 30.spMin,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18.spMin),
                      border: Border.all(color: whiteColor, width: 1.spMin),
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'Shuffle play',
                        fontSize: 13,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 17.spMin),
            // Newest episodes horizontal scroll
            SizedBox(
              height: 510.spMin,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 12.spMin),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 22.spMin),
                    child: SizedBox(
                      width: 300.spMin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(5, (rowIndex) {
                          final itemNumber = (index * 5 + rowIndex + 1)
                              .toString()
                              .padLeft(2, '0');
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: rowIndex < 4 ? 21.spMin : 0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Number text
                                CustomTextWidget(
                                  text: itemNumber,
                                  fontSize: 15,
                                  color: greyTextColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(width: 6.spMin),
                                // Image container with play button
                                Container(
                                  width: 79.spMin,
                                  height: 79.79798126220703.spMin,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      5.spMin,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        Assets.images.cardImage1.path,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 35.54999923706055.spMin,
                                      height: 35.90909194946289.spMin,
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
                                        size: 20.spMin,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7.spMin),
                                // Text column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextWidget(
                                        text: 'Caleb Maru: Navigating Afric...',
                                        fontSize: 15,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      SizedBox(height: 2.spMin),
                                      CustomTextWidget(
                                        text:
                                            'In this episode of the Change Africa Podcast, we host Tarek Mougani...',
                                        fontSize: 13,
                                        color: descriptionTextColor,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 7.spMin),
                                      CustomTextWidget(
                                        text: '20 June, 23 - 30 minutes',
                                        fontSize: 13,
                                        color: greyTextColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40.spMin),
            // See all button
            Center(
              child: Container(
                width: 238.spMin,
                height: 48.spMin,
                decoration: BoxDecoration(
                  color: buttonGreyColor,
                  borderRadius: BorderRadius.circular(22.spMin),
                ),
                child: Center(
                  child: CustomTextWidget(
                    text: 'See all',
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 58.spMin),
            // Mixed by interest & categories
            Padding(
              padding: EdgeInsets.only(left: 21.spMin),
              child: CustomTextWidget(
                text: 'Mixed by interest & categories',
                fontSize: 24,
                color: whiteColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 14.spMin),
            // Mixed by interest & categories grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.spMin),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.spMin,
                  mainAxisSpacing: 15.spMin,
                  childAspectRatio: 190 / 221.5,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: topJollyCardColor,
                      borderRadius: BorderRadius.circular(12.spMin),
                      border: Border.all(
                        color: topJollyBorderColor,
                        width: 1.spMin,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 9.spMin,
                        right: 9.spMin,
                        top: 11.spMin,
                        bottom: 8.spMin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image grid container
                          Container(
                            width: 173.spMin,
                            height: 158.2318115234375.spMin,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.spMin),
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 86.5 / 79.11585235595703,
                                  ),
                              itemCount: 4,
                              itemBuilder: (context, imgIndex) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(3.spMin),
                                  child: Assets.images.cardImage1.image(
                                    width: 86.5.spMin,
                                    height: 79.11585235595703.spMin,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 12.spMin),
                          // Category text
                          CustomTextWidget(
                            text: '#Artandculture',
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40.spMin),
            // Show all button
            Center(
              child: Container(
                width: 238.spMin,
                height: 48.spMin,
                decoration: BoxDecoration(
                  color: buttonGreyColor,
                  borderRadius: BorderRadius.circular(22.spMin),
                ),
                child: Center(
                  child: CustomTextWidget(
                    text: 'Show all',
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 76.spMin),
            // Handpicked for you section
            Padding(
              padding: EdgeInsets.only(left: 23.spMin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.images.fire.image(width: 27.spMin, height: 36.spMin),
                  SizedBox(width: 6.spMin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Handpicked for you',
                        fontSize: 24,
                        color: whiteColor,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(height: 3.spMin),
                      CustomTextWidget(
                        text: "Podcasts you'd love",
                        fontSize: 18,
                        color: greyTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.spMin),
            // Handpicked containers list
            Column(
              children: List.generate(3, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                  child: Container(
                    width: 382.spMin,
                    height: 500.spMin,
                    margin: EdgeInsets.only(bottom: index < 2 ? 20.spMin : 0),
                    decoration: BoxDecoration(
                      color: topJollyCardColor,
                      borderRadius: BorderRadius.circular(12.spMin),
                      border: Border.all(
                        color: topJollyBorderColor,
                        width: 1.spMin,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 57.spMin,
                        right: 48.5.spMin,
                        top: 37.spMin,
                        bottom: 8.spMin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image container
                          Container(
                            width: 278.spMin,
                            height: 237.spMin,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.spMin),
                              image: DecorationImage(
                                image: AssetImage(
                                  Assets.images.cardImage1.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 11.spMin),
                          // Title
                          CustomTextWidget(
                            text: 'The NDL Show',
                            fontSize: 18,
                            color: whiteColor,
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 0),
                          // Author
                          CustomTextWidget(
                            text: 'By: Nathan Bassey',
                            fontSize: 14,
                            color: greyTextColor,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 9.spMin),
                          // Description
                          CustomTextWidget(
                            text:
                                'A South African podcast that celebrates local art and music while fostering pivotal and timeless conversations surrounding socio-political issues that affect young adults.',
                            fontSize: 14,
                            color: descriptionTextColor,
                            fontWeight: FontWeight.w500,
                            maxLines: 4,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 21.spMin),
                          // Buttons row with episodes text
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
                                        text: 'Follow',
                                        fontSize: 13,
                                        color: greyTextColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 13.spMin),
                              // Play button
                              Container(
                                width: 78.5.spMin,
                                height: 30.spMin,
                                decoration: BoxDecoration(
                                  color: playButtonGreen,
                                  borderRadius: BorderRadius.circular(18.spMin),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(6.spMin),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.svg.playIcon.svg(
                                        width: 18.spMin,
                                        height: 18.spMin,
                                        colorFilter: ColorFilter.mode(
                                          whiteColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: 4.spMin),
                                      CustomTextWidget(
                                        text: 'Play',
                                        fontSize: 13,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 26.spMin),
                              // Episodes count
                              CustomTextWidget(
                                text: '28 Episodes',
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 88.spMin),
            // Hashtag tags
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.spMin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#relationship'),
                      _buildHashtagTag('#engagement'),
                    ],
                  ),
                  SizedBox(height: 26.spMin),
                  // Row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#football'),
                      _buildHashtagTag('#football'),
                      _buildHashtagTag('#football'),
                    ],
                  ),
                  SizedBox(height: 26.spMin),
                  // Row 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#relationship'),
                      _buildHashtagTag('#engagement'),
                    ],
                  ),
                  SizedBox(height: 26.spMin),
                  // Row 4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#relationship'),
                      _buildHashtagTag('#engagement'),
                    ],
                  ),
                  SizedBox(height: 26.spMin),
                  // Row 5
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#football'),
                      _buildHashtagTag('#football'),
                      _buildHashtagTag('#football'),
                    ],
                  ),
                  SizedBox(height: 26.spMin),
                  // Row 6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHashtagTag('#relationship'),
                      _buildHashtagTag('#engagement'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.spMin),
          ],
        ),
      ),
    );
  }

  Widget _buildHashtagTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.spMin, vertical: 8.spMin),
      decoration: BoxDecoration(
        color: hashtagBackgroundColor,
        borderRadius: BorderRadius.circular(20.spMin),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            offset: Offset(0, 0),
            blurRadius: 20.spMin,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontFamily: 'Euclid Circular A',
          fontWeight: FontWeight.w600,
          fontSize: 16.spMin,
          height: 1.0,
          letterSpacing: 0,
          color: whiteColor,
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
