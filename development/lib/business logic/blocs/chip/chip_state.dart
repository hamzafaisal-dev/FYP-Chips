import 'package:development/data/models/chip_model.dart';
import 'package:equatable/equatable.dart';

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

class ChipsLoaded extends ChipState {
  final List<ChipModel> chips;

  ChipsLoaded({required this.chips}) : super([chips]);

  @override
  List<Object?> get props => [chips];
}

class ChipsStreamLoaded extends ChipState {
  final Stream<List<ChipModel>> chips;

  ChipsStreamLoaded({required this.chips}) : super([chips]);

  @override
  List<Object?> get props => [chips];
}

class ChipSuccess extends ChipState {
  @override
  List<Object?> get props => [];
}

class ChipError extends ChipState {
  final String errorMsg;
  const ChipError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
