import 'dart:io';

import 'package:development/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChipEvent extends Equatable {
  const ChipEvent([List props = const []]) : super();
}

class FetchChips extends ChipEvent {
  const FetchChips() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchChipsStream extends ChipEvent {
  const FetchChipsStream() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadChipEvent extends ChipEvent {
  final Map<String, dynamic> newChip;

  const UploadChipEvent({required this.newChip});

  @override
  List<Object?> get props => [newChip];
}

class DeleteChipEvent extends ChipEvent {
  final String chipId;
  final UserModel currentUser;

  const DeleteChipEvent({required this.chipId, required this.currentUser});

  @override
  List<Object?> get props => throw UnimplementedError();
}
