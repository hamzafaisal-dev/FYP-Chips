import 'dart:io';

import 'package:bloc/bloc.dart';
// import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/chip_repository.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  final ChipRepository _chipRepository = ChipRepository();

  ChipBloc() : super(ChipEmpty()) {
    //

    // fetch all chips from dataabase
    on<FetchChipsStream>((event, emit) {
      emit(ChipsLoading());

      Stream<List<ChipModel>> chipsStream = _chipRepository.getAllChipsStream();

      emit(ChipsStreamLoaded(chips: chipsStream));
    });

    on<UploadChipEvent>((event, emit) async {
      try {
        emit(ChipsLoading());

        UserModel updatedUser = await _chipRepository.postChip(
          jobTitle: event.jobTitle,
          companyName: event.companyName,
          applicationLink: event.applicationLink,
          description: event.description,
          jobMode: event.jobMode,
          chipFile: event.chipFile,
          locations: event.locations,
          jobType: event.jobType,
          experienceRequired: event.experienceRequired,
          deadline: event.deadline,
          skills: event.skills,
          salary: event.salary,
          currentUser: event.currentUser,
        );

        emit(ChipSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });

    on<DeleteChipEvent>((event, emit) async {
      emit(ChipsLoading());

      try {
        UserModel updatedUser = await _chipRepository.deleteChip(
            chipId: event.chipId, user: event.currentUser);

        emit(ChipSuccess());
      } catch (error) {
        emit(ChipError(errorMsg: error.toString()));
      }
    });
  }
}
