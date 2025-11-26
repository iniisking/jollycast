import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:jollycast/utils/toast_infos.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _periodicCheckTimer;
  ConnectivityStatus _status = ConnectivityStatus.online;
  bool _isInitialized = false;

  ConnectivityStatus get status => _status;
  bool get isOnline => _status == ConnectivityStatus.online;
  bool get isOffline => _status == ConnectivityStatus.offline;

  ConnectivityService() {
    _init();
  }

  Future<void> _init() async {
    if (_isInitialized) return;

    try {
      // Check initial connectivity status
      final initialResults = await _connectivity.checkConnectivity();
      _updateStatus(initialResults, isInitialCheck: true);

      // Listen to connectivity changes
      _subscription = _connectivity.onConnectivityChanged.listen(
        (List<ConnectivityResult> results) {
          if (kDebugMode) {
            print('ConnectivityService: Stream event received: $results');
          }
          _updateStatus(results);
        },
        onError: (error) {
          // Handle stream errors gracefully (e.g., MissingPluginException)
          if (kDebugMode) {
            print('ConnectivityService: Stream error: $error');
          }
          // Re-check connectivity when stream error occurs
          checkConnectivity();
        },
        cancelOnError: false,
      );

      // Periodic check as backup - critical for Android where stream doesn't always fire
      // Check every 1.5 seconds to catch reconnection quickly
      _periodicCheckTimer = Timer.periodic(const Duration(milliseconds: 1500), (
        _,
      ) {
        if (kDebugMode) {
          print('ConnectivityService: Periodic check triggered');
        }
        checkConnectivity();
      });
    } catch (e) {
      // Handle MissingPluginException gracefully (e.g., during hot reload)
      // Default to online to allow API calls to proceed
      _status = ConnectivityStatus.online;
      if (kDebugMode) {
        print(
          'ConnectivityService: Plugin not available, defaulting to online. Error: $e',
        );
      }
    }

    _isInitialized = true;
  }

  Future<void> checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (kDebugMode) {
        print('ConnectivityService: Manual check result: $results');
      }
      _updateStatus(results);
    } catch (e) {
      // If check fails (e.g., MissingPluginException), don't change status
      if (kDebugMode) {
        print('ConnectivityService: Failed to check connectivity. Error: $e');
      }
    }
  }

  void _updateStatus(
    List<ConnectivityResult> results, {
    bool isInitialCheck = false,
  }) {
    final previousStatus = _status;

    // Handle empty results list (can happen on Android)
    if (results.isEmpty) {
      if (kDebugMode) {
        print('ConnectivityService: Empty results list, assuming offline');
      }
      final newStatus = ConnectivityStatus.offline;
      if (previousStatus != newStatus && !isInitialCheck) {
        _status = newStatus;
        notifyListeners();
        toastError(msg: 'No Internet Connection');
      }
      return;
    }

    // Simplified check - just see if we have any connection type (not none)
    // This matches the pattern from the user's other project
    final hasConnection = results.any(
      (result) => result != ConnectivityResult.none,
    );

    final newStatus = hasConnection
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;

    // Only update and notify if status actually changed
    if (previousStatus != newStatus) {
      _status = newStatus;

      if (kDebugMode) {
        print(
          'ConnectivityService: Status changed from $previousStatus to $newStatus (results: $results)',
        );
      }

      // Show toast notifications for connectivity changes
      // Only show toast if not initial check (to avoid showing on app startup)
      if (!isInitialCheck) {
        if (newStatus == ConnectivityStatus.online &&
            previousStatus == ConnectivityStatus.offline) {
          // Only show "restored" toast when transitioning from offline to online
          if (kDebugMode) {
            print(
              'ConnectivityService: Showing "Internet Connection Restored" toast',
            );
          }
          toastInfo(msg: 'Internet Connection Restored');
        } else if (newStatus == ConnectivityStatus.offline &&
            previousStatus == ConnectivityStatus.online) {
          // Only show "offline" toast when transitioning from online to offline
          if (kDebugMode) {
            print(
              'ConnectivityService: Showing "No Internet Connection" toast',
            );
          }
          toastError(msg: 'No Internet Connection');
        }
      }

      notifyListeners();
    } else {
      if (kDebugMode) {
        print(
          'ConnectivityService: Status unchanged (still $previousStatus, results: $results)',
        );
      }
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _periodicCheckTimer?.cancel();
    super.dispose();
  }
}
