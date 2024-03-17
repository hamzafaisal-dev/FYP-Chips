import 'package:development/data/models/chip_model.dart';
import 'package:development/data/networks/user_network.dart';

class UserRepository {
  final UserNetwork _userNetwork = UserNetwork();

  // get user chips stream
  Stream<List<ChipModel>> getUserChipsStream(String username) {
    return _userNetwork.getUserChipsStream(username);
  }
}
