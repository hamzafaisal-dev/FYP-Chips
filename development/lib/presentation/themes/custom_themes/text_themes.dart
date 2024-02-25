import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'KlasikRegular',
      fontWeight: FontWeight.w400,
      fontSize: 32.sp,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'KlasikRegular',
      fontWeight: FontWeight.w400,
      fontSize: 28.sp,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'KlasikRegular',
      fontWeight: FontWeight.w400,
      fontSize: 24.sp,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
    ),
    bodySmall: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
    ),

    // for the filled button
    labelLarge: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w700,
      fontSize: 16.sp,
    ),
    labelMedium: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
    ),
    labelSmall: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w700,
      fontSize: 12.sp,
    ),

    // other can be added as needed
  );
}
