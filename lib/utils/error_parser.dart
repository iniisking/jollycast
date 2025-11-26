import 'dart:convert';

class ErrorParser {
  /// Extracts a clean error message from various error formats
  static String extractErrorMessage(dynamic error, {String? defaultMessage}) {
    try {
      final errorString = error.toString();

      // Try to parse as JSON if it contains JSON-like structure
      if (errorString.contains('{') && errorString.contains('}')) {
        // Extract JSON part from error string
        final jsonStart = errorString.indexOf('{');
        final jsonEnd = errorString.lastIndexOf('}') + 1;
        if (jsonStart != -1 && jsonEnd > jsonStart) {
          final jsonString = errorString.substring(jsonStart, jsonEnd);
          try {
            final json = jsonDecode(jsonString) as Map<String, dynamic>;
            
            // Try common error message fields
            if (json.containsKey('message')) {
              return json['message'] as String;
            }
            if (json.containsKey('error')) {
              final errorValue = json['error'];
              if (errorValue is String) {
                return errorValue;
              }
              if (errorValue is Map && errorValue.containsKey('message')) {
                return errorValue['message'] as String;
              }
            }
            if (json.containsKey('Message')) {
              return json['Message'] as String;
            }
            if (json.containsKey('errors')) {
              final errors = json['errors'];
              if (errors is Map && errors.isNotEmpty) {
                final firstError = errors.values.first;
                if (firstError is List && firstError.isNotEmpty) {
                  return firstError.first as String;
                }
                if (firstError is String) {
                  return firstError;
                }
              }
            }
          } catch (e) {
            // If JSON parsing fails, continue to other methods
          }
        }
      }

      // Try to extract message from common error patterns
      final messageMatch = RegExp(r'[Mm]essage[:\s]+([^,\n}]+)').firstMatch(errorString);
      if (messageMatch != null) {
        return messageMatch.group(1)?.trim() ?? errorString;
      }

      // Remove common prefixes
      String cleanMessage = errorString
          .replaceAll(RegExp(r'^Exception:\s*'), '')
          .replaceAll(RegExp(r'^Error:\s*'), '')
          .replaceAll(RegExp(r'Login failed:\s*\d+\s*-\s*'), '')
          .replaceAll(RegExp(r'Failed to fetch.*?:\s*\d+\s*-\s*'), '');

      // If it's still too long or contains status codes, try to extract just the message part
      if (cleanMessage.length > 100 || cleanMessage.contains('404') || cleanMessage.contains('400')) {
        // Try to find a message after status code
        final statusPattern = RegExp(r'\d+\s*[-\s]*([^}]+)');
        final match = statusPattern.firstMatch(cleanMessage);
        if (match != null) {
          cleanMessage = match.group(1)?.trim() ?? cleanMessage;
        }
      }

      return cleanMessage.isNotEmpty ? cleanMessage : (defaultMessage ?? 'An error occurred');
    } catch (e) {
      return defaultMessage ?? 'An error occurred';
    }
  }

  /// Parses error response body and extracts message
  static String parseErrorResponse(String responseBody) {
    try {
      final json = jsonDecode(responseBody) as Map<String, dynamic>;
      
      if (json.containsKey('message')) {
        return json['message'] as String;
      }
      if (json.containsKey('error')) {
        final errorValue = json['error'];
        if (errorValue is String) {
          return errorValue;
        }
        if (errorValue is Map && errorValue.containsKey('message')) {
          return errorValue['message'] as String;
        }
      }
      if (json.containsKey('Message')) {
        return json['Message'] as String;
      }
      if (json.containsKey('errors')) {
        final errors = json['errors'];
        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first as String;
          }
          if (firstError is String) {
            return firstError;
          }
        }
      }
      
      return 'An error occurred';
    } catch (e) {
      return extractErrorMessage(responseBody);
    }
  }
}

