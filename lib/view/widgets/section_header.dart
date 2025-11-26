import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class SectionHeader extends StatelessWidget {
  final Widget icon;
  final String title;
  final EdgeInsets? padding;
  final double iconWidth;
  final double iconHeight;
  final double spacing;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.padding,
    this.iconWidth = 27,
    this.iconHeight = 36,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ??
          EdgeInsets.only(left: 23.spMin, top: 24.spMin, bottom: 17.spMin),
      child: Row(
        children: [
          SizedBox(
            width: iconWidth.spMin,
            height: iconHeight.spMin,
            child: icon,
          ),
          SizedBox(width: spacing.spMin),
          CustomTextWidget(
            text: title,
            fontSize: 24,
            color: whiteColor,
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}
