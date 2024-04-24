import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/comment_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:uuid/uuid.dart';

class CommentNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createComment(
      String commentMessage, ChipModel chip, UserModel currentUser) async {
    String newCommentId = const Uuid().v4();

    CommentModel newComment = CommentModel(
      commentId: newCommentId,
      commentMessage: commentMessage,
      createdAt: DateTime.now(),
      posterName: currentUser.name,
      posterUserName: currentUser.username,
      posterProfilePicture: currentUser.profilePictureUrl,
    );

    List<String> chipComments = chip.comments;

    chipComments.add(newComment.commentId);

    ChipModel newChip = chip.copyWith(comments: chipComments);

    // update chip in firestore
    await FirebaseFirestore.instance
        .collection('chips')
        .doc(chip.chipId)
        .update(newChip.toMap());

    // create new comment in firestore
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(chip.chipId)
        .collection('comments')
        .doc(newCommentId)
        .set(newComment.toJson());

    // log event
    Helpers.logEvent(
      currentUser.userId,
      "post-comment",
      [newComment, currentUser, newChip],
    );

    return;
  }

  Stream<List<CommentModel>> getChipComments(ChipModel chip) {
    return _firestore
        .collection('comments')
        .doc(chip.chipId)
        .collection('comments')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (docSnapshot) => CommentModel.fromJson(docSnapshot.data()),
              )
              .toList(),
        );
  }
}
