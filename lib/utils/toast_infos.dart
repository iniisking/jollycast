import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jollycast/view/widgets/color.dart';

toastInfo({
  required String msg,
  Color? backgroundColor,
  Color textColor = Colors.white,
}) {
  backgroundColor ??= primaryColor2;
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14,
  );
}

toastError({
  required String msg,
  Color? backgroundColor,
  Color textColor = Colors.white,
}) {
  backgroundColor ??= errorColor;
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14,
  );
}
