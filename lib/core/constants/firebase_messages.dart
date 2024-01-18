class FirebaseErrorMessages {
  static const String weakPassword = 'The provided password is too weak';
  static const String wrongPassword = 'The provided password is wrong';
  static const String emailAlreadyInUse =
      'The provided email is already associated with another account';
  static const String noUserFound = 'No user found for the given email';
  static const String invalidEmailFormat = 'Please provide a correct email';
  static const String googleSignInFail =
      'Failed to Sign in with a Google Account';

  static String extractFromErrorCode(String code) {
    return code.replaceAll('-', ' ').replaceAll('_', ' ');
  }
}
