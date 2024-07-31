import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/groups/ui/model/create_sub_group_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final subgroupUsersControllerProvider =
    Provider<SubgroupUsersController>((ref) {
  return SubgroupUsersController();
});

class SubgroupUsersController {
  Future<List<SubgroupUserModel>> fetchGroupUserList(
      String businessId, String groupId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final url =
          Uri.parse('${domain}groups/get-group-users/$businessId/$groupId');
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<SubgroupUserModel> users = (jsonData['data']['users'] as List)
            .map((user) => SubgroupUserModel.fromJson(user))
            .toList();
        return users;
      } else {
        throw Exception('Failed to fetch users: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
