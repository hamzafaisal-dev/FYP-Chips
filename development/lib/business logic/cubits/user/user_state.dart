part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

// user chips related states
final class FetchingUserChips extends UserState {}

final class UserChipsStreamFetched extends UserState {
  final Stream<List<ChipModel>> userChipsStream;

  const UserChipsStreamFetched(this.userChipsStream);

  @override
  List<Object> get props => [userChipsStream];
}

final class UserChipsFetched extends UserState {
  final List<ChipModel> userChips;

  const UserChipsFetched(this.userChips);

  @override
  List<Object> get props => [userChips];
}

final class FetchingUserChipsFailed extends UserState {
  final String errorMessage;

  const FetchingUserChipsFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// generic loading class for user
final class UserLoadingState extends UserState {}

// generic error class for user
final class UserErrorState extends UserState {
  final String errorMessage;

  const UserErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class ChipBookmarkedState extends UserState {}

final class ChipUnbookmarkedState extends UserState {}

final class ChipAppliedState extends UserState {}

final class ChipUnAppliedState extends UserState {}
