import 'dart:convert';
import 'package:development/utils/helper_functions.dart';
import 'package:http/http.dart' as http;

class AutofillNetwork {
  //network method for autofilling
  Future<Map<String, dynamic>> sendAutofillRequestN(String context) async {
    final url = Uri.parse('https://yessirfrfr.pythonanywhere.com/autofilling');

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({'context': context});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);

        var companyName = responsedata['company_name'];
        var jobTitle = responsedata['job_title'];
        var description = responsedata['description'];

        // formats date in yyyy-mm-dd format
        DateTime? deadline = Helpers.formatDate(responsedata["deadline"]);

        if (companyName == null && jobTitle == null && description == null) {
          throw 'The image does not seem to contain any meaningful text';
        }

        return {
          'company_name': responsedata['company_name'].toString(),
          'job_title': responsedata['job_title'].toString(),
          'description': responsedata['description'].toString(),
          'location': responsedata['location'].toString(),
          'salary': responsedata['salary'].toString(),
          'deadline': deadline,
          'phone': responsedata['phone'].toString(),
          'email': responsedata['email'].toString(),
          'type': responsedata['type'].toString(),
          'sex': responsedata['sex'].toString(),
          'experience': responsedata['experience'].toString(),
          'mode': responsedata['mode'].toString(),
        };
      } else {
        throw Exception(response);
      }
    } catch (e) {
      throw Exception(e.toString());

      // rethrow;
    }
  }
}
