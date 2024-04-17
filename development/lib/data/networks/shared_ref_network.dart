import 'package:shared_preferences/shared_preferences.dart';

// all this shit should be in services but fuck this fyp
class SharedRefNetwork {
  Future<Map<String, dynamic>> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? jobModes = prefs.getStringList('jobModes');
    final List<String>? jobTypes = prefs.getStringList('jobTypes');

    Map<String, dynamic> selectedFilters = {
      'jobModes': jobModes ?? <String>[],
      'jobTypes': jobTypes ?? <String>[],
    };

    return selectedFilters;
  }

  Future<void> setData(Map<String, dynamic> selectedFilters) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> jobModes = selectedFilters['jobModes'] as List<String>;
    final List<String> jobTypes = selectedFilters['jobTypes'] as List<String>;

    await prefs.setStringList('jobModes', jobModes);
    await prefs.setStringList('jobTypes', jobTypes);
  }
}
