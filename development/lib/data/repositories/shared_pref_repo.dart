import 'package:development/data/networks/shared_ref_network.dart';

class SharedRefRepository {
  final SharedRefNetwork _sharedRefNetwork = SharedRefNetwork();

  Future<Map<String, dynamic>> getData() async {
    return await _sharedRefNetwork.getData();
  }

  Future<void> setData(Map<String, dynamic> selectedFilters) async {
    return await _sharedRefNetwork.setData(selectedFilters);
  }
}
