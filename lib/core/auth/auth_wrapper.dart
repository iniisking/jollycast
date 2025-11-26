import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/provider/auth_controller.dart';
import 'package:jollycast/view/screens/authentication/login_screen.dart';
import 'package:jollycast/view/screens/main/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) {
        if (authController.isAuthenticated) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
