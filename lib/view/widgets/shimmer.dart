import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VideoLoadingShimmer extends StatelessWidget {
  const VideoLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );
  }
}
