import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/contact_us_network.dart';

class ContactUsRepository {
  final ContactUsNetwork _contactUsNetwork = ContactUsNetwork();

  Future<Map<String, dynamic>> contactUs(UserModel user, String message) async {
    return await _contactUsNetwork.contactUs(user, message);
  }
}
