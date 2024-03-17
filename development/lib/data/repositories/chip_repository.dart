import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/chip_network.dart';

class ChipRepository {
  final ChipNetwork _chipsNetwork = ChipNetwork();

  // shift this to User repo when created
  Future<bool> bookmarkChip({
    required String chipId,
    required UserModel user,
  }) {
    return _chipsNetwork.bookmarkChip(chipId, user);
  }

  // get list of all chips
  Future<List<ChipModel>> getAllChips() async {
    return await _chipsNetwork.getAllChips();
  }

  // get stream of all chips
  Stream<List<ChipModel>> getAllChipsStream() {
    return _chipsNetwork.getAllChipsStream();
  }

  // post chip
  Future<UserModel> postChip({required Map<String, dynamic> chipMap}) {
    return _chipsNetwork.postChip(chipMap: chipMap);
  }

  // edit chip
  Future<void> editChip({required Map<String, dynamic> chipMap}) {
    return _chipsNetwork.editChip(chipMap: chipMap);
  }

  // delete chip
  Future<UserModel> deleteChip({
    required String chipId,
    required UserModel user,
  }) {
    return _chipsNetwork.deleteChip(chipId, user);
  }
}
