import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/top_contributor_card.dart';
import 'package:development/presentation/widgets/top_contributor_card_skeleton.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopContributorsSection extends StatelessWidget {
  const TopContributorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This Week\'s Top Contributors',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 19.sp,
                        ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            // color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            //
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is TopContributorsErrorState) {
                    HelperWidgets.showSnackbar(
                        context, state.errorMessage, 'error');
                  }
                },
                builder: (context, state) {
                  if (state is FetchingTopContributors) {
                    return Row(
                      children: List.generate(
                        9,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: const TopContributorCardSkeleton(),
                        ),
                      ),
                    );
                  } else if (state is TopContributorsLoadedState) {
                    return Row(
                      children: [
                        ...List.generate(
                          state.topContributors.length,
                          (index) {
                            Map<String, dynamic> topContributor =
                                state.topContributors[index];

                            return Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: TopContributorCard(
                                topContributor: topContributor,
                              ),
                            );
                          },
                        ),
                        // Add your additional widget here
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: TopContributorCardAlt(),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
