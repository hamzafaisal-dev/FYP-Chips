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

class ChipsLoading extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipsStreamLoaded extends ChipState {
  final Stream<List<ChipModel>> chips;

  ChipsStreamLoaded({required this.chips}) : super([chips]);

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

// put these states in UserState when it's created

