import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const CustomCircularProgressIndicator({
    Key? key,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double finalWidth = width ?? 23.4;
    final double finalHeight = height ?? 23.4;

    return SizedBox(
      width: finalWidth.w,
      height: finalHeight.h,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
