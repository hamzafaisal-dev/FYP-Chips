import 'package:development/constants/validators.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || !value.isValidEmail()) {
      return 'Enter a valid IBA email address';
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.length < 3 || !value.isValidName()) {
      return 'Enter a valid name';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Password should contain at least 6 characters';
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? otpValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Enter a valid OTP';
    }

    return null;
  }

  static String? chipValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value cannot be empty';
    }

    // if (!value.isValidEmail()) {
    //   return 'Invalid email format';
    // }

    // if (!value.isValidPhoneNumber()) {
    //   return 'Invalid phone number format';
    // }

    // if (!value.isValidLink()) {
    //   return 'Invalid URL format';
    // }

    if (!value.isValidEmail() &&
        !value.isValidPhoneNumber() &&
        !value.isValidLink()) {
      return 'Invalid input value';
    }

    return null;
  }
}
