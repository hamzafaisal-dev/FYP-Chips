import 'package:development/constants/validators.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || !value.isValidEmail()) {
      return 'Enter a valid IBA email address';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Password should contain at least 6 characters';
    }

    return null;
  }
}
