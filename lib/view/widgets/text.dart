import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final double letterSpacing;
  final TextDecoration decoration;
  final Color decorationColor;

  const CustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.letterSpacing = 0.0,
    this.decoration = TextDecoration.none,
    this.decorationColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.nunito(
        fontSize: fontSize.toDouble().spMin,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing.spMin,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
