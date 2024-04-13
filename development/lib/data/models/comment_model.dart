class CommentModel {
  String commentId;
  String commentMessage;
  DateTime createdAt;
  String posterName;
  String posterUserName;
  String posterProfilePicture;

  CommentModel({
    required this.commentId,
    required this.commentMessage,
    required this.createdAt,
    required this.posterName,
    required this.posterUserName,
    required this.posterProfilePicture,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      commentMessage: json['commentMessage'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      posterName: json['posterName'],
      posterUserName: json['posterUserName'],
      posterProfilePicture: json['posterProfilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentMessage': commentMessage,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'posterName': posterName,
      'posterUserName': posterUserName,
      'posterProfilePicture': posterProfilePicture,
    };
  }

  CommentModel copyWith({
    String? commentId,
    String? commentMessage,
    DateTime? createdAt,
    String? posterName,
    String? posterUserName,
    String? posterProfilePicture,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      commentMessage: commentMessage ?? this.commentMessage,
      createdAt: createdAt ?? this.createdAt,
      posterName: posterName ?? this.posterName,
      posterUserName: posterUserName ?? this.posterUserName,
      posterProfilePicture: posterProfilePicture ?? this.posterProfilePicture,
    );
  }
}
