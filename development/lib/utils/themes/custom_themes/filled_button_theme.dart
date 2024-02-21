import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButtonTheme {
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.maxFinite, 60.h),
      maximumSize: Size(double.maxFinite, 60.h),
      backgroundColor: const Color(0XFFFDA758),
      foregroundColor: const Color(0XFF573353),
      padding: EdgeInsets.symmetric(vertical: 18.h),
      textStyle: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
    ),
  );
}
