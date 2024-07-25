import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/src/parameters/view/model/user_target_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

// User Notifier
class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UserNotifier() : super(const AsyncValue.loading());

  Future<void> fetchUsers(String paramName, String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(
            '${domain}target/get-not-target-assigned-users/$businessId/$paramName/${DateTime.now().month.toString()}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data =
            json.decode(response.body)['data']['usersNotInTarget'] as List;
        state =
            AsyncValue.data(data.map((user) => User.fromJson(user)).toList());
      } else {
        state = AsyncValue.data([]);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

class UserNotifier1 extends StateNotifier<AsyncValue<List<User>>> {
  UserNotifier1() : super(const AsyncValue.loading());

  Future<void> fetchFilteredUsers(
      String businessId, String paramName, String monthIndex) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse('${domain}target/get-target-values/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        final filteredData = data
            .where((target) =>
                target['targetName'] == paramName &&
                target['monthIndex'] == monthIndex)
            .toList();

        if (filteredData.isNotEmpty) {
          final userAssigned = filteredData[0]['userAssigned'] as List;
          final users =
              userAssigned.map((user) => User.fromJson(user)).toList();
          state = AsyncValue.data(users);
        } else {
          state = AsyncValue.data([]);
        }
      } else {
        state = AsyncValue.error('Failed to load targets', StackTrace.current);
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
        Uri.parse('${domain}target/add-target/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(target.toJson()),
      );
      print(response.body);
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

final userProvider1 =
    StateNotifierProvider<UserNotifier1, AsyncValue<List<User>>>((ref) {
  return UserNotifier1();
});

final targetProvider =
    StateNotifierProvider<TargetNotifier, AsyncValue<void>>((ref) {
  return TargetNotifier();
});
