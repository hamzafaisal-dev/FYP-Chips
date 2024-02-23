import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBarButton extends StatelessWidget {
  const CustomAppBarButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final SvgPicture icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.1,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            radius: 22.r,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(22.r),
          radius: 22.r,
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 22.r,
            child: icon,
          ),
        ),
      ],
    );
  }
}
