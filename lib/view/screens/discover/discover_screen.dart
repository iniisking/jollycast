import 'package:flutter/material.dart';
import 'package:jollycast/view/widgets/color.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor3,
      body: const Center(child: Text('Discover Screen')),
    );
  }
}
