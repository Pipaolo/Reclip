class AuthFailure {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'ERROR_INVALID_EMAIL':
        return "The email address is badly formatted.";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "The e-mail address in your Facebook/Google account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'ERROR_WRONG_PASSWORD':
        return "E-mail address or password is incorrect.";

      case 'ERROR_USER_NOT_FOUND':
        return 'User not found.';
      case 'ERROR_TOO_MANY_REQUESTS':
        return 'User has made too many requests, please try again later.';
      default:
        return "An error has occurred";
    }
  }
}
