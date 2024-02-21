import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportSettingsActionTile extends StatelessWidget {
  const SupportSettingsActionTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    this.onTap,
  });

  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //
      tileColor: Theme.of(context).colorScheme.surface,

      // adjusts padding according to subtitle availability
      contentPadding: EdgeInsets.fromLTRB(
        6.w,
        6.h,
        20.w,
        6.h,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0.r),
      ),

      leading: Container(
        height: 38.h,
        width: 38.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: SizedBox(
          height: 18.h,
          width: 18.w,
          child: Icon(
            leadingIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),

      trailing: SizedBox(
        height: 10.h,
        width: 10.w,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            trailingIcon,
          ),
        ),
      ),

      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),

      onTap: onTap,
    );
  }
}
