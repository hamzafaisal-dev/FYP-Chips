import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbarTheme {
  static AppBarTheme lightAppbarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'ManropeRegular',
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0XFF573353),
    ),
  );
}
