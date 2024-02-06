import 'package:flutter/material.dart';

class CustomFilledButtonTheme {
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0XFFFDA758),
      foregroundColor: const Color(0XFF573353),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
    ),
  );
}
