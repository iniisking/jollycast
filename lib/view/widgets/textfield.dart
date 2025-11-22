import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/color.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int fontSize;
  final Color hintTextColor;
  final Color primaryBorderColor;
  final Color errorBorderColor;
  final Color? fillColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? borderWidth;
  final bool readOnly;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final int? maxLength;

  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
    required this.fontSize,
    required this.hintTextColor,
    required this.primaryBorderColor,
    required this.errorBorderColor,
    this.fillColor,
    this.textColor,
    this.fontWeight,
    this.borderWidth,
    this.readOnly = false,
    this.enabled = true,
    this.autofillHints,
    this.maxLength,
  });

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.spMin),
      borderSide: BorderSide(color: color, width: (borderWidth ?? 2).spMin),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66.spMin,
      child: TextFormField(
        autofillHints: autofillHints,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        readOnly: readOnly,
        enabled: enabled,
        cursorColor: primaryColor,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        style: TextStyle(
          fontSize: fontSize.toDouble().spMin,
          color: textColor,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
            fontSize: fontSize.toDouble().spMin,
            letterSpacing: 0.spMin,
            overflow: TextOverflow.ellipsis,
          ),
          filled: true,
          fillColor: fillColor ?? whiteColor,
          isDense: true,
          contentPadding: EdgeInsets.all(22.spMin),
          focusedBorder: _buildBorder(primaryBorderColor),
          focusedErrorBorder: _buildBorder(errorBorderColor),
          enabledBorder: _buildBorder(primaryBorderColor),
          errorBorder: _buildBorder(errorBorderColor),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counterText: '',
        ),
      ),
    );
  }
}
