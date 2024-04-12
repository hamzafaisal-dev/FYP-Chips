import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButtonTheme {
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: Size(double.maxFinite, 60.h),
      maximumSize: Size(double.maxFinite, 60.h),
      backgroundColor: const Color(0XFFFDA758),
      foregroundColor: const Color(0XFF573353),
      textStyle: TextStyle(
        fontFamily: 'ManropeRegular',
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
  );
}
