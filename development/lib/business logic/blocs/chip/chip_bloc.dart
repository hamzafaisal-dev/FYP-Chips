import 'package:bloc/bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/chip_repository.dart';
import 'package:development/data/repositories/notification_repository.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  final ChipRepository _chipRepository = ChipRepository();
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  Future<void> _fetchChips(Emitter<ChipState> emit) async {
    emit(ChipsLoading());
    List<ChipModel> allChips = await _chipRepository.getAllChipsFuture();

    emit(ChipsStreamLoaded(chips: allChips));
  }

  Future<void> _fetchFilteredChips(
      Map<String, dynamic> filters, Emitter<ChipState> emit) async {
    emit(ChipsLoading());

    List<ChipModel> filteredChips =
        await _chipRepository.getFilteredChips(filters);

    print('filteredChips len: ${filteredChips.length}');

    emit(ChipsStreamLoaded(chips: filteredChips));
  }

  ChipBloc() : super(ChipEmpty()) {
    on<FetchChipByIdEvent>((event, emit) async {
      try {
        emit(ChipsLoading());

        ChipModel? individualChip =
            await _chipRepository.getChipById(event.chipId);

        emit(IndividualChipLoaded(chip: individualChip));
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });

    on<FetchChips>((event, emit) async {
      emit(ChipsLoading());
      List<ChipModel> searchedchips =
          await _chipRepository.getAllSearchedChips(event.searchText);
      emit(ChipsLoaded(chips: searchedchips));
    });

    on<FetchChipsStream>((event, emit) async {
      List<String> jobModes = event.filters["jobModes"] as List<String>;
      List<String> jobTypes = event.filters["jobTypes"] as List<String>;

      if (jobModes.isNotEmpty || jobTypes.isNotEmpty) {
        await _fetchFilteredChips(event.filters, emit);
      } else {
        await _fetchChips(emit);
      }
    });

    on<UploadChipEvent>((event, emit) async {
      emit(ChipCreatingState());

      try {
        UserModel updatedUser =
            await _chipRepository.postChip(chipMap: event.newChip);

        emit(ChipAddSuccess(updatedUser: updatedUser));
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // fire the fetch chips event again bec after error state, chips vanished on home
        await _fetchChips(emit);
      }
    });

    on<EditChipEvent>((event, emit) async {
      emit(ChipEditingState());

      try {
        await _chipRepository.editChip(chipMap: event.editedChip);

        emit(ChipEditSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // fire the fetch chips event again bec after error state, chips vanished on home
        await _fetchChips(emit);
      }
    });

    on<LikeChipEvent>((event, emit) async {
      try {
        await _chipRepository.editChip(chipMap: event.likedChip);

        ChipModel chip = ChipModel.fromMap(event.likedChip);

        _notificationRepository.createNotification(
          'like',
          chip,
          event.currentUser,
        );
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });

    on<DeleteChipEvent>((event, emit) async {
      emit(ChipDeletingState());

      try {
        UserModel updatedUser = await _chipRepository.deleteChip(
          chipId: event.chipId,
          user: event.currentUser,
        );

        emit(ChipDeleteSuccess(updatedUser: updatedUser));
        await _fetchChips(emit);
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // fire the fetch chips event again bec after error state, chips vanished on home
        _fetchChips(emit);
      }
    });

    on<JustFetchChips>((event, emit) async {
      try {
        await _fetchChips(emit);
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });

    on<FetchUserPostedChips>((event, emit) async {
      try {
        emit(UserPostedChipsLoading());

        List<ChipModel> usersPostedChips =
            await _chipRepository.getUsersChips(event.postedBy);

        emit(UserPostedChipsLoaded(chips: usersPostedChips));
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });
  }
}
