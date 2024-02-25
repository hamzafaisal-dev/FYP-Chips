import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldTheme {
  static InputDecoration lightTextFieldTheme(
      {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      //
      filled: true,

      fillColor: Colors.white,

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5.w,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5.w,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5.w,
          color: const Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5.w,
          color: const Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      errorStyle: const TextStyle(fontWeight: FontWeight.w600),

      prefixIcon: prefixIcon,

      suffixIcon: suffixIcon,
    );
  }
}
