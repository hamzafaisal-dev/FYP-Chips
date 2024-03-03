import 'dart:io';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/chip_network.dart';

class ChipRepository {
  final ChipNetwork chipsNetwork;

  ChipRepository({required this.chipsNetwork});

  // get list of all chips
  Future<List<ChipModel>> getAllChips() async {
    return await chipsNetwork.getAllChips();
  }

  // get stream of all chips
  Stream<List<ChipModel>> getAllChipsStream() {
    return chipsNetwork.getAllChipsStream();
  }

  // post chip
  Future<UserModel> postChip({
    required String jobTitle,
    required String companyName,
    required String applicationLink,
    String? description,
    String? jobMode,
    File? chipFile,
    List<String>? locations,
    String? jobType,
    int? experienceRequired,
    required DateTime deadline,
    required List<dynamic> skills,
    required double? salary,
    required UserModel updatedUser,
  }) {
    return chipsNetwork.postChip(
      jobTitle,
      companyName,
      applicationLink,
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
    );
  }

  // delete chip
  Future<UserModel> deleteChip({
    required String chipId,
    required UserModel updatedUser,
  }) {
    return chipsNetwork.deleteChip(
      chipId,
      updatedUser,
    );
  }
}
