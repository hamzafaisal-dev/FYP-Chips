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

final class ChipBookmarkedState extends UserState {
  final UserModel updatedUser;

  const ChipBookmarkedState({required this.updatedUser});
}

final class ChipUnbookmarkedState extends UserState {
  final UserModel updatedUser;

  const ChipUnbookmarkedState({required this.updatedUser});
}

final class ChipAppliedState extends UserState {
  final UserModel updatedUser;

  const ChipAppliedState({required this.updatedUser});
}

final class ChipUnAppliedState extends UserState {
  final UserModel updatedUser;

  const ChipUnAppliedState({required this.updatedUser});
}

// user profile related states
final class UpdatingUserProfile extends UserState {}

final class UserProfileUpdated extends UserState {
  final UserModel updatedUser;

  const UserProfileUpdated({required this.updatedUser});

  @override
  List<Object> get props => [updatedUser];
}

final class UserProfileUpdateFailed extends UserState {
  final String errorMessage;

  const UserProfileUpdateFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// user password related states
final class UpdatingUserPassword extends UserState {}

final class UserPasswordUpdated extends UserState {}

final class UserPasswordUpdateFailed extends UserState {
  final String errorMessage;

  const UserPasswordUpdateFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class UserLoadedState extends UserState {
  final UserModel user;

  const UserLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

final class UsersLoadedState extends UserState {
  final List<UserModel> users;

  const UsersLoadedState({required this.users});

  @override
  List<Object> get props => [users];
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

final class FetchingTopContributors extends UserState {}

final class TopContributorsLoadedState extends UserState {
  final List<Map<String, dynamic>> topContributors;

  const TopContributorsLoadedState({required this.topContributors});

  @override
  List<Object> get props => [topContributors];
}

final class TopContributorsErrorState extends UserState {
  final String errorMessage;

  const TopContributorsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
