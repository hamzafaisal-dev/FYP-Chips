import 'package:development/data/networks/contact_us_network.dart';

class ContactUsRepository {
  final ContactUsNetwork _contactUsNetwork = ContactUsNetwork();

  Future<Map<String, dynamic>> contactUs(
      String username, String message) async {
    return await _contactUsNetwork.contactUs(username, message);
  }
}
