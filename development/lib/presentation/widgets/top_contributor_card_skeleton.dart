import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TopContributorCardSkeleton extends StatelessWidget {
  const TopContributorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.4, 0.36],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // avatar
                Container(
                  padding: EdgeInsets.fromLTRB(35.w, 0.h, 35.w, 0.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 6),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const ClipOval(),
                    ),
                  ),
                ),

                // name
                Padding(
                  padding: EdgeInsets.only(top: 0.h, bottom: 7),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width: 70,
                      color: Colors.white,
                    ),
                  ),
                ),

                // contribution count
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
