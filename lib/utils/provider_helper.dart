import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/provider/auth_controller.dart';
import 'package:jollycast/core/provider/episodes_controller.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/core/services/connectivity_service.dart';

/// Helper class to reduce boilerplate when accessing providers
class ProviderHelper {
  /// Get AuthController
  static AuthController auth(BuildContext context, {bool listen = false}) {
    return Provider.of<AuthController>(context, listen: listen);
  }

  /// Get EpisodesController
  static EpisodesController episodes(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<EpisodesController>(context, listen: listen);
  }

  /// Get AudioPlayerController
  static AudioPlayerController audio(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<AudioPlayerController>(context, listen: listen);
  }

  /// Get ConnectivityService
  static ConnectivityService connectivity(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<ConnectivityService>(context, listen: listen);
  }

  /// Get auth token
  static String? token(BuildContext context) {
    return auth(context).token;
  }
}
