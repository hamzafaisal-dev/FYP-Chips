extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^[a-zA-Z]+(\.[a-zA-Z]+)?(\.[0-9]+)?@khi\.iba\.edu\.pk$|^[a-zA-Z0-9._%+-]+@iba\.edu\.pk$',
    ).hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return length >= 6;
  }
}

extension NameValidator on String {
  bool isValidName() {
    return RegExp(r"^[a-zA-Z ]+$").hasMatch(this);
  }
}
