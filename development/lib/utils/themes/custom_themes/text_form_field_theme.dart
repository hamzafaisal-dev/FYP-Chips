import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  static InputDecoration lightTextFieldTheme({Widget? prefixIcon}) {
    return InputDecoration(
      //
      filled: true,

      fillColor: Colors.white,

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      errorStyle: const TextStyle(fontWeight: FontWeight.w600),

      prefixIcon: prefixIcon,
    );
  }
}
