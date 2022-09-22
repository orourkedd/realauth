class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class UserAlreadyExistsException implements Exception {
  UserAlreadyExistsException();
}