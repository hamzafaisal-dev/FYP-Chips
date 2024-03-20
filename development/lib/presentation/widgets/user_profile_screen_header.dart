import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/user_stat_section.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreenHeader extends StatelessWidget {
  const UserProfileScreenHeader({
    super.key,
    required UserModel? authenticatedUser,
  }) : _authenticatedUser = authenticatedUser;

  final UserModel? _authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Row(
              children: [
                // user avatar
                CircleAvatar(radius: 30.r),

                // user details
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        _authenticatedUser?.username ?? 'User',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),

                      // email
                      Text(
                        _authenticatedUser?.email ?? 'No email found',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                                  .withOpacity(0.5),
                            ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // edit profile button
                CustomIconButton(
                  iconSvgPath: AssetPaths.editIconPath,
                  iconWidth: 17.w,
                  iconHeight: 17.h,
                  onTap: () {
                    NavigationService.routeToNamed(
                      '/edit-profile',
                      arguments: {"name": _authenticatedUser!.name},
                    );
                  },
                ),
              ],
            ),
          ),

          //
          Divider(
            thickness: 1,
            height: 0.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // posted chips
              UserStatSection(
                statisticName: 'Posted Chips',
                statisticValue: _authenticatedUser?.postedChips.length ?? 0,
              ),

              // divider
              SizedBox(
                height: 70.73.h,
                child: VerticalDivider(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  thickness: 1,
                  width: 0,
                ),
              ),

              // saved chips
              UserStatSection(
                statisticName: 'Saved Chips',
                statisticValue: _authenticatedUser?.favoritedChips.length ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
