import 'package:development/business%20logic/cubits/comment/comment_cubit.dart';
import 'package:development/business%20logic/cubits/comment/comment_state.dart';
import 'package:development/business%20logic/cubits/notification/notification_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({
    super.key,
    required this.commentController,
    this.chipData,
    required this.authenticatedUser,
    this.commentAutoFocused,
  });

  final TextEditingController commentController;
  final ChipModel? chipData;
  final UserModel authenticatedUser;
  final bool? commentAutoFocused;

  void _handleCommentSubmit(BuildContext context) {
    if (commentController.text != '' && chipData != null) {
      FocusScope.of(context).unfocus();

      BlocProvider.of<CommentCubit>(context).createComment(
        commentController.text,
        chipData!,
        authenticatedUser,
      );

      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chipData == null) {
      return const SizedBox.shrink();
    }

    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentSuccessState) {
          BlocProvider.of<NotificationCubit>(context).createNotificationEvent(
            'comment',
            chipData!,
            authenticatedUser,
          );
        }
      },
      child: Material(
        elevation: 20,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.yellow,
                  child: ClipOval(
                    child: SvgPicture.network(
                      authenticatedUser.profilePictureUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  width: MediaQuery.of(context).size.width * 0.74,
                  padding: const EdgeInsets.only(top: 6),
                  child: TextField(
                    controller: commentController,
                    autofocus: commentAutoFocused ?? false,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Leave a comment...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 2,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                ),

                // generate comment button
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    onPressed: () => _handleCommentSubmit(context),
                    icon: const Icon(Icons.send),
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
