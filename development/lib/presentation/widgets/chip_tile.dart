import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/constants/custom_colors.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isLiked = false;
  late int _chipLikes;

  void _viewLikes() {
    NavigationService.routeToNamed(
      '/likes-screen',
      arguments: {"likedBy": widget.chipData.likedBy},
    );
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;

      String currentUserName = widget.currentUser.username;

      if (widget.chipData.likedBy.contains(currentUserName)) {
        _chipLikes -= 1;
        widget.chipData.likedBy.remove(currentUserName);
      } else {
        _chipLikes += 1;
        widget.chipData.likedBy.add(currentUserName);
      }
    });

    ChipModel updatedChip =
        widget.chipData.copyWith(likedBy: widget.chipData.likedBy);

    BlocProvider.of<ChipBloc>(context)
        .add(LikeChipEvent(likedChip: updatedChip.toMap()));
  }

  @override
  void initState() {
    _chipLikes = widget.chipData.likedBy.length;

    String currentUserName = widget.currentUser.username;

    if (widget.chipData.likedBy.contains(currentUserName)) {
      _isLiked = true;
    }

    super.initState();
  }

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
          padding: EdgeInsets.only(top: 12.h),
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
              // _buildDivider(),

              // Heart icon and post likes
              _buildLikes(),

              // Divider
              _buildDivider(),

              // Likes, Comments waghera
              _buildInteractions(),
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
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CircleAvatar(
            radius: 16.r,
            child: ClipOval(
              child: SvgPicture.network(
                widget.chipData.posterPicture,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        widget.chipData.jobTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  /// Builds the job description widget.
  Widget _buildJobDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 12.w, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Row(
            children: [
              //
              if (_chipLikes > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: _viewLikes,
                      child: Text(
                        'Liked by ${_chipLikes.toString()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),

              // show this only if deadline is in next 3 days
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  Helpers.formatExpiryDateString(
                      widget.chipData.deadline.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 4),

          Row(
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

  /// Builds the poop widget.
  Widget _buildInteractions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //
          SizedBox(
            height: 32.h,
            width: MediaQuery.of(context).size.width * 0.28,
            child: IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 9.h),
              onPressed: _toggleLike,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.thumb_up_rounded,
                size: 20,
                color: _isLiked
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),

          SizedBox(
            height: 32.h,
            width: MediaQuery.of(context).size.width * 0.28,
            child: IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 9.h),
              onPressed: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.comment_rounded, size: 20),
            ),
          ),

          SizedBox(
            height: 32.h,
            width: MediaQuery.of(context).size.width * 0.28,
            child: IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 9.h),
              onPressed: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.share_rounded, size: 20),
            ),
          )
        ],
      ),
    );
  }
}
