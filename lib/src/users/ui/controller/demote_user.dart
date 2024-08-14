import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

final demoteUserProvider =
    Provider.autoDispose((ref) => DemoteUserController());

String domain = AppRemoteRoutes.baseUrl;

class DemoteUserController {
  Future<void> demoteUser(
      String businessId, String userId, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = '${domain}business/demote/$businessId';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: '{"userIdToDemote": "$userId"}',
      );
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User demoted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Only admin allowed to perform this operation'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Failed to demote user: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to demote user: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> demoteAdminToUser(
      String businessId, String userId, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = '${domain}business/demote/admin/$businessId/$userId';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Admin demoted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Only admin allowed to perform this operation'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Failed to demote user: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to demote user: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}


