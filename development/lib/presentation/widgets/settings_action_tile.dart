import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final IconData leadingIcon;
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
        height: 45.h,
        width: 45.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Icon(
          leadingIcon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      trailing: Icon(
        trailingIcon,
        size: 20,
      ),

      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            )
          : null,

      onTap: onTap,
    );
  }
}
