import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final demoteUserProvider =
    Provider.autoDispose((ref) => DemoteUserController());

class DemoteUserController {
  Future<void> demoteUser(String businessId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = 'http://13.234.163.59:5000/api/v1/business/demote/$businessId';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: '{"userIdToDemote": "$userId"}',
      );

      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception('Failed to demote user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception demoting user: $e');
    }
  }
}
