import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/comment_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/comment_network.dart';

class CommentRepository {
  final CommentNetwork _commentNetwork = CommentNetwork();

  Future<void> createComment(
      String commentMessage, ChipModel chip, UserModel currentUser) async {
    await _commentNetwork.createComment(commentMessage, chip, currentUser);
  }

  Stream<List<CommentModel>> getChipComments(ChipModel chip) {
    return _commentNetwork.getChipComments(chip);
  }
}
