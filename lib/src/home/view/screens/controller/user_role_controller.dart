import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

// Define a provider for managing the state of the user role
final userRoleProvider = FutureProvider<String>((ref) async {
  final authToken = await _getAuthToken(); // Get the auth token
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId =
      selectedBusinessData?['business']?.id; // Get the business id

  final response = await http.get(
    Uri.parse('${domain}business/get-user-role/$businessId'),
    headers: {
      'Authorization': 'Bearer $authToken',
    },
  );

  if (response.statusCode == 200) {
    final role = json.decode(response.body)['data']['role'] as String;
    return role;
  } else {
    throw Exception('Failed to fetch user role');
  }
});

// Function to get the auth token
Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}
