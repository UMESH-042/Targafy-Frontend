import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final parameterProvider =
    StateNotifierProvider<ParameterNotifier, AsyncValue<void>>((ref) {
  return ParameterNotifier();
});

class ParameterNotifier extends StateNotifier<AsyncValue<void>> {
  ParameterNotifier() : super(const AsyncValue.data(null));

  Future<bool> addParameter(
      String businessId,
      String parameterName,
      List<String> userId,
      String chartType,
      String duration,
      String description) async {
    state = const AsyncValue.loading();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      final response = await http.post(
        Uri.parse('http://13.234.163.59:5000/api/v1/params/add/$businessId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': parameterName,
          'charts': chartType,
          'userIds': userId,
          'duration': duration,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        state = const AsyncValue.data(null);
        return true;
      } else {
        state = AsyncValue.error('Failed to submit parameter', StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}
