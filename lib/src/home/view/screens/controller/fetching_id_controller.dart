import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final groupControllerProvider = Provider((ref) => GroupController());

class GroupController {
  Future<String?> getGroupId(String businessId, String groupName) async {
    try {
      final url = Uri.parse(
          'http://13.234.163.59:5000/api/v1/group/get-groupId/$businessId/$groupName');
      
      // Replace 'YOUR_AUTH_TOKEN' with your actual authorization token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken'); 

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final groupId = responseData['data']['groupId'] as String?;
        return groupId;
      } else {
        throw Exception('Failed to get groupId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching group ID: $e');
      return null;
    }
  }
}
