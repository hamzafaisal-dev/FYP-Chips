import 'package:bloc/bloc.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final UserRepository _userRepository = UserRepository();

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
}
