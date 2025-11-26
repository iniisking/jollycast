import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/services/connectivity_service.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';

class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({super.key});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  bool _showOnlineMessage = false;
  bool _wasOffline = false;
  Timer? _onlineMessageTimer;

  @override
  void dispose() {
    _onlineMessageTimer?.cancel();
    super.dispose();
  }

  void _showOnlineBanner() {
    setState(() {
      _showOnlineMessage = true;
    });

    _onlineMessageTimer?.cancel();
    _onlineMessageTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showOnlineMessage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, connectivityService, child) {
        final isOffline = connectivityService.isOffline;

        // Show online message when connection is restored
        if (connectivityService.isOnline && _showOnlineMessage) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.spMin,
              vertical: 12.spMin,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
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
                Icon(Icons.wifi_rounded, color: whiteColor, size: 20.spMin),
                SizedBox(width: 8.spMin),
                CustomTextWidget(
                  text: 'Connection restored',
                  fontSize: 14,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          );
        }

        // Show offline message when connection is lost
        if (isOffline) {
          // Track that we were offline
          if (!_wasOffline) {
            _wasOffline = true;
            // Reset online message flag when going offline
            if (_showOnlineMessage) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _showOnlineMessage = false;
                });
              });
            }
          }

          return Container(
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
                Icon(Icons.wifi_off_rounded, color: whiteColor, size: 20.spMin),
                SizedBox(width: 8.spMin),
                CustomTextWidget(
                  text: 'No internet connection. Showing cached data.',
                  fontSize: 14,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          );
        }

        // When coming back online after being offline, show the online message
        if (connectivityService.isOnline &&
            _wasOffline &&
            !_showOnlineMessage) {
          _wasOffline = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showOnlineBanner();
          });
        }

        return const SizedBox.shrink();
      },
    );
  }
}
