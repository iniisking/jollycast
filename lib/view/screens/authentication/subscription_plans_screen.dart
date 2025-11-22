import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/screens/main/main_screen.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor3,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.spMin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.spMin),
                  Assets.images.logoOnboarding1.image(
                    height: 40.spMin,
                    width: 90.spMin,
                  ),
                  SizedBox(height: 28.spMin),
                  CustomTextWidget(
                    text: 'Enjoy unlimited podcasts',
                    fontSize: 26.spMin,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 27.spMin),
                  SubscriptionCard(
                    planName: 'Daily Jolly Plan',
                    price: '₦ 100',
                  ),
                  SizedBox(height: 19.spMin),
                  SubscriptionCard(
                    planName: 'Weekly Jolly Plan',
                    price: '₦ 200',
                  ),
                  SizedBox(height: 19.spMin),
                  SubscriptionCard(
                    planName: 'Monthly Jolly Plan',
                    price: '₦ 500',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final String price;

  const SubscriptionCard({
    super.key,
    required this.planName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 383.spMin,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.spMin),
        image: DecorationImage(
          image: Assets.images.accountSetUpBackground.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.spMin,
          right: 16.spMin,
          top: 24.spMin,
          bottom: 24.spMin,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Assets.images.headphone.image(
                  height: 50.spMin,
                  width: 50.spMin,
                ),
              ],
            ),
            SizedBox(height: 12.spMin),
            Row(
              children: [
                CustomTextWidget(
                  text: planName,
                  fontSize: 28.spMin,
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  price,
                  style: GoogleFonts.outfit(
                    fontSize: 35.spMin,
                    color: darkerGreyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.spMin),
            Row(
              children: [
                CustomTextWidget(
                  text:
                      'Enjoy unlimited podcast for 24 hours.\nYou can cancel at anytime.',
                  fontSize: 17.spMin,
                  color: lightGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 36.spMin),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(initialIndex: 0),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 23.spMin,
                      vertical: 16.spMin,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreyColor2,
                      borderRadius: BorderRadius.circular(32.spMin),
                    ),
                    child: CustomTextWidget(
                      text: 'One-time',
                      fontSize: 18.spMin,
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 16.spMin),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(initialIndex: 0),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 23.spMin,
                      vertical: 16.spMin,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreyColor2,
                      borderRadius: BorderRadius.circular(32.spMin),
                    ),
                    child: CustomTextWidget(
                      text: 'Auto-renewal',
                      fontSize: 18.spMin,
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
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
}
