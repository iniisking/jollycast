import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class SeeAllButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;

  SeeAllButton({
    super.key,
    this.text = 'See all',
    this.onTap,
    this.width = 78,
    this.height = 30,
    this.fontSize = 13,
    Color? backgroundColor,
    Color? textColor,
  }) : backgroundColor = backgroundColor ?? Colors.transparent,
       textColor = textColor ?? whiteColor;

  SeeAllButton.large({
    super.key,
    this.text = 'See all',
    this.onTap,
    this.width = 238,
    this.height = 48,
    this.fontSize = 16,
    Color? backgroundColor,
    Color? textColor,
  }) : backgroundColor = backgroundColor ?? buttonGreyColor,
       textColor = textColor ?? whiteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.spMin,
        height: height.spMin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            height == 30 ? 18.spMin : 22.spMin,
          ),
          border: backgroundColor == Colors.transparent
              ? Border.all(color: whiteColor, width: 1.spMin)
              : null,
        ),
        child: Center(
          child: CustomTextWidget(
            text: text,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontSize == 13 ? FontWeight.w600 : FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
