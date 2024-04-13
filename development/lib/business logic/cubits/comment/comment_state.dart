import 'package:development/data/models/comment_model.dart';

sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentsStreamLoaded extends CommentState {
  final Stream<List<CommentModel>> comments;

  CommentsStreamLoaded({required this.comments});
}

// generic success class for comments
final class CommentSuccessState extends CommentState {}

// generic loading class for comments
final class CommentLoadingState extends CommentState {}

// generic error class for comments
final class CommentErrorState extends CommentState {
  final String errorMessage;

  CommentErrorState({required this.errorMessage});
}
