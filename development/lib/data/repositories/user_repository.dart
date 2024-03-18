import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/user_network.dart';

class UserRepository {
  final UserNetwork _userNetwork = UserNetwork();

  // get user chips stream
  Stream<List<ChipModel>> getUserChipsStream(String username) {
    return _userNetwork.getUserChipsStream(username);
  }

  // bookmark chip
  Future<Map<String, dynamic>> bookmarkChip({
    required String chipId,
    required UserModel user,
  }) async {
    return await _userNetwork.bookmarkChip(chipId, user);
  }

  // mark chip as applied
  Future<Map<String, dynamic>> markChipAsApplied({
    required String chipId,
    required UserModel user,
  }) async {
    return await _userNetwork.markChipAsApplied(chipId, user);
  }

  Future<List<ChipModel>> getUserChips(List<String> chipIds) async {
    return _userNetwork.getUserChips(chipIds);
  }
}
