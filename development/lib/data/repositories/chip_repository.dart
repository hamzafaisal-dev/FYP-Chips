import 'dart:io';

import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/chip_network.dart';

class ChipRepository {
  final ChipsFirestoreClient chipsFirestoreClient;

  ChipRepository({required this.chipsFirestoreClient});

  Future<List<ChipModel>> getAllChips() async {
    return await chipsFirestoreClient.getAllChips();
  }

  Stream<List<ChipModel>> getAllChipsStream() {
    return chipsFirestoreClient.getAllChipsStream();
  }

  Future<UserModel> uploadChip({
    required String jobTitle,
    required String companyName,
    required String description,
    required String jobMode,
    File? chipFile,
    required List<String> locations,
    required String jobType,
    required int experienceRequired,
    required DateTime deadline,
    required List<dynamic> skills,
    required double salary,
    required UserModel updatedUser,
    required String uploaderAvatar,
  }) {
    return chipsFirestoreClient.uploadChip(
      jobTitle,
      companyName,
      description,
      jobMode,
      chipFile ?? File(''),
      locations,
      jobType,
      experienceRequired,
      deadline,
      skills,
      salary,
      updatedUser,
      uploaderAvatar,
    );
  }

  Future<UserModel> deleteChip({
    required String chipId,
    required UserModel updatedUser,
  }) {
    return chipsFirestoreClient.deleteChip(
      chipId,
      updatedUser,
    );
  }
}
