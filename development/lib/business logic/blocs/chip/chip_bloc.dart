import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/chip_repository.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  final ChipRepository chipRepository;
  final AuthBloc authBloc;

  ChipBloc({required this.chipRepository, required this.authBloc})
      : super(ChipEmpty()) {
    on<FetchChips>((event, emit) async {
      await _getAllChips(emit);
    });

    on<FetchChipsStream>((event, emit) async {
      emit(ChipsLoading());
      Stream<List<ChipModel>> chipsStream = chipRepository.getAllChipsStream();
      emit(ChipsStreamLoaded(chips: chipsStream));
    });

    on<UploadChipEvent>((event, emit) async {
      print('ass is ${event.chipFile}');

      await _uploadChip(
        event.jobTitle,
        event.companyName,
        event.description,
        event.jobMode,
        event.locations,
        event.jobType,
        event.experienceRequired,
        event.deadline,
        event.chipFile,
        event.skills,
        event.salary,
        event.updatedUser,
        event.uploaderAvatar,
        emit,
      );
    });

    on<DeleteChipEvent>((event, emit) async {
      await _deleteChip(event.chipId, event.user, emit);
    });
  }

  Future<void> _getAllChips(Emitter<ChipState> emit) async {
    emit(ChipsLoading());
    try {
      final List<ChipModel> chips = await chipRepository.getAllChips();

      if (chips.isEmpty) {
        return emit(ChipEmpty());
      }

      emit(ChipsLoaded(chips: chips));
    } catch (e) {
      emit(ChipError(errorMsg: e.toString()));
    }
  }

  Future<void> _uploadChip(
    String jobTitle,
    String companyName,
    String description,
    String jobMode,
    List<String> locations,
    String jobType,
    int experienceRequired,
    DateTime deadline,
    File? chipFile,
    List<dynamic> skills,
    double salary,
    UserModel updatedUser,
    String uploaderAvatar,
    Emitter<ChipState> emit,
  ) async {
    try {
      emit(ChipsLoading());

      UserModel newUpdatedUser = await chipRepository.uploadChip(
        jobTitle: jobTitle,
        companyName: companyName,
        description: description,
        jobMode: jobMode,
        chipFile: chipFile,
        locations: locations,
        jobType: jobType,
        experienceRequired: experienceRequired,
        deadline: deadline,
        skills: skills,
        salary: salary,
        updatedUser: updatedUser,
        uploaderAvatar: uploaderAvatar,
      );

      emit(ChipSuccess());
      print('updated user after chip upload');
      print(updatedUser);
      authBloc.add(AuthStateUpdatedEvent(newUpdatedUser));
    } catch (error) {
      print(error.toString());
      emit(ChipError(errorMsg: error.toString()));
    }
  }

  Future<void> _deleteChip(
      String chipId, UserModel user, Emitter<ChipState> emit) async {
    try {
      emit(ChipsLoading());

      UserModel updatedUser =
          await chipRepository.deleteChip(chipId: chipId, updatedUser: user);
      print('goo');
      emit(ChipSuccess());
      authBloc.add(AuthStateUpdatedEvent(updatedUser));
    } catch (error) {
      emit(ChipError(errorMsg: error.toString()));
    }
  }
}
