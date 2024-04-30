extension EmailValidator on String {
  bool isValidIbaEmail() {
    return RegExp(
      r'^[a-zA-Z]+(\.[a-zA-Z]+)?(\.[0-9]+)?@khi\.iba\.edu\.pk$|^[a-zA-Z0-9._%+-]+@iba\.edu\.pk$',
    ).hasMatch(this);
  }
}

extension PhoneNumberValidator on String {
  bool isValidPhoneNumber() {
    return RegExp(
      r'^(\+92)?(03[0-9]{2})?[0-9]{7}$',
    ).hasMatch(this);
  }
}

// extension LinkValidator on String {
//   bool isValidLink() {
//     return Uri.parse(this).isAbsolute;
//   }
// }

extension LinkValidator on String {
  bool isValidLink() {
    final RegExp urlRegex = RegExp(
      r'^(?:(?:https?|ftp):\/\/)?'
      r'(?:www\.)?'
      r'[\w.-]+'
      r'\.[a-z]{2,}(?:\/\S*)?$',
      caseSensitive: false,
    );

    return urlRegex.hasMatch(this);
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
