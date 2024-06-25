import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final subOfficeProvider = Provider<SubOfficeController>((ref) {
  return SubOfficeController();
});

class SubOfficeController {
  Future<void> createSubOffices(
      String id, List<List<String>> officesArray) async {
    final url = 'http://13.234.163.59/api/v1/office/create-suboffices/$id';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({'officesArray': officesArray});

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      // Handle success
      print('Sub-offices created successfully');
    } else {
      // Handle error
      print('Failed to create sub-offices: ${response.body}');
      throw Exception('Failed to create sub-offices');
    }
  }
}
