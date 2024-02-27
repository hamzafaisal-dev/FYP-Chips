import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconSvgPath,
    required this.iconWidth,
    required this.iconHeight,
    required this.onTap,
    this.buttonRadius = 22,
  });

  final String iconSvgPath;
  final double iconWidth;
  final double iconHeight;
  final void Function()? onTap;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.1,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            radius: buttonRadius.r,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(63.r),
          radius: buttonRadius.r,
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: buttonRadius.r,
            child: InkWell(
              child: SvgPicture.asset(
                iconSvgPath,
                width: iconWidth.w,
                height: iconHeight.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
