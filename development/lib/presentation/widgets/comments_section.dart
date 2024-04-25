import 'package:development/business%20logic/cubits/comment/comment_cubit.dart';
import 'package:development/business%20logic/cubits/comment/comment_state.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/presentation/widgets/comment_tile.dart';
import 'package:development/presentation/widgets/comment_tile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key, required this.chip});

  final ChipModel chip;

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  @override
  void initState() {
    BlocProvider.of<CommentCubit>(context).fetchCommentsStream(widget.chip);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Text(
          'Comments',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 23.sp),
        ),

        SizedBox(height: 10.h),

        BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            print(state);

            if (state is CommentsStreamLoaded) {
              return StreamBuilder(
                stream: state.comments,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 40.h),
                              child: Transform.scale(
                                scale: 2,
                                child: Lottie.asset(
                                  AssetPaths.ghostEmptyAnimationPath,
                                  frameRate: FrameRate.max,
                                  width: 120.w,
                                ),
                              ),
                            ),
                            const Text('Be the first to leave a comment!'),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        //
                        ...snapshot.data!
                            .map((comment) => CommentTile(comment: comment)),
                      ],
                    );
                  }

                  return const CommentTileSkeleton();
                },
              );
            }

            return const CommentTileSkeleton();
          },
        ),
      ],
    );
  }
}
