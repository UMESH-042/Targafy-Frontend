import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Provider setup for fetching offices
final officesProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, businessId) async {
  final url = Uri.parse(
      'http://13.234.163.59/api/v1/office/get-office-business/$businessId');
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token'
    }, // Replace with your actual token
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    List<Map<String, dynamic>> offices = data
        .map((office) => {
              'officeId': office['officeId'],
              'name': office['name'],
            })
        .toList();
    return offices;
  } else {
    throw Exception('Failed to load offices');
  }
});
