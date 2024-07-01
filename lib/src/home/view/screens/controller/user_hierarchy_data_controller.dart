import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final userDataProvider =
    StateNotifierProvider<UserDataController, AsyncValue<UserData>>((ref) {
  return UserDataController();
});

class UserDataController extends StateNotifier<AsyncValue<UserData>> {
  UserDataController() : super(const AsyncLoading());

  Future<void> fetchUserData(
      String businessId, String userId, String parameter) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final url = Uri.parse(
          '${domain}data/get-level-data/$businessId/$userId/$parameter');
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
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final userData = UserData.fromJson(data);
        state = AsyncValue.data(userData);
      } else {
        state = AsyncValue.data(UserData(userEntries: [], dailyTarget: []));
        // AsyncValue.error('Failed to fetch user data', StackTrace.current);
      }
    } catch (e) {
      // state = AsyncValue.error('Error: $e', stackTrace);
      state = AsyncValue.data(UserData(userEntries: [], dailyTarget: []));
    }
  }
}

class UserData {
  final List<List<dynamic>> userEntries;
  final List<List<dynamic>> dailyTarget;

  UserData({required this.userEntries, required this.dailyTarget});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userEntries: List<List<dynamic>>.from(
          json['userEntries'].map((x) => List<dynamic>.from(x))),
      dailyTarget: List<List<dynamic>>.from(
          json['dailyTargetAccumulated'].map((x) => List<dynamic>.from(x))),
    );
  }
}

class UserPieData {
  final int totalSum;
  final List<UserEntry> userEntries;

  UserPieData({
    required this.totalSum,
    required this.userEntries,
  });

  factory UserPieData.fromJson(Map<String, dynamic> json) {
    return UserPieData(
      totalSum: json['totalSum'],
      userEntries: (json['userData'] as List)
          .map((item) => UserEntry.fromJson(item))
          .toList(),
    );
  }
}

class UserEntry {
  final String name;
  final num value;
  final num percentage;

  UserEntry({
    required this.name,
    required this.value,
    required this.percentage,
  });

  factory UserEntry.fromJson(Map<String, dynamic> json) {
    return UserEntry(
      name: json['name'],
      value: json['value'],
      percentage: json['percentage'],
    );
  }
}

final userPieDataProvider =
    StateNotifierProvider<UserPieDataController, AsyncValue<UserPieData>>(
        (ref) {
  return UserPieDataController();
});

// class UserPieDataController extends StateNotifier<AsyncValue<UserPieData>> {
//   UserPieDataController() : super(const AsyncLoading());

//   Future<void> fetchUserPieData(
//       String businessId, String userId, String parameter) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');

//     try {
//       final url = Uri.parse(
//           '${domain}data/get-pie-chart-data/$businessId/$userId/$parameter');
//       print(url);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print('This is the businessId :- $businessId');
//       print('This is userId :-$userId');
//       print('This is Parameter :- $parameter');
//       print(response.body);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['data'];
//         print('This is the data :- $data');
//         final userData = UserPieData.fromJson(data);
//         state = AsyncValue.data(userData);
//       } else {
//         state = AsyncValue.data(UserPieData(totalSum: 0, userEntries: []));
//         // AsyncValue.error('Failed to fetch user data', StackTrace.current);
//       }
//     } catch (e, stackTrace) {
//       // state = AsyncValue.error('Error: $e', stackTrace);
//       state = AsyncValue.data(UserPieData(totalSum: 0, userEntries: []));
//     }
//   }
// }

class UserPieDataController extends StateNotifier<AsyncValue<UserPieData>> {
  UserPieDataController() : super(const AsyncLoading());

  Future<void> fetchUserPieData(
      String businessId, String userId, String parameter) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final url = Uri.parse(
          '${domain}data/get-pie-chart-data/$businessId/$userId/$parameter');
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
      print(response.body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final data = responseBody['data'];
        print('This is the data :- $data');

        if (data is Map<String, dynamic> &&
            data.containsKey('totalSum') &&
            data.containsKey('userData')) {
          final userData = UserPieData.fromJson(data);

          // Check the length of userEntries and add dummy data if it contains only one entry
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
