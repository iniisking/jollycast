import 'dart:convert';
import 'package:jollycast/config/api_endpoints.dart';
import 'package:jollycast/core/model/auth/login_model.dart';
import 'package:jollycast/core/services/api_service.dart';
import 'package:jollycast/utils/error_parser.dart';
import 'package:jollycast/utils/logger.dart';

class AuthService {
  // Login method
  static Future<LogInRes> login(LogInReq loginReq) async {
    try {
      final response = await ApiService.post(
        ApiEndpoints.login,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(loginReq.toJson()),
        encoding: utf8,
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Login successful');
        return _parseLoginResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error('Login failed', 'Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse login response
  static LogInRes _parseLoginResponse(Map<String, dynamic> json) {
    return LogInRes(
      message: json['message'] as String,
      data: Data(
        user: _parseUser(json['data']['user'] as Map<String, dynamic>),
        subscription: _parseSubscription(
          json['data']['subscription'] as Map<String, dynamic>,
        ),
        token: json['data']['token'] as String,
      ),
    );
  }

  // Parse user from JSON
  static User _parseUser(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      jollyEmail: json['jolly_email'] as String,
      country: json['country'] as String,
      personalizations: (json['personalizations'] as List)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Parse subscription from JSON
  static Subscription _parseSubscription(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      userIdString: json['userId'] as String,
      effectiveTime: DateTime.parse(json['effectiveTime'] as String),
      expiryTime: DateTime.parse(json['expiryTime'] as String),
      updateTime: DateTime.parse(json['updateTime'] as String),
      isOTC: json['isOTC'] as String,
      productId: json['productId'] as String,
      serviceId: json['serviceId'] as String,
      spId: json['spId'] as String,
      statusCode: json['statusCode'] as String,
      chargeMode: json['chargeMode'],
      chargeNumber: json['chargeNumber'],
      referenceId: json['referenceId'],
      details: _parseDetails(json['details'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Parse details from JSON
  static Details _parseDetails(Map<String, dynamic> json) {
    return Details(
      id: json['id'] as int,
      code: json['code'] as String,
      title: json['title'] as String,
      amount: json['amount'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

