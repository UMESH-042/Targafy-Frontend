import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';
import 'package:targafy/utils/remote_routes.dart';

final businessControllerProvider = StateNotifierProvider<BusinessController,
    AsyncValue<BusinessUserHierarchy>>((ref) {
  return BusinessController();
});

String domain = AppRemoteRoutes.baseUrl;

class BusinessController
    extends StateNotifier<AsyncValue<BusinessUserHierarchy>> {
  BusinessController() : super(const AsyncLoading());

  Future<void> fetchBusinessUserHierarchy(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse('${domain}business/get-sub-hierarchy-new/$businessId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['data'];
        final userHierarchy = BusinessUserHierarchy.fromJson(data);
        state = AsyncValue.data(userHierarchy);
      } else {
        state =
            AsyncValue.error('Failed to fetch hierarchy', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error: $e', stackTrace);
    }
  }

  Future<void> fetchBusinessGroupHierarchy(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse('${domain}groups/get-group-hierarchy/$businessId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['data'];
        final GroupHierarchy = BusinessUserHierarchy.fromJson(data);
        state = AsyncValue.data(GroupHierarchy);
      } else {
        state =
            AsyncValue.error('Failed to fetch hierarchy', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error: $e', stackTrace);
    }
  }
}
