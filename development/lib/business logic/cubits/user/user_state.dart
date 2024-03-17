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

final class FetchingUserChipsFailed extends UserState {
  final String errorMessage;

  const FetchingUserChipsFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
