import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/textfield.dart';
import 'package:jollycast/view/screens/authentication/personalise_user_screen.dart';
import '../../../gen/assets.gen.dart';

class CompleteAccountScreen extends StatefulWidget {
  final String phoneNumber;

  const CompleteAccountScreen({super.key, required this.phoneNumber});

  @override
  State<CompleteAccountScreen> createState() => _CompleteAccountScreenState();
}

class _CompleteAccountScreenState extends State<CompleteAccountScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the phone number field
    _phoneController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.accountSetUpBackground.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerRight,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.spMin),
              child: Column(
                children: [
                  SizedBox(height: 30.spMin),
                  Row(
                    children: [
                      Assets.images.logoOnboarding1.image(
                        height: 77.spMin,
                        width: 172.spMin,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.spMin),
                  Row(
                    children: [
                      CustomTextWidget(
                        text: 'Complete account setup',
                        fontSize: 28.spMin,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: 28.spMin),
                  // First name and Last name row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.spMin),
                              child: CustomTextWidget(
                                text: 'First name',
                                fontSize: 15.spMin,
                                color: offWhiteColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 12.spMin),
                            AuthTextFormField(
                              hintText: '',
                              controller: _firstNameController,
                              fontSize: 15,
                              hintTextColor: greyColor,
                              primaryBorderColor: offWhiteColor,
                              errorBorderColor: errorColor,
                              fillColor: darkGreyColor,
                              textColor: whiteColor,
                              fontWeight: FontWeight.w600,
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.spMin),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.spMin),
                              child: CustomTextWidget(
                                text: 'Last name',
                                fontSize: 15.spMin,
                                color: offWhiteColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 12.spMin),
                            AuthTextFormField(
                              hintText: '',
                              controller: _lastNameController,
                              fontSize: 15,
                              hintTextColor: greyColor,
                              primaryBorderColor: offWhiteColor,
                              errorBorderColor: errorColor,
                              fillColor: darkGreyColor,
                              textColor: whiteColor,
                              fontWeight: FontWeight.w600,
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.spMin),
                  // Phone number and Email address row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.spMin),
                              child: CustomTextWidget(
                                text: 'Phone number',
                                fontSize: 15.spMin,
                                color: offWhiteColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 12.spMin),
                            AuthTextFormField(
                              hintText: '',
                              controller: _phoneController,
                              fontSize: 15,
                              hintTextColor: greyColor,
                              primaryBorderColor: offWhiteColor,
                              errorBorderColor: errorColor,
                              keyboardType: TextInputType.phone,
                              fillColor: darkGreyColor,
                              textColor: whiteColor,
                              fontWeight: FontWeight.w600,
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.spMin),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.spMin),
                              child: CustomTextWidget(
                                text: 'Email address',
                                fontSize: 15.spMin,
                                color: offWhiteColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 12.spMin),
                            AuthTextFormField(
                              hintText: '',
                              controller: _emailController,
                              fontSize: 15,
                              hintTextColor: greyColor,
                              primaryBorderColor: offWhiteColor,
                              errorBorderColor: errorColor,
                              keyboardType: TextInputType.emailAddress,
                              fillColor: darkGreyColor,
                              textColor: whiteColor,
                              fontWeight: FontWeight.w600,
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.spMin),
                  // Password column (full width)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.spMin),
                        child: CustomTextWidget(
                          text: 'Create password',
                          fontSize: 15.spMin,
                          color: offWhiteColor,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 12.spMin),
                      AuthTextFormField(
                        hintText: '',
                        controller: _passwordController,
                        fontSize: 15,
                        hintTextColor: greyColor,
                        primaryBorderColor: offWhiteColor,
                        errorBorderColor: errorColor,
                        obscureText: true,
                        fillColor: darkGreyColor,
                        textColor: whiteColor,
                        fontWeight: FontWeight.w600,
                        borderWidth: 1,
                      ),
                    ],
                  ),

                  Spacer(),
                  CustomButton(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonaliseUserScreen(),
                        ),
                      );
                    },
                    text: CustomTextWidget(
                      text: 'Continue',
                      fontSize: 20,
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 35.spMin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
