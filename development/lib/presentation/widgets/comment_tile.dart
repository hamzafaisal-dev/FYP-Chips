import 'package:development/data/models/comment_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.yellow,
            child: ClipOval(
              child: SvgPicture.network(
                comment.posterProfilePicture,
                height: 60,
                width: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Container(
            width: MediaQuery.of(context).size.width - 83,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    Row(
                      children: [
                        //
                        Text(
                          comment.posterUserName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Text('@${comment.posterName}'),
                      ],
                    ),

                    Text(
                      Helpers.formatCommentTime(comment.createdAt.toString()),
                    ),
                  ],
                ),

                Text(comment.commentMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
