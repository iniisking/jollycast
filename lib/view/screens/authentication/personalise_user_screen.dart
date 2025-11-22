import 'package:flutter/material.dart';
import '../../../gen/assets.gen.dart';

class PersonaliseUserScreen extends StatelessWidget {
  const PersonaliseUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Assets.images.accountSetUpBackground.image(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
          SafeArea(child: Container()),
        ],
      ),
    );
  }
}
