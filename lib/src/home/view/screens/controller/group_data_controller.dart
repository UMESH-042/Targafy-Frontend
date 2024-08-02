import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/controller/user_hierarchy_data_controller.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:http/http.dart' as http;

String domain = AppRemoteRoutes.baseUrl;

final groupDataProvider =
    StateNotifierProvider<GroupDataController, AsyncValue<GroupData>>((ref) {
  return GroupDataController();
});

class GroupDataController extends StateNotifier<AsyncValue<GroupData>> {
  GroupDataController() : super(const AsyncLoading());

  Future<void> fetchGroupData(
      String businessId, String userId, String parameter, String month) async {
    final String url =
        '${domain}groups/get-group-data/$businessId/$parameter/$month/$userId';
    final authToken = await _getAuthToken();
    print('This is business Id :- $businessId');
    print('This is groupId :- $userId');
    print('This is Parameter :- $parameter');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> data = responseData['data']['data'];
          state =
              AsyncValue.data(GroupData.fromJson(data, responseData['data']));
          return;
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    state = AsyncValue.data(GroupData.empty());
  }
}

Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}

class GroupData {
  final List<List<dynamic>> userEntries;
  final List<List<dynamic>> dailyTargetAccumulated;
  final int totalTargetAchieved;
  final int actualTotalTarget;
  final int percentage;

  GroupData({
    required this.userEntries,
    required this.dailyTargetAccumulated,
    required this.totalTargetAchieved,
    required this.actualTotalTarget,
    required this.percentage,
  });

  factory GroupData.fromJson(
      Map<String, dynamic> data, Map<String, dynamic> responseData) {
    return GroupData(
      userEntries: List<List<dynamic>>.from(data['userEntries'] ?? []),
      dailyTargetAccumulated:
          List<List<dynamic>>.from(data['dailyTargetAccumulated'] ?? []),
      totalTargetAchieved: responseData['totalTargetAchieved'] ?? 0,
      actualTotalTarget: responseData['actualTotalTarget'] ?? 0,
      percentage: responseData['percentage'] ?? 0,
    );
  }

  factory GroupData.empty() {
    return GroupData(
      userEntries: [],
      dailyTargetAccumulated: [],
      totalTargetAchieved: 0,
      actualTotalTarget: 0,
      percentage: 0,
    );
  }
}

final groupPieDataProvider =
    StateNotifierProvider<GroupPieDataController, AsyncValue<UserPieData>>(
        (ref) {
  return GroupPieDataController();
});

class GroupPieDataController extends StateNotifier<AsyncValue<UserPieData>> {
  GroupPieDataController() : super(const AsyncLoading());

  Future<void> fetchGroupPieData(String businessId, String userId,
      String parameter, String currentMonth) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final url = Uri.parse(
          '${domain}groups/get-pie-group-data/$businessId/$parameter/$currentMonth/$userId');
      print(url);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('This is the businessId :- $businessId');
      print('This is userId :-$userId');
      print('This is Parameter :- $parameter');
      // print(response.body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final data = responseBody['data'];
        print('This is the data :- $data');

        if (data is Map<String, dynamic> &&
            data.containsKey('totalSum') &&
            data.containsKey('userData')) {
          final userData = UserPieData.fromJson(data);

          if (userData.userEntries.length == 1) {
            userData.userEntries
                .add(UserEntry(name: ' ', value: 0, percentage: 0.0));
          }

          state = AsyncValue.data(userData);
        } else {
          state = AsyncValue.data(UserPieData(
              totalSum: 0,
              userEntries: [UserEntry(name: ' ', value: 0, percentage: 0)]));
        }
      } else {
        state = AsyncValue.data(UserPieData(
            totalSum: 0,
            userEntries: [UserEntry(name: ' ', value: 0, percentage: 0)]));
      }
    } catch (e) {
      print('Error: $e');
      state = AsyncValue.data(UserPieData(
          totalSum: 0,
          userEntries: [UserEntry(name: ' ', value: 0, percentage: 0)]));
    }
  }
}
