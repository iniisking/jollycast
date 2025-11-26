/// Exception thrown when authentication fails (401 Unauthorized)
class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => message;
}
