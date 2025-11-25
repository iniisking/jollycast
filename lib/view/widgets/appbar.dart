import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.actions, this.leading});

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.spMin),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: leading,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.spMin),
            child: SizedBox.shrink(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.images.logoOnboarding1.image(
              width: 90.spMin,
              height: 40.spMin,
            ),
            Container(
              height: 61.spMin,
              width: 161.spMin,
              decoration: BoxDecoration(
                color: darkGreyColor3.withOpacity(0.6),
                borderRadius: BorderRadius.circular(18.spMin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Assets.svg.avatar1.svg(
                    width: 45.spMin,
                    height: 45.spMin,
                  ),
                  Assets.svg.notification.svg(
                    width: 27.spMin,
                    height: 27.spMin,
                  ),
                  Assets.svg.search.svg(
                    width: 21.spMin,
                    height: 21.spMin,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 3.spMin + 8.spMin);
}
