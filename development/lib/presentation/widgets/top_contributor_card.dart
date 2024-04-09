import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TopContributorCard extends StatelessWidget {
  const TopContributorCard({
    super.key,
    required UserModel? authenticatedUser,
  }) : _authenticatedUser = authenticatedUser;

  final UserModel? _authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.5.h),
          child: Column(
            children: [
              // avatar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.5.w,
                ),
                child: CircleAvatar(
                  radius: 32.5.r,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: ClipOval(
                    child: SvgPicture.network(
                      _authenticatedUser!.profilePictureUrl,
                      height: double.maxFinite,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // name
              Padding(
                padding: EdgeInsets.only(top: 6.25.h),
                child: Text(
                  _authenticatedUser?.name ?? 'User',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
