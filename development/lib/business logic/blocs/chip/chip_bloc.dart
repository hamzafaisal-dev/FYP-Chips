import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/chip_repository.dart';
import 'package:development/utils/firebase_helpers.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  final ChipRepository _chipRepository = ChipRepository();

  ChipBloc() : super(ChipEmpty()) {
    // fetch all chips from dataabase
    on<FetchChipsStream>((event, emit) {
      emit(ChipsLoading());

      Stream<List<ChipModel>> chipsStream = _chipRepository.getAllChipsStream();

      emit(ChipsStreamLoaded(chips: chipsStream));
    });

    on<UploadChipEvent>((event, emit) async {
      emit(ChipsLoading());

      try {
        UserModel updatedUser =
            await _chipRepository.postChip(chipMap: event.newChip);

        emit(ChipSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // these 3 lines are basically the FetchChipsStream event, this is done bec after error state, chips vanished on home
        emit(ChipsLoading());
        Stream<List<ChipModel>> chipsStream =
            _chipRepository.getAllChipsStream();
        emit(ChipsStreamLoaded(chips: chipsStream));
      }
    });

    on<EditChipEvent>((event, emit) async {
      emit(ChipsLoading());

      try {
        await _chipRepository.editChip(chipMap: event.editedChip);

        emit(ChipEditSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));

        // these 3 lines are basically the FetchChipsStream event, this is done bec after error state, chips vanished on home
        emit(ChipsLoading());
        Stream<List<ChipModel>> chipsStream =
            _chipRepository.getAllChipsStream();
        emit(ChipsStreamLoaded(chips: chipsStream));
      }
    });

    on<DeleteChipEvent>((event, emit) async {
      emit(ChipsLoading());

      try {
        UserModel updatedUser = await _chipRepository.deleteChip(
          chipId: event.chipId,
          user: event.currentUser,
        );

        emit(ChipSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });
  }
}
