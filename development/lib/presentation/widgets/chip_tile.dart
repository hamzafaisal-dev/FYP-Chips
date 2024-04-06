import 'package:development/data/models/user_model.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/utils/helper_functions.dart';

/// Widget representing a tile displaying chip data.
class ChipTile extends StatefulWidget {
  const ChipTile({
    Key? key,
    required this.chipData,
    required this.currentUser,
    this.onTap,
  }) : super(key: key);

  /// The chip data to display.
  final ChipModel chipData;

  final UserModel currentUser;

  /// Callback function triggered when the tile is tapped.
  final void Function()? onTap;

  @override
  State<ChipTile> createState() => _ChipTileState();
}

class _ChipTileState extends State<ChipTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
        // User profile picture
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: CircleAvatar(
            radius: 16.r,
            child: Image.network(
              widget.currentUser.profilePictureUrl,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person_4_outlined);
              },
            ),
          ),
        ),

        // Posted by and time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            InkWell(
              onTap: () {
                NavigationService.routeToNamed('/user_profile', arguments: {
                  "postedBy": widget.chipData.postedBy,
                });
              },
              child: Text(
                widget.chipData.postedBy,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            Text(
              Helpers.formatTimeAgo(widget.chipData.createdAt.toString()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the divider widget.
  Widget _buildDivider() {
    return Divider(
      color: Theme.of(context).colorScheme.primaryContainer,
      thickness: 1.8,
    );
  }

  /// Builds the job title widget.
  Widget _buildJobTitle() {
    return Text(
      widget.chipData.jobTitle,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  /// Builds the job description widget.
  Widget _buildJobDescription() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        widget.chipData.description ?? 'No description available',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
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
          // Heart icon and post likes count
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //
              Icon(
                CupertinoIcons.heart_fill,
                size: 18.sp,
                color: Theme.of(context).colorScheme.primary,
              ),

              SizedBox(width: 3.w),

              Text(
                widget.chipData.favoritedBy.length.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
