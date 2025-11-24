import 'package:flutter/material.dart';
import 'package:jollycast/view/widgets/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.actions, this.leading});

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blackColor3,
      elevation: 0,
      leading: leading,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
