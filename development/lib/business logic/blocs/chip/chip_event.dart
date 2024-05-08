import 'package:development/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChipEvent extends Equatable {
  const ChipEvent([List props = const []]) : super();
}

class FetchChipByIdEvent extends ChipEvent {
  const FetchChipByIdEvent({required this.chipId});

  final String chipId;

  @override
  List<Object?> get props => [chipId];
}

class FetchChips extends ChipEvent {
  const FetchChips({required this.searchText}) : super();

  final String searchText;

  @override
  List<Object?> get props => [searchText];
}

class FetchChipsStream extends ChipEvent {
  const FetchChipsStream({required this.filters}) : super();

  final Map<String, dynamic> filters;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadChipEvent extends ChipEvent {
  final Map<String, dynamic> newChip;

  const UploadChipEvent({required this.newChip});

  @override
  List<Object?> get props => [newChip];
}

class EditChipEvent extends ChipEvent {
  final Map<String, dynamic> editedChip;

  const EditChipEvent({required this.editedChip});

  @override
  List<Object?> get props => [editedChip];
}

class LikeChipEvent extends ChipEvent {
  final UserModel currentUser;
  final Map<String, dynamic> likedChip;

  const LikeChipEvent({required this.likedChip, required this.currentUser});

  @override
  List<Object?> get props => [likedChip];
}

class DeleteChipEvent extends ChipEvent {
  final String chipId;
  final UserModel currentUser;

  const DeleteChipEvent({required this.chipId, required this.currentUser});

  @override
  List<Object?> get props => [chipId, currentUser];
}

class JustFetchChips extends ChipEvent {
  const JustFetchChips();

  @override
  List<Object?> get props => [];
}

class FetchUserPostedChips extends ChipEvent {
  String postedBy;

  FetchUserPostedChips({required this.postedBy});

  @override
  List<Object?> get props => [];
}
