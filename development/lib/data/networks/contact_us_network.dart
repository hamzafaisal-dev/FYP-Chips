import 'dart:convert';
import 'package:development/constants/network_urls.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:http/http.dart' as http;

class ContactUsNetwork {
  Future<Map<String, dynamic>> contactUs(
    UserModel user,
    String message,
  ) async {
    final url = Uri.https(NetworkURLS.baseUrl1, '/contactUs');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': user.username,
      'message': message,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // log event
        Helpers.logEvent(
          user.userId,
          "contact-admin",
          [message, user],
        );

        final responseData = jsonDecode(response.body);
        return {
          'status': responseData['status'].toString(),
        };
      } else {
        throw Exception('Failed to contact server');
      }
    } catch (e) {
      throw Exception('Failed to contact server: $e');
    }
  }
}
