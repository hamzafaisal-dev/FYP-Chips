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
    required ChipModel chip,
    required UserModel user,
  }) async {
    return await _userNetwork.bookmarkChip(chip, user);
  }

  // mark chip as applied
  Future<Map<String, dynamic>> markChipAsApplied({
    required String chipId,
    required UserModel user,
  }) async {
    return await _userNetwork.markChipAsApplied(chipId, user);
  }

  // get user chips
  Future<List<ChipModel>> getUserChips(List<String> chipIds) async {
    return _userNetwork.getUserChips(chipIds);
  }

  // update user
  Future<UserModel> updateUser(UserModel user) async {
    return await _userNetwork.updateUser(user);
  }
}
