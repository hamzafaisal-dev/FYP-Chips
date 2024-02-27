import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipTile extends StatefulWidget {
  const ChipTile({
    super.key,
    required this.postedBy,
    required this.jobTitle,
    required this.description,
  });

  final String postedBy;
  final String jobTitle;
  final String description;

  @override
  State<ChipTile> createState() => _ChipTileState();
}

class _ChipTileState extends State<ChipTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 10.h, left: 10.w),
            child: Row(
              children: [
                // user avatar
                CircleAvatar(
                  radius: 14.r,
                  child: const Icon(Icons.person_4_outlined),
                ),

                // user name + time
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // user name
                      Text(
                        widget.postedBy,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),

                      // time
                      Text(
                        '41m ago',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.5),
                            ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // bookmark button
                CustomIconButton(
                  iconSvgPath: AssetPaths.bookmarkIconPath,
                  iconWidth: 10.08.w,
                  iconHeight: 13.44.h,
                  buttonRadius: 16.r,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // preview image fetched from url
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: SizedBox(
              height: 165.h,
              width: double.maxFinite,
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // footer
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 5.h),
            child: Text(
              widget.jobTitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),

          // job description
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              widget.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.5),
                  ),
            ),
          ),

          Divider(thickness: 0.h),

          // engagement
          Padding(
            padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // favorite icon
                    SizedBox(
                      height: 14.h,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: InkWell(
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 3.w),

                    // post likes count
                    Text(
                      '3.1k',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
