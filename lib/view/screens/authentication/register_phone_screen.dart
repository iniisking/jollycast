import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/textfield.dart';
import 'package:jollycast/view/screens/authentication/verify_phone_screen.dart';
import '../../../gen/assets.gen.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({super.key});

  @override
  State<RegisterPhoneScreen> createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  bool get _isFormValid {
    final digitsOnly = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 11;
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    setState(() {});
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    // Strict validation for exactly 11 digits
    if (digitsOnly.length != 11) {
      return "Enter exactly 11 digits";
    }
    return null;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Assets.images.onboardingImage1.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 28.spMin,
                        right: 28.spMin,
                        bottom: keyboardHeight > 0
                            ? keyboardHeight + 20.spMin
                            : 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.images.logoOnboarding1.image(
                            height: 108.spMin,
                            width: 242.spMin,
                          ),
                          SizedBox(height: 5.spMin),
                          CustomTextWidget(
                            text: 'PODCASTS FOR\nAFRICA, BY AFRICANS',
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 28.spMin),
                          Form(
                            key: _formKey,
                            child: AuthTextFormField(
                              hintText: 'Phone Number',
                              controller: _phoneController,
                              fontSize: 16,
                              hintTextColor: greyColor,
                              primaryBorderColor: authBorderColor,
                              errorBorderColor: errorColor,
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                              validator: _validatePhoneNumber,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  left: 22.spMin,
                                  top: 12.spMin,
                                  bottom: 12.spMin,
                                  right: 12.spMin,
                                ),
                                child: Assets.images.nigeriaFlagIcon.image(
                                  width: 24.spMin,
                                  height: 24.spMin,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.spMin),
                          CustomButton(
                            enabled: _isFormValid,
                            onTap: _isFormValid
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      final phoneNumber = _phoneController.text;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VerifyPhoneScreen(
                                                phoneNumber: phoneNumber,
                                              ),
                                        ),
                                      );
                                    }
                                  }
                                : null,
                            text: CustomTextWidget(
                              text: 'Continue',
                              fontSize: 20,
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 17.spMin),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Futura PT',
                                fontSize: 16.spMin,
                                color: whiteColor,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      'By proceeding, you agree and accept our ',
                                ),
                                TextSpan(
                                  text: 'T&C',
                                  style: TextStyle(
                                    fontFamily: 'Futura PT',
                                    fontSize: 16.spMin,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 55.spMin),
                          CustomTextWidget(
                            text: 'BECOME A PODCAST CREATOR',
                            fontSize: 18.spMin,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 47.spMin),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
