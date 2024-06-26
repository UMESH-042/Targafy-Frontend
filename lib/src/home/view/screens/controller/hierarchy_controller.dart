// controller/user_hierarchy_controller.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/model/hierarchy_model.dart';

final businessControllerProvider = StateNotifierProvider<BusinessController,
    AsyncValue<BusinessUserHierarchy>>((ref) {
  return BusinessController();
});

class BusinessController
    extends StateNotifier<AsyncValue<BusinessUserHierarchy>> {
  BusinessController() : super(const AsyncValue.loading());

  Future<void> fetchBusinessUserHierarchy(String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';
      final response = await http.get(
        Uri.parse(
            'http://13.234.163.59/api/v1/office/get-office-hierarchy/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['data'];
        final hierarchy = BusinessUserHierarchy.fromJson(data);
        state = AsyncValue.data(hierarchy);
      } else {
        state =
            AsyncValue.error('Failed to load hierarchy', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
