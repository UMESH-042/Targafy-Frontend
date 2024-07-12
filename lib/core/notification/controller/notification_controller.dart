// services/notification_service.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/core/notification/model/notification_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

class NotificationService {
  final String baseUrl = '${domain}notification/get-notifications';

  Future<List<NotificationModel>> fetchNotifications(
      String businessId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List notificationsJson =
          jsonDecode(response.body)['data']['notifications'];
      return notificationsJson
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}

final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService());

final NotificationListProvider = FutureProvider.autoDispose
    .family<List<NotificationModel>, String>((ref, businessId) async {
  final NotificationService = ref.read(notificationServiceProvider);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  return await NotificationService.fetchNotifications(businessId, token!);
});
