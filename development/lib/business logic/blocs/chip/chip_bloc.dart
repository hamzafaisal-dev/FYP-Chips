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
      } on FirebaseException catch (error) {
        String fbError = FirebaseAuthExceptionErrors.getFirebaseError(error);
        emit(ChipError(errorMsg: fbError));
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
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
