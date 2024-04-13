import 'package:bloc/bloc.dart';
import 'package:development/business%20logic/cubits/comment/comment_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/comment_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/comment_repository.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepository _commentRepository = CommentRepository();

  CommentCubit() : super(CommentInitial());

  // fetch chip comments stream
  void fetchCommentsStream(ChipModel chip) async {
    emit(CommentLoadingState());
    try {
      Stream<List<CommentModel>> commentStream =
          _commentRepository.getChipComments(chip);

      emit(CommentsStreamLoaded(comments: commentStream));
    } catch (error) {
      emit(CommentErrorState(errorMessage: error.toString()));
    }
  }

  void createComment(
      String commentMessage, ChipModel chip, UserModel currentUser) async {
    emit(CommentLoadingState());
    try {
      await _commentRepository.createComment(commentMessage, chip, currentUser);

      emit(CommentSuccessState());

      fetchCommentsStream(chip);
    } catch (error) {
      emit(CommentErrorState(errorMessage: error.toString()));
    }
  }
}
