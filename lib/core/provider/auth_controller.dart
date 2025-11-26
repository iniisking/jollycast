import 'package:flutter/foundation.dart';
import 'package:jollycast/core/model/auth/login_model.dart';
import 'package:jollycast/core/services/auth_service.dart';
import 'package:jollycast/utils/toast_infos.dart';
import 'package:jollycast/utils/error_parser.dart';
import 'package:jollycast/utils/logger.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  LogInRes? _loginResponse;
  String? _token;
  User? _currentUser;

  bool get isLoading => _isLoading;
  LogInRes? get loginResponse => _loginResponse;
  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null && _currentUser != null;

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
  void logout() {
    _loginResponse = null;
    _token = null;
    _currentUser = null;
    toastInfo(msg: 'Logged out successfully.');
    notifyListeners();
  }

  // Clear error state
  void clearError() {
    notifyListeners();
  }
}
