import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  // GET request
  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(url);
      final finalUri = queryParameters != null
          ? uri.replace(
              queryParameters: queryParameters.map(
                (key, value) => MapEntry(key, value.toString()),
              ),
            )
          : uri;

      final response = await http
          .get(finalUri, headers: headers)
          .timeout(_timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  static Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final response = await http
          .put(Uri.parse(url), headers: headers, body: body, encoding: encoding)
          .timeout(_timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request
  static Future<http.Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse(url),
            headers: headers,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  static Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Status code helpers
  static bool isSuccess(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  static bool isClientError(int statusCode) {
    return statusCode >= 400 && statusCode < 500;
  }

  static bool isServerError(int statusCode) {
    return statusCode >= 500 && statusCode < 600;
  }

  static bool isError(int statusCode) {
    return statusCode >= 400;
  }

  // Common status codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusAccepted = 202;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusMethodNotAllowed = 405;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  static const int statusBadGateway = 502;
  static const int statusServiceUnavailable = 503;
  static const int statusGatewayTimeout = 504;
}
