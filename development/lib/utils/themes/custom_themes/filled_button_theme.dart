import 'package:flutter/material.dart';

class CustomFilledButtonTheme {
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0XFFFDA758),
      foregroundColor: const Color(0XFF573353),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
    ),
  );
}
