import 'package:development/business%20logic/cubits/comment/comment_cubit.dart';
import 'package:development/business%20logic/cubits/comment/comment_state.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/presentation/widgets/comment_tile.dart';
import 'package:development/presentation/widgets/comment_tile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              .copyWith(fontSize: 22),
        ),

        const SizedBox(height: 10),

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
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Transform.scale(
                                scale: 2,
                                child: Lottie.asset(
                                  AssetPaths.ghostEmptyAnimationPath,
                                  frameRate: FrameRate.max,
                                  repeat: false,
                                  width: 120,
                                ),
                              ),
                            ),
                            const Text('Be the first to write a comment'),
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
