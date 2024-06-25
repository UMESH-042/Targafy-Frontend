// business_users_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:targafy/src/users/ui/model/business_user_list_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final businessUsersProvider = StateNotifierProvider<BusinessUsersNotifier,
    AsyncValue<List<BusinessUserModel>>>((ref) {
  return BusinessUsersNotifier();
});

class BusinessUsersNotifier
    extends StateNotifier<AsyncValue<List<BusinessUserModel>>> {
  BusinessUsersNotifier() : super(const AsyncValue.loading());

  Future<void> fetchBusinessUsers(String businessId) async {
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('Authorization token not found');
      }

      final response = await http.get(
        Uri.parse('${domain}business/get/all/users/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<BusinessUserModel> users = (data['data']['users'] as List)
            .map((user) => BusinessUserModel.fromJson(user))
            .toList();
        state = AsyncValue.data(users);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final businessUsersStreamProvider = StreamProvider.autoDispose
    .family<List<BusinessUserModel>, String>((ref, businessId) async* {
  // Retrieve the token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (token == null) {
    throw Exception('Authorization token not found');
  }

  // Initial fetch
  final response = await http.get(
    Uri.parse('${domain}business/get/all/users/$businessId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load users');
  }

  final data = json.decode(response.body);
  final List<BusinessUserModel> users = (data['data']['users'] as List)
      .map((user) => BusinessUserModel.fromJson(user))
      .toList();
  yield users;

  // Simulate real-time updates
  await for (final _ in Stream.periodic(const Duration(seconds: 1))) {
    final response = await http.get(
      Uri.parse('${domain}business/get/all/users/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<BusinessUserModel> updatedUsers =
          (data['data']['users'] as List)
              .map((user) => BusinessUserModel.fromJson(user))
              .toList();
      yield updatedUsers;
    } else {
      throw Exception('Failed to load users');
    }
  }
});

final businessUsersStreamProvider2 = StreamProvider.autoDispose
    .family<List<BusinessUserModel2>, String>((ref, businessId) async* {
  // Retrieve the token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (token == null) {
    throw Exception('Authorization token not found');
  }

  // Initial fetch
  final response = await http.get(
    Uri.parse(
        '${domain}business/get-all-subordinate-businessusers/$businessId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load users');
  }

  final data = json.decode(response.body);
  final List<BusinessUserModel2> users = (data['data']['users'] as List)
      .map((user) => BusinessUserModel2.fromJson(user))
      .toList();
  yield users;

  // Simulate real-time updates
  await for (final _ in Stream.periodic(const Duration(seconds: 1))) {
    final response = await http.get(
      Uri.parse(
          '${domain}business/get-all-subordinate-businessusers/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<BusinessUserModel2> updatedUsers =
          (data['data']['users'] as List)
              .map((user) => BusinessUserModel2.fromJson(user))
              .toList();
      yield updatedUsers;
    } else {
      throw Exception('Failed to load users');
    }
  }
});

final userRequestProvider =
    StateNotifierProvider<UserRequestNotifier, AsyncValue<void>>((ref) {
  return UserRequestNotifier();
});

class UserRequestNotifier extends StateNotifier<AsyncValue<void>> {
  UserRequestNotifier() : super(const AsyncValue.data(null));

  Future<void> submitUserRequest(String businessId, String userId, String role,
      String parentId, String? selectedOfficeId) async {
    state = const AsyncValue.loading(); // Indicate loading state
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      final response = await http.post(
        Uri.parse('${domain}business/accept/request/$businessId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': role,
          'userId': userId,
          'parentId': parentId,
          'officeId': selectedOfficeId
        }),
      );
      print('role :- $role');
      print('userId :- $userId');
      print('parentId :- $parentId');
      print('officeId :- $selectedOfficeId');
      print(response.body);
      if (response.statusCode != 200) {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to submit request');
      }

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
