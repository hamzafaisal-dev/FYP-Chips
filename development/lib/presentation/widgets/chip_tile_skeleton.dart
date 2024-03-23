import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ChipTileSkeleton extends StatelessWidget {
  const ChipTileSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row for user profile and posted info
              _buildUserInfoRow(),

              // Divider
              _buildDivider(),

              // Job title
              _buildJobTitle(),

              // Job description
              _buildJobDescription(),

              // Divider
              _buildDivider(),

              // Heart icon and post likes
              _buildLikes(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the row containing user profile and posted info.
  Widget _buildUserInfoRow() {
    return Row(
      children: [
        // User profile picture placeholder
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: CircleAvatar(
            radius: 16.r,
            backgroundColor: Colors.white,
          ),
        ),

        // Posted by and time placeholders
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.w,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(height: 4.h),
            Container(
              width: 80.w,
              height: 12.h,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the divider widget.
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1.8,
    );
  }

  /// Builds the job title widget.
  Widget _buildJobTitle() {
    return Container(
      width: 200.w,
      height: 16.h,
      color: Colors.white,
    );
  }

  /// Builds the job description widget.
  Widget _buildJobDescription() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: 200.w,
        height: 24.h,
        color: Colors.white,
      ),
    );
  }

  /// Builds the likes widget.
  Widget _buildLikes() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Heart icon and post likes count placeholders
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite,
                size: 16.sp,
                color: Colors.grey[400],
              ),
              SizedBox(width: 3.w),
              Container(
                width: 40.w,
                height: 16.h,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
