import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.spMin,
      decoration: BoxDecoration(
        color: blackColor4,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Assets.svg.discover.svg(
              width: 24.spMin,
              height: 24.spMin,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? whiteColor : lightGreyColor2,
                BlendMode.srcIn,
              ),
            ),
            label: 'Discover',
            index: 0,
          ),
          _buildNavItem(
            icon: Assets.svg.category.svg(
              width: 24.spMin,
              height: 24.spMin,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? whiteColor : lightGreyColor2,
                BlendMode.srcIn,
              ),
            ),
            label: 'Categories',
            index: 1,
          ),
          _buildNavItem(
            icon: Assets.svg.library.svg(
              width: 24.spMin,
              height: 24.spMin,
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? whiteColor : lightGreyColor2,
                BlendMode.srcIn,
              ),
            ),
            label: 'Your Library',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 4.spMin),
          CustomTextWidget(
            text: label,
            fontSize: 14.spMin,
            color: isSelected ? whiteColor : lightGreyColor2,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
          SizedBox(height: 10.spMin),
        ],
      ),
    );
  }
}
