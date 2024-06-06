// services/activity_service.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/activity/ui/model/activity_model.dart';

class ActivityService {
  final String baseUrl =
      'http://13.234.163.59:5000/api/v1/activity/get-activity';

  Future<List<ActivityModel>> fetchActivities(
      String businessId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List activitiesJson =
          jsonDecode(response.body)['data']['activities'];
      return activitiesJson
          .map((json) => ActivityModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }
}

final activityServiceProvider =
    Provider<ActivityService>((ref) => ActivityService());

final activityListProvider = FutureProvider.autoDispose
    .family<List<ActivityModel>, String>((ref, businessId) async {
  final activityService = ref.read(activityServiceProvider);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  return await activityService.fetchActivities(businessId, token!);
});