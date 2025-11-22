import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class InterestTag extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const InterestTag({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.spMin, vertical: 9.spMin),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? darkGreyColor2 : darkerGreyColor,
            width: 1.spMin,
          ),
          color: isSelected ? darkGreyColor2 : offWhiteColor2,
          borderRadius: BorderRadius.circular(20.spMin),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextWidget(
              text: text,
              fontSize: 16,
              color: isSelected ? whiteColor : greyColor,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            SizedBox(width: 7.spMin),
            Icon(
              isSelected ? Icons.close : Icons.add,
              size: isSelected ? 20.spMin : 24.spMin,
              color: isSelected ? whiteColor : greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
