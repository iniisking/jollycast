import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jollycast/core/model/auth/login_model.dart';
import 'package:jollycast/utils/logger.dart';

class StorageService {
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _secureStorageAvailable = true;
  String? _memoryToken;
  String? _memoryUserJson;

  Future<void> saveToken(String token) async {
    await _trySecureWrite(
      () => _secureStorage.write(key: _tokenKey, value: token),
    );

    final prefs = await _getPrefs();
    if (prefs != null) {
      await prefs.setString(_tokenKey, token);
    } else {
      _memoryToken = token;
      AppLogger.info('Stored auth token in memory fallback.');
    }
  }

  Future<String?> readToken() async {
    final secureValue = await _trySecureRead(
      () => _secureStorage.read(key: _tokenKey),
    );
    if (secureValue != null) return secureValue;

    final prefs = await _getPrefs();
    if (prefs != null) {
      return prefs.getString(_tokenKey);
    }
    return _memoryToken;
  }

  Future<void> deleteToken() async {
    await _trySecureWrite(() => _secureStorage.delete(key: _tokenKey));
    final prefs = await _getPrefs();
    if (prefs != null) {
      await prefs.remove(_tokenKey);
    }
    _memoryToken = null;
  }

  Future<void> saveUser(User user) async {
    final data = jsonEncode(user.toJson());
    final prefs = await _getPrefs();
    if (prefs != null) {
      await prefs.setString(_userKey, data);
    } else {
      _memoryUserJson = data;
      AppLogger.info('Stored user profile in memory fallback.');
    }
  }

  Future<User?> readUser() async {
    final prefs = await _getPrefs();
    final jsonString = prefs != null
        ? prefs.getString(_userKey)
        : _memoryUserJson;
    if (jsonString == null) return null;
    return User.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  Future<void> deleteUser() async {
    final prefs = await _getPrefs();
    if (prefs != null) {
      await prefs.remove(_userKey);
    }
    _memoryUserJson = null;
  }

  Future<bool> _trySecureWrite(Future<void> Function() action) async {
    if (!_secureStorageAvailable) return false;
    try {
      await action();
      return true;
    } on MissingPluginException {
      _secureStorageAvailable = false;
      AppLogger.warning(
        'Secure storage write unavailable, falling back to prefs.',
      );
      return false;
    } on PlatformException catch (e) {
      if (e.code == 'missing_plugin') {
        _secureStorageAvailable = false;
        AppLogger.warning(
          'Secure storage plugin missing (${e.message}), using prefs fallback.',
        );
        return false;
      }
      rethrow;
    }
  }

  Future<T?> _trySecureRead<T>(Future<T?> Function() action) async {
    if (!_secureStorageAvailable) return null;
    try {
      return await action();
    } on MissingPluginException {
      _secureStorageAvailable = false;
      AppLogger.warning(
        'Secure storage read unavailable, falling back to prefs.',
      );
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'missing_plugin') {
        _secureStorageAvailable = false;
        AppLogger.warning(
          'Secure storage plugin missing (${e.message}), using prefs fallback.',
        );
        return null;
      }
      rethrow;
    }
  }

  Future<SharedPreferences?> _getPrefs() async {
    try {
      return await SharedPreferences.getInstance();
    } on MissingPluginException catch (e) {
      AppLogger.error(
        'SharedPreferences missing plugin',
        e,
        StackTrace.current,
      );
      return null;
    } on PlatformException catch (e, stack) {
      AppLogger.error('SharedPreferences platform error', e, stack);
      return null;
    }
  }
}
