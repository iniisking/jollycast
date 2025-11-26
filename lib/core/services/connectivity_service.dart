import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
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
      await checkConnectivity();

      // Listen to connectivity changes
      _subscription = _connectivity.onConnectivityChanged.listen(
        (List<ConnectivityResult> results) {
          _updateStatus(results);
        },
        onError: (error) {
          // Handle stream errors gracefully (e.g., MissingPluginException)
          if (kDebugMode) {
            print(
              'ConnectivityService: Stream error, defaulting to online. Error: $error',
            );
          }
          // Don't change status on stream error, keep current status
        },
        cancelOnError: false,
      );
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
      _updateStatus(results);
    } catch (e) {
      // If check fails (e.g., MissingPluginException), default to online
      // This allows the app to function during development/hot reload
      _status = ConnectivityStatus.online;
      if (kDebugMode) {
        print(
          'ConnectivityService: Failed to check connectivity, defaulting to online. Error: $e',
        );
      }
      notifyListeners();
    }
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final previousStatus = _status;

    // Check if any connection type is available
    final hasConnection = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn ||
          result == ConnectivityResult.other,
    );

    _status = hasConnection
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;

    // Only notify if status changed
    if (previousStatus != _status) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
