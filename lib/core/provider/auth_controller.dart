import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:jollycast/core/model/auth/login_model.dart';
import 'package:jollycast/core/services/auth_service.dart';
import 'package:jollycast/core/services/storage_service.dart';
import 'package:jollycast/utils/toast_infos.dart';
import 'package:jollycast/utils/error_parser.dart';
import 'package:jollycast/utils/logger.dart';

class AuthController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  bool _isRestoringSession = true;
  LogInRes? _loginResponse;
  String? _token;
  User? _currentUser;

  bool get isLoading => _isLoading;
  LogInRes? get loginResponse => _loginResponse;
  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null && _currentUser != null;
  bool get isRestoringSession => _isRestoringSession;

  AuthController() {
    _restoreSession();
  }

  // Login method
  Future<bool> login(String phoneNumber, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      AppLogger.info('Attempting login for phone: $phoneNumber');
      final loginReq = LogInReq(phoneNumber: phoneNumber, password: password);

      _loginResponse = await AuthService.login(loginReq);
      _token = _loginResponse!.data.token;
      _currentUser = _loginResponse!.data.user;
      if (_token != null) {
        final previewLen = math.min(6, _token!.length);
        final preview = _token!.substring(0, previewLen);
        AppLogger.info(
          'Received token (${_token!.length} chars). Preview: $preview***',
        );
      }
      await _persistSession();

      _isLoading = false;
      notifyListeners();

      AppLogger.info('Login successful for user: ${_currentUser?.phoneNumber}');
      toastInfo(msg: _loginResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Login failed', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    _loginResponse = null;
    _token = null;
    _currentUser = null;
    await Future.wait([
      _storageService.deleteToken(),
      _storageService.deleteUser(),
    ]);
    toastInfo(msg: 'Logged out successfully.');
    notifyListeners();
  }

  // Clear error state
  void clearError() {
    notifyListeners();
  }

  Future<void> _persistSession() async {
    if (_token == null || _currentUser == null) return;
    await Future.wait([
      _storageService.saveToken(_token!),
      _storageService.saveUser(_currentUser!),
    ]);
    AppLogger.info('Persisted session to storage.');
  }

  Future<void> _restoreSession() async {
    try {
      final storedToken = await _storageService.readToken();
      final storedUser = await _storageService.readUser();
      if (storedToken != null && storedUser != null) {
        _token = storedToken;
        _currentUser = storedUser;
        AppLogger.info(
          'Restored session for user: ${_currentUser?.phoneNumber}',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to restore session', e, stackTrace);
    } finally {
      _isRestoringSession = false;
      notifyListeners();
    }
  }
}
