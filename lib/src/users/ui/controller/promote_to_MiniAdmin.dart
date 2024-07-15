import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

// Define a provider for promoting a user to Mini Admin
final promoteUserToMiniAdminProvider =
    Provider.autoDispose((ref) => PromoteUserToMiniAdmin());
String domain = AppRemoteRoutes.baseUrl;

// Class to hold the reference for promoting a user to Mini Admin
class PromoteUserToMiniAdmin {
  // Function to promote a user to Mini Admin
  Future<void> promote(String businessId, String userId, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = '${domain}business/promotion/$businessId';

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User promoted to Mini Admin successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception(
            'Failed to promote user to Mini Admin: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to promote user to Mini Admin: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
