import 'package:development/data/models/chip_model.dart';
import 'package:development/presentation/widgets/bookmark_icon.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipTile extends StatefulWidget {
  const ChipTile({
    super.key,
    required this.chipData,
    this.onTap,
  });

  final ChipModel chipData;

  final void Function()? onTap;

  @override
  State<ChipTile> createState() => _ChipTileState();
}

class _ChipTileState extends State<ChipTile> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    print('build 1');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      // color: Colors.orange,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // user pfp + posted by + time
                  Row(
                    children: [
                      //

                      // user profile picture
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: CircleAvatar(
                          radius: 16.r,
                          child: const Icon(Icons.person_4_outlined),
                        ),
                      ),

                      // posted by + time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //

                          // posted by
                          Text(
                            widget.chipData.postedBy,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),

                          // time
                          Text(
                            Helpers.formatTimeAgo(
                                widget.chipData.createdAt.toString()),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // // bookmark icon
                  // CustomBookmarkIcon(
                  //   iconSize: 22,
                  //   chipId: widget.chipData.chipId,
                  // ),
                ],
              ),

              Divider(
                color: Theme.of(context).colorScheme.primaryContainer,
                thickness: 1,
              ),

              // job title
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  widget.chipData.jobTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // job description
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.chipData.description ?? 'No description available',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Divider(
                color: Theme.of(context).colorScheme.primaryContainer,
                thickness: 2,
              ),

              // heart icon + post likes
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // heart icon + post likes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //

                        // heart icon
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(width: 3),

                        // post likes count
                        const Text(
                          '3.1k',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
