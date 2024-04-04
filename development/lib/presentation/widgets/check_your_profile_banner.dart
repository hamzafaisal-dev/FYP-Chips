import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckYourProfileBanner extends StatelessWidget {
  const CheckYourProfileBanner({
    super.key,
    required UserModel? authenticatedUser,
  }) : _authenticatedUser = authenticatedUser;

  final UserModel? _authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background
        Container(
          height: 146.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: SvgPicture.asset(
                AssetPaths.settingsScreenBannerPath,
                width: 133.w,
                height: 129.69.h,
              ),
            ),
          ),
        ),

        // column containing the text and button
        Positioned(
          top: 20.0.h,
          left: 33.0.w,
          child: SizedBox(
            width: 234.w,
            height: 106.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // check your profile text
                Text(
                  "Check Your Profile",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0.sp,
                      ),
                ),

                // email
                Text(
                  _authenticatedUser?.email ?? 'No email found',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.5),
                      ),
                ),

                const Spacer(),

                // view button
                SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: FilledButton(
                    onPressed: () =>
                        NavigationService.routeToNamed("/user_profile"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
