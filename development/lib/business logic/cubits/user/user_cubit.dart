import 'package:bloc/bloc.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();

  UserCubit() : super(UserInitial());

  // fetch user by userName
  void fetchUserByUsername(String username) async {
    emit(UserLoadingState());
    try {
      UserModel user = await _userRepository.findUserByUsername(username);

      emit(UserLoadedState(user: user));
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }

  // fetch users by userNames
  void fetchUsersByUsernames(List<String> usernames) async {
    emit(UserLoadingState());

    try {
      List<UserModel> users =
          await _userRepository.findUsersByUsernames(usernames);

      emit(UsersLoadedState(users: users));
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }

  // fetch user chips stream
  void fetchUserChipsStream(String username) async {
    emit(FetchingUserChips());
    try {
      Stream<List<ChipModel>> chipsStream =
          _userRepository.getUserChipsStream(username);
      emit(UserChipsStreamFetched(chipsStream));
    } catch (error) {
      emit(FetchingUserChipsFailed(error.toString()));
    }
  }

  // fetch user chips
  void fetchUserChips(List<String> chipIds) async {
    emit(FetchingUserChips());
    try {
      List<ChipModel> chipsList = await _userRepository.getUserChips(chipIds);

      emit(UserChipsFetched(chipsList));
    } catch (error) {
      emit(FetchingUserChipsFailed(error.toString()));
    }
  }

  // fetch top contributors
  void fetchTopContributors() async {
    emit(FetchingTopContributors());
    try {
      List<Map<String, dynamic>> topContributors =
          await _userRepository.getTopContributors();

      emit(TopContributorsLoadedState(topContributors: topContributors));
    } catch (error) {
      emit(TopContributorsErrorState(errorMessage: error.toString()));
    }
  }

  // bookmark chip
  void bookMarkChip(
      {required ChipModel chip, required UserModel currentUser}) async {
    emit(UpdatingUserProfile());

    try {
      Map<String, dynamic> updatedUserData = await _userRepository.bookmarkChip(
        chip: chip,
        user: currentUser,
      );

      bool isBookmarked = updatedUserData["isBookmarked"];
      UserModel updatedUser = updatedUserData["updatedUser"];

      isBookmarked
          ? emit(ChipBookmarkedState(updatedUser: updatedUser))
          : emit(ChipUnbookmarkedState(updatedUser: updatedUser));

      // uncomment this line to fix bug of unbookmarked chip still showing in fav chips screen
      // fetchUserChips(updatedUser.favoritedChips);

      fetchTopContributors();
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }

  // mark as applied
  void markChipAsApplied(
      {required String chipId, required UserModel currentUser}) async {
    emit(UpdatingUserProfile());

    try {
      Map<String, dynamic> updatedUserData =
          await _userRepository.markChipAsApplied(
        chipId: chipId,
        user: currentUser,
      );

      bool isApplied = updatedUserData["isApplied"];
      UserModel updatedUser = updatedUserData["updatedUser"];

      isApplied
          ? emit(ChipAppliedState(updatedUser: updatedUser))
          : emit(ChipUnAppliedState(updatedUser: updatedUser));

      // uncomment this line to fix bug of unapplied chip still showing in applied chips screen
      // fetchUserChips(updatedUser.appliedChips);

      fetchTopContributors();
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }

  // update user
  void updateUser(UserModel user) async {
    emit(UpdatingUserProfile());

    try {
      UserModel updatedUser = await _userRepository.updateUser(user);
      emit(UserProfileUpdated(updatedUser: updatedUser));
    } catch (error) {
      emit(UserProfileUpdateFailed(errorMessage: error.toString()));
    }
  }

  // update user password
  void updateUserPassword(String oldPassword, String newPassword) async {
    emit(UpdatingUserPassword());
    try {
      await _userRepository.updateUserPassword(oldPassword, newPassword);
      emit(UserPasswordUpdated());
    } catch (error) {
      emit(UserPasswordUpdateFailed(errorMessage: error.toString()));
    }
  }
}
