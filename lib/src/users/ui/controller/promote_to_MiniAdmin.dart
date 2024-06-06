import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Define a provider for promoting a user to Mini Admin
final promoteUserToMiniAdminProvider =
    Provider.autoDispose((ref) => PromoteUserToMiniAdmin());

// Class to hold the reference for promoting a user to Mini Admin
class PromoteUserToMiniAdmin {
  // Function to promote a user to Mini Admin
  Future<void> promote(String businessId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url =
        'http://13.234.163.59:5000/api/v1/business/promotion/$businessId';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Specify the content type
        },
        body: jsonEncode({
          'role': 'MiniAdmin',
          'userIdToPromote': userId,
        }),
      );

      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception(
            'Failed to promote user to Mini Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception promoting user to Mini Admin: $e');
    }
  }
}
