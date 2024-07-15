import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:http/http.dart' as http;

final resetNotificationCounterProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, type) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (token == null) {
    throw Exception('Auth token not found');
  }

  final businessId = ref.watch(currentBusinessProvider)?['business']?.id;

  if (businessId == null) {
    throw Exception('Business ID not found');
  }

  final response = await http.post(
    Uri.parse(
        'http://13.234.163.59/api/v1/notification/reset-counter/$businessId'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'type': type, // Pass the type parameter here
    }),
  );
  print(response.body);

  if (response.statusCode == 200) {
    return true; // Success indicator
  } else {
    throw Exception('Failed to reset notification counter');
  }
});
