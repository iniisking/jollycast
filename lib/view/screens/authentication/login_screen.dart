import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/textfield.dart';
import 'package:jollycast/view/screens/authentication/register_phone_screen.dart';
import 'package:jollycast/view/screens/main/main_screen.dart';
import 'package:jollycast/core/provider/auth_controller.dart';
import '../../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get _isFormValid {
    final digitsOnly = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 11 && _passwordController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 11) {
      return "Enter exactly 11 digits";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
                            child: Column(
                              children: [
                                AuthTextFormField(
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
                                SizedBox(height: 20.spMin),
                                AuthTextFormField(
                                  hintText: 'Password',
                                  controller: _passwordController,
                                  fontSize: 16,
                                  hintTextColor: greyColor,
                                  primaryBorderColor: authBorderColor,
                                  errorBorderColor: errorColor,
                                  obscureText: _obscurePassword,
                                  validator: _validatePassword,
                                  textColor: blackColor,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: greyColor,
                                      size: 24.spMin,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.spMin),
                          Consumer<AuthController>(
                            builder: (context, authController, child) {
                              return CustomButton(
                                enabled:
                                    _isFormValid && !authController.isLoading,
                                onTap: _isFormValid && !authController.isLoading
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          final digitsOnly = _phoneController
                                              .text
                                              .replaceAll(RegExp(r'\D'), '');
                                          final success = await authController
                                              .login(
                                                digitsOnly,
                                                _passwordController.text,
                                              );
                                          if (success && context.mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainScreen(),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    : null,
                                text: CustomTextWidget(
                                  text: 'Login',
                                  fontSize: 20,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 17.spMin),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPhoneScreen(),
                                ),
                              );
                            },
                            child: RichText(
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
                                    text: "Don't have an account? ",
                                  ),
                                  TextSpan(
                                    text: 'Register',
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
