import 'package:development/data/networks/autofill_network.dart';

class AutofillRepository {
  final AutofillNetwork _autofillNetwork = AutofillNetwork();

  Future<Map<String, dynamic>> sendAutofillRequestN(String context) async {
    return _autofillNetwork.sendAutofillRequestN(context);
  }
}
