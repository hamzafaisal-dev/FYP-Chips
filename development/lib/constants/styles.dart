import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldStyles {
  static InputDecoration textFormFieldDecoration(
    String labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BuildContext context,
  ) {
    return InputDecoration(
      //
      filled: true,

      fillColor: Theme.of(context).colorScheme.surface,

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
          color: Theme.of(context).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5.w,
          color: Theme.of(context).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      prefixIcon: prefixIcon,

      prefixIconConstraints: prefixIcon != null
          ? BoxConstraints.tightFor(width: 52.w)
          : BoxConstraints.tightFor(width: 12.w),

      suffixIcon: suffixIcon,

      labelText: labelText,

      labelStyle: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        fontSize: 16.0.sp,
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
