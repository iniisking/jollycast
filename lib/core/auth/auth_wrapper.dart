import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/provider/auth_controller.dart';
import 'package:jollycast/core/services/connectivity_service.dart';
import 'package:jollycast/core/services/api_service.dart';
import 'package:jollycast/view/screens/authentication/login_screen.dart';
import 'package:jollycast/view/screens/main/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ApiService with ConnectivityService
    final connectivityService = Provider.of<ConnectivityService>(
      context,
      listen: false,
    );
    ApiService.setConnectivityService(connectivityService);

    return Consumer<AuthController>(
      builder: (context, authController, child) {
        if (authController.isRestoringSession) {
          return const _SplashScreen();
        }
        if (authController.isAuthenticated) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash screen jolly.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
