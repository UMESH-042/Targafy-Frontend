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
      // print(token);
      // print(businessId);
      // print(userId);
      // print(parameterName);
      // print(chartType);
      // print(duration);

      final response = await http.post(
        Uri.parse('http://13.234.163.59:5000/api/v1/params/add/$businessId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': parameterName,
          'charts': chartType,
          'duration': duration,
          'description': description,
          'userIds': userId,
        }),
      );
      if (response.statusCode == 201) {
        state = const AsyncValue.data(null);
        print("Success");
        return true;
      } else {
        print("${response.statusCode} no Success");
        state =
            AsyncValue.error('Failed to submit parameter', StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}
