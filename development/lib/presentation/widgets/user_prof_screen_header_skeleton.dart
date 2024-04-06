import 'package:development/constants/custom_colors.dart';
import 'package:development/my_flutter_app_icons.dart';
import 'package:development/presentation/widgets/user_stat_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileScreenHeaderSkeleton extends StatelessWidget {
  const UserProfileScreenHeaderSkeleton({
    super.key,
  });

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
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: CircleAvatar(radius: 25.r),
                ),

                // user details
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name

                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.h,
                          width: 100.w,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 9.h),

                      // email
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 10.h,
                          width: 180.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          // divider
          Divider(
            thickness: 1,
            height: 0.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // chips posted
              UserStatSection(
                statisticName: 'Chips Posted',
                statisticValue: 0,
                icon: CustomIcons.feedbackicon,
                iconColor: Theme.of(context).colorScheme.primary,
              ),

              // divider
              SizedBox(
                height: 70.73.h,
                child: VerticalDivider(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  thickness: 1,
                  width: 0.w,
                ),
              ),

              // bookmarks received
              const UserStatSection(
                statisticName: 'Bookmarks Received',
                statisticValue: 0,
                icon: CustomIcons.privacypolicyicon,
                iconColor: CustomColors.darkBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
