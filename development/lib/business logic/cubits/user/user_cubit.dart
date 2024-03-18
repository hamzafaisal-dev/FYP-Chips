import 'package:bloc/bloc.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();
  final AuthCubit authCubit;

  UserCubit({required this.authCubit}) : super(UserInitial());

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

  void bookMarkChip(
      {required String chipId, required UserModel currentUser}) async {
    emit(UserLoadingState());

    try {
      Map<String, dynamic> updatedUserData = await _userRepository.bookmarkChip(
        chipId: chipId,
        user: currentUser,
      );

      bool isBookmarked = updatedUserData["isBookmarked"];
      UserModel updatedUser = updatedUserData["updatedUser"];

      isBookmarked
          ? emit(ChipBookmarkedState())
          : emit(ChipUnbookmarkedState());

      // uncomment this line to fix bug of unbookmarked chip still showing in fav chips screen
      fetchUserChips(updatedUser.favoritedChips);

      authCubit.authStateUpdatedEvent(updatedUser);
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }

  void markChipAsApplied(
      {required String chipId, required UserModel currentUser}) async {
    emit(UserLoadingState());

    try {
      Map<String, dynamic> updatedUserData =
          await _userRepository.markChipAsApplied(
        chipId: chipId,
        user: currentUser,
      );

      bool isApplied = updatedUserData["isApplied"];
      UserModel updatedUser = updatedUserData["updatedUser"];

      isApplied ? emit(ChipAppliedState()) : emit(ChipUnAppliedState());

      // uncomment this line to fix bug of unapplied chip still showing in applied chips screen
      fetchUserChips(updatedUser.appliedChips);

      authCubit.authStateUpdatedEvent(updatedUser);
    } catch (error) {
      emit(UserErrorState(errorMessage: error.toString()));
    }
  }
}
