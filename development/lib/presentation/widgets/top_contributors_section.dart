import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/top_contributor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopContributorsSection extends StatelessWidget {
  const TopContributorsSection({
    super.key,
    required UserModel? authenticatedUser,
  }) : _authenticatedUser = authenticatedUser;

  final UserModel? _authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'This Week\'s Top Contributors',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'See All',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        //
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              9,
              (index) => Padding(
                padding:
                    index == 8 ? EdgeInsets.zero : EdgeInsets.only(right: 10.w),
                child:
                    TopContributorCard(authenticatedUser: _authenticatedUser),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
