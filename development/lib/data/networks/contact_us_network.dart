import 'dart:convert';
import 'package:development/constants/network_urls.dart';
import 'package:http/http.dart' as http;

class ContactUsNetwork {
  Future<Map<String, dynamic>> contactUs(
      String username, String message) async {
    final url = Uri.https(NetworkURLS.baseUrl1, '/contactUs');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'message': message,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
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
