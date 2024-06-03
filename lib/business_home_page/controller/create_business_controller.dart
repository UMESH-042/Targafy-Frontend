import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateBusinessController {
  final String domain = 'http://13.234.163.59:5000'; // Your API domain

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> createBusiness({
    required String buisnessName,
    required String logo,
    required String industryType,
    required String city,
    required String country,
      required Function(bool isSuccess) onCompletion,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      // Handle token not found
      return;
    }

    final url = '$domain/api/v1/business/create';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final businessData = {
      'buisnessName': buisnessName,
      'logo': logo,
      'industryType': industryType,
      'city': city,
      'country': country,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(businessData),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("Success");
      // Handle successful response
      onCompletion(true); // Invoke callback with failure status
    } else {
      // Handle error
      print("Error: ${response.statusCode}");
      onCompletion(true); // Invoke callback with success status
    }
  }
}
