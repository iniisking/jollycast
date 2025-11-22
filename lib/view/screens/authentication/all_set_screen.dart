import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/screens/authentication/subscription_plans_screen.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.45, 1.0],
            colors: [Color(0xFF001010), Color(0xFF001010), Color(0xFF19AF48)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.spMin),
              Assets.images.logoOnboarding1.image(
                height: 40.spMin,
                width: 90.spMin,
              ),
              SizedBox(height: 55.spMin),
              Assets.svg.avatar1.svg(height: 73.spMin, width: 73.spMin),
              SizedBox(height: 16.spMin),
              CustomTextWidget(
                text: 'You’re all set Devon!',
                fontSize: 30.spMin,
                color: whiteColor,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: 29.spMin),
              CustomTextWidget(
                text:
                    'Subscribe to a plan to\nenjoy Jolly Premium.\nGet access to all audio\ncontents, personalize\nyour library to your\nstyle and do more cool\njolly stuff.',
                fontSize: 30.spMin,
                color: lightGreyColor,
                fontWeight: FontWeight.w600,
                maxLines: 7,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 52.spMin),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.spMin),
                child: CustomButton(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionPlansScreen(),
                      ),
                    );
                  },
                  text: CustomTextWidget(
                    text: 'See Plans',
                    fontSize: 20,
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.spMin),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.spMin,
                      color: lightGreyColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'By continuing, you verify that you are at\nleast 18 years old, and you agree with our\n',
                      ),
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                          color: blackColor2,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Refund policy',
                        style: TextStyle(
                          color: blackColor2,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.spMin),
            ],
          ),
        ),
      ),
    );
  }
}
