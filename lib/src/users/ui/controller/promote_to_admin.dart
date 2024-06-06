import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Define a provider for promoting a user to admin
final promoteUserToAdminProvider =
    Provider.autoDispose((ref) => PromoteUserToAdmin());

// Class to hold the reference for promoting a user to admin
class PromoteUserToAdmin {
  // Function to promote a user to admin
  Future<void> promote(String businessId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url =
        'http://13.234.163.59:5000/api/v1/business/promote/admin/$businessId/$userId';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception(
            'Failed to promote user to admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception promoting user to admin: $e');
    }
  }
}
