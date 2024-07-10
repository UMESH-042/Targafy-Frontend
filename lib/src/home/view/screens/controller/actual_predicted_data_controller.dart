// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/utils/remote_routes.dart';

// String domain = AppRemoteRoutes.baseUrl;

// final dataAddedControllerProvider =
//     Provider<DataAddedController>((ref) => DataAddedController());

// class DataAddedController {
//   Future<Map<String, List<List<dynamic>>>> fetchDataAdded(
//       String businessId, String parameterName,String month) async {
//     final String url =
//         '${domain}data/get-param-data/$businessId/$parameterName/$month';
//     final authToken = await _getAuthToken(); // Get the auth token
//     print('This is business Id :- $businessId');
//     print('This is parameterName :- $parameterName');
//     try {
//       final response = await http
//           .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if (responseData.containsKey('data')) {
//           final Map<String, dynamic> data = responseData['data'];
//           final List<List<dynamic>> userEntries = data['userEntries'] != null
//               ? List<List<dynamic>>.from(data['userEntries'])
//               : [];
//           final List<List<dynamic>> dailyTarget =
//               data['dailyTargetAccumulated'] != null
//                   ? List<List<dynamic>>.from(data['dailyTargetAccumulated'])
//                   : [];
//           return {
//             'userEntries': userEntries,
//             'dailyTargetAccumulated': dailyTarget
//           };
//         }
//       }
//     } catch (e) {
//       print('Error fetching growth data: $e');
//     }
//     return {'userEntries': [], 'dailyTargetAccumulated': []};
//   }
// }

// // Function to get the auth token
// Future<String> _getAuthToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('authToken') ?? '';
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/utils/remote_routes.dart';

// String domain = AppRemoteRoutes.baseUrl;

// final dataAddedControllerProvider =
//     Provider<DataAddedController>((ref) => DataAddedController());

// class DataAddedController {
//   Future<Map<String, dynamic>> fetchDataAdded(
//       String businessId, String parameterName, String month) async {
//     final String url =
//         '${domain}data/get-param-data/$businessId/$parameterName/$month';
//     final authToken = await _getAuthToken(); // Get the auth token
//     print('This is business Id :- $businessId');
//     print('This is parameterName :- $parameterName');
//     try {
//       final response = await http
//           .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if (responseData.containsKey('data')) {
//           final Map<String, dynamic> data = responseData['data']['data'];
//           final List<List<dynamic>> userEntries = data['userEntries'] != null
//               ? List<List<dynamic>>.from(data['userEntries'])
//               : [];
//           final List<List<dynamic>> dailyTarget =
//               data['dailyTargetAccumulated'] != null
//                   ? List<List<dynamic>>.from(data['dailyTargetAccumulated'])
//                   : [];
//           final int totalTargetAchieved = responseData['data']['totalTargetAchieved'] ?? 0;
//           final int actualTotalTarget = responseData['data']['actualTotalTarget'] ?? 0;
//           final int percentage = responseData['data']['percentage'] ?? 0;

//           return {
//             'userEntries': userEntries,
//             'dailyTargetAccumulated': dailyTarget,
//             'totalTargetAchieved': totalTargetAchieved,
//             'actualTotalTarget': actualTotalTarget,
//             'percentage': percentage,
//           };
//         }
//       }
//     } catch (e) {
//       print('Error fetching growth data: $e');
//     }
//     return {
//       'userEntries': [],
//       'dailyTargetAccumulated': [],
//       'totalTargetAchieved': 0,
//       'actualTotalTarget': 0,
//       'percentage': 0,
//     };
//   }
// }

// // Function to get the auth token
// Future<String> _getAuthToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('authToken') ?? '';
// }

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final dataAddedControllerProvider =
    Provider<DataAddedController>((ref) => DataAddedController());

class DataAddedController {
  Future<UserDataModel> fetchDataAdded(
      String businessId, String parameterName, String month) async {
    final String url =
        '${domain}data/get-param-data/$businessId/$parameterName/$month';
    final authToken = await _getAuthToken(); // Get the auth token
    print('This is business Id :- $businessId');
    print('This is parameterName :- $parameterName');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> data = responseData['data']['data'];
          return UserDataModel.fromJson(data, responseData['data']);
        }
      }
    } catch (e) {
      print('Error fetching growth data: $e');
    }
    return UserDataModel.empty();
  }
}

// Function to get the auth token
Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}

class UserDataModel {
  final List<List<dynamic>> userEntries;
  final List<List<dynamic>> dailyTargetAccumulated;
  final int totalTargetAchieved;
  final int actualTotalTarget;
  final int percentage;
  final List<dynamic> benchmarkValues;

  UserDataModel({
    required this.userEntries,
    required this.dailyTargetAccumulated,
    required this.totalTargetAchieved,
    required this.actualTotalTarget,
    required this.percentage,
    required this.benchmarkValues,
  });

  factory UserDataModel.fromJson(
      Map<String, dynamic> data, Map<String, dynamic> responseData) {
    return UserDataModel(
      userEntries: List<List<dynamic>>.from(data['userEntries'] ?? []),
      dailyTargetAccumulated:
          List<List<dynamic>>.from(data['dailyTargetAccumulated'] ?? []),
      totalTargetAchieved: responseData['totalTargetAchieved'] ?? 0,
      actualTotalTarget: responseData['actualTotalTarget'] ?? 0,
      percentage: responseData['percentage'] ?? 0,
      benchmarkValues: List<dynamic>.from(data['benchmarkValues'] ?? []),
    );
  }

  factory UserDataModel.empty() {
    return UserDataModel(
      userEntries: [],
      dailyTargetAccumulated: [],
      totalTargetAchieved: 0,
      actualTotalTarget: 0,
      percentage: 0,
      benchmarkValues: [],
    );
  }
}
