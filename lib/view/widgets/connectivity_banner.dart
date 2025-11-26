import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/services/connectivity_service.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, connectivityService, child) {
        // Only show banner when offline
        if (connectivityService.isOffline) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16.spMin,
                vertical: 12.spMin,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    color: whiteColor,
                    size: 20.spMin,
                  ),
                  SizedBox(width: 8.spMin),
                  CustomTextWidget(
                    text: 'No Internet Connection',
                    fontSize: 14,
                    color: whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          );
        }

        // Return empty container with zero height when online
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: const SizedBox.shrink(),
        );
      },
    );
  }
}
