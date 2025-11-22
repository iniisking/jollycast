import 'package:flutter/material.dart';
import 'package:jollycast/view/widgets/color.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor3,
      body: const Center(child: Text('Your Library Screen')),
    );
  }
}
