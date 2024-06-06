import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/src/parameters/view/model/user_target_model.dart';

// User Notifier
class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UserNotifier() : super(const AsyncValue.loading());

  Future<void> fetchUsers(String paramName, String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(
            'http://13.234.163.59:5000/api/v1/params/get-assign-user/$paramName/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        state =
            AsyncValue.data(data.map((user) => User.fromJson(user)).toList());
      } else {
        state = AsyncValue.error('Failed to load users', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Target Notifier
class TargetNotifier extends StateNotifier<AsyncValue<void>> {
  TargetNotifier() : super(const AsyncValue.data(null));

  Future<void> addTarget(Target target, String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.post(
        Uri.parse(
            'http://13.234.163.59:5000/api/v1/target/add-target/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(target.toJson()),
      );

      if (response.statusCode == 201) {
        state = const AsyncValue.data(null);
      } else {
        state = AsyncValue.error('Failed to add target', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>((ref) {
  return UserNotifier();
});

final targetProvider =
    StateNotifierProvider<TargetNotifier, AsyncValue<void>>((ref) {
  return TargetNotifier();
});
