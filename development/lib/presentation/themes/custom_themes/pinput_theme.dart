import 'package:development/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class PinputTheme {
  static PinTheme pinTheme = PinTheme(
    width: 45.w,
    height: 45.h,
    textStyle: TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    ),
    decoration: BoxDecoration(
      color: CustomColors.lightYellow,
      borderRadius: BorderRadius.circular(12.r),
    ),
  );
}
