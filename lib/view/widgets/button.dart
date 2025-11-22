import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/color.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final Future<void> Function()? onTap;
  final Color color;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final double? width;
  final double? borderWidth;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.color = const Color(0xFF003334),
    this.height = 66,
    this.borderRadius = 32,
    this.borderColor = Colors.transparent,
    this.width,
    this.borderWidth,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          width: width ?? double.infinity,
          height: height.spMin,
          decoration: BoxDecoration(
            color: enabled ? color : greyColor,
            borderRadius: BorderRadius.circular(borderRadius.spMin),
          ),
          alignment: Alignment.center,
          child: text,
        ),
      ),
    );
  }
}
