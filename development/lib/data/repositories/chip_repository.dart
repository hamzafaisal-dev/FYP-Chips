import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/chip_network.dart';

class ChipRepository {
  final ChipNetwork _chipsNetwork = ChipNetwork();

  Future<ChipModel?> getChipById(String chipId) async {
    return await _chipsNetwork.getChipById(chipId);
  }

  // get list of all chips
  Future<List<ChipModel>> getAllSearchedChips(String searchText) async {
    return await _chipsNetwork.getAllSearchedChips(searchText);
  }

  // get stream of all chips
  Future<List<ChipModel>> getAllChipsFuture() async {
    return await _chipsNetwork.getAllChipsFuture();
  }

  // get stream of all chips
  Future<List<ChipModel>> getFilteredChips(Map<String, dynamic> filters) async {
    return await _chipsNetwork.getFilteredChips(filters);
  }

  // post chip
  Future<UserModel> postChip({required Map<String, dynamic> chipMap}) async {
    return await _chipsNetwork.postChip(chipMap: chipMap);
  }

  // edit chip
  Future<void> editChip({required Map<String, dynamic> chipMap}) {
    return _chipsNetwork.editChip(chipMap: chipMap);
  }

  // delete chip
  Future<UserModel> deleteChip({
    required String chipId,
    required UserModel user,
  }) async {
    return await _chipsNetwork.deleteChip(chipId, user);
  }
}
