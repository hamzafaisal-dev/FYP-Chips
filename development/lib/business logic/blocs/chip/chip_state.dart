import 'package:development/data/models/chip_model.dart';
import 'package:equatable/equatable.dart';
import 'package:development/data/models/user_model.dart';

abstract class ChipState extends Equatable {
  const ChipState([List props = const []]) : super();
}

// initial state
class ChipInitial extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipEmpty extends ChipState {
  @override
  List<Object?> get props => [];
}

class IndividualChipLoaded extends ChipState {
  final ChipModel? chip;

  IndividualChipLoaded({required this.chip});

  @override
  List<Object?> get props => [chip];
}

class ChipsLoaded extends ChipState {
  final List<ChipModel> chips;

  ChipsLoaded({required this.chips}) : super([chips]);

  @override
  List<Object?> get props => [chips];
}

class ChipsStreamLoaded extends ChipState {
  final List<ChipModel> chips;

  const ChipsStreamLoaded({required this.chips});

  @override
  List<Object?> get props => [chips];
}

class ChipAddSuccess extends ChipState {
  final UserModel updatedUser;

  const ChipAddSuccess({required this.updatedUser});

  @override
  List<Object?> get props => [];
}

class ChipEditSuccess extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipDeleteSuccess extends ChipState {
  final UserModel updatedUser;

  const ChipDeleteSuccess({required this.updatedUser});

  @override
  List<Object?> get props => [];
}

class ChipError extends ChipState {
  final String errorMsg;
  const ChipError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class ChipsLoading extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipCreatingState extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipEditingState extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipDeletingState extends ChipState {
  @override
  List<Object?> get props => [];
}

class UserPostedChipsLoading extends ChipState {
  @override
  List<Object?> get props => [];
}

class UserPostedChipsLoaded extends ChipState {
  final List<ChipModel> chips;

  const UserPostedChipsLoaded({required this.chips});

  @override
  List<Object?> get props => [chips];
}
