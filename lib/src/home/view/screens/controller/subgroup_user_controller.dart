import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/model/subgroup_user_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

class ApiService {
  Future<UserGroupResponse> fetchUserGroup(
      String subgroupId, String businessId, String token) async {
    final url = Uri.parse(
      '${domain}group/get-user-group/$subgroupId/$businessId',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserGroupResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user group');
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final userGroupProvider =
    FutureProvider.family<UserGroupResponse, String>((ref, subgroupId) async {
  final apiService = ref.read(apiServiceProvider);
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (businessId != null && token != null) {
    return await apiService.fetchUserGroup(subgroupId, businessId, token);
  } else {
    throw Exception('Business ID or token is missing');
  }
});
