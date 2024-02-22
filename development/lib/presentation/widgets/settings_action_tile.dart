import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsActionTile extends StatelessWidget {
  const SettingsActionTile({
    super.key,
    required this.title,
    this.subTitle,
    required this.leadingIcon,
    required this.trailingIcon,
    this.onTap,
  });

  final String title;
  final String? subTitle;
  final SvgPicture leadingIcon;
  final IconData trailingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //
      tileColor: Theme.of(context).colorScheme.surface,

      // adjusts padding according to subtitle availability
      contentPadding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0.r),
      ),

      leading: Container(
        height: 38.h,
        width: 38.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        child: SizedBox(
          height: 18.h,
          width: 18.w,
          child: Align(
            alignment: Alignment.center,
            child: leadingIcon,
          ),
        ),
      ),

      trailing: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.1.r,
            spreadRadius: 0.r,
          ),
        ]),
        child: SvgPicture.asset(
          'assets/images/icons/forward_arrow_icon.svg',
          width: 20.w,
          height: 20.h,
        ),
      ),

      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
      ),

      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.5),
                  ),
            )
          : null,

      onTap: onTap,
    );
  }
}
