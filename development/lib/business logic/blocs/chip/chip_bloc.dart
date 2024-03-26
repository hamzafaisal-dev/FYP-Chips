import 'package:bloc/bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/chip_repository.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  final ChipRepository _chipRepository = ChipRepository();

  void _fetchChips(Emitter<ChipState> emit) {
    emit(ChipsLoading());
    Stream<List<ChipModel>> chipsStream = _chipRepository.getAllChipsStream();
    emit(ChipsStreamLoaded(chips: chipsStream));
  }

  ChipBloc() : super(ChipEmpty()) {
    on<FetchChipByIdEvent>((event, emit) async {
      emit(ChipsLoading());
      ChipModel? individualChip =
          await _chipRepository.getChipById(event.chipId);
      emit(IndividualChipLoaded(chip: individualChip));
    });

    on<FetchChips>((event, emit) async {
      emit(ChipsLoading());
      List<ChipModel> searchedchips =
          await _chipRepository.getAllChips(event.searchText);
      emit(ChipsLoaded(chips: searchedchips));
    });

    on<FetchChipsStream>((event, emit) {
      _fetchChips(emit);
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
        _fetchChips(emit);
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
        _fetchChips(emit);
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
        _fetchChips(emit);
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // fire the fetch chips event again bec after error state, chips vanished on home
        _fetchChips(emit);
      }
    });
  }
}
