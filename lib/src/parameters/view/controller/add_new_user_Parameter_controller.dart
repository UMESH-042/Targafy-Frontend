// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// final addUserToParameterProvider =
//     StateNotifierProvider<AddUserToParameterController, AsyncValue<void>>(
//   (ref) => AddUserToParameterController(),
// );

// class AddUserToParameterController extends StateNotifier<AsyncValue<void>> {
//   AddUserToParameterController() : super(const AsyncValue.data(null));

//   Future<void> addUserToParameter(
//       String businessId, String parameterName, List<String> userIds) async {
//     final url =
//         'http://13.234.163.59/api/v1/params/add-user-to-param/$businessId/$parameterName';

//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');

//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };

//     final body = json.encode({
//       'userIds': userIds,
//     });

//     try {
//       state = const AsyncValue.loading();
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       print(response.body);
//       if (response.statusCode == 200) {
//         state = const AsyncValue.data(null);
//       } else {
//         throw Exception('Failed to add user to parameter');
//       }
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/api%20repository/product_repository.dart';

final addUserToParameterProvider =
    StateNotifierProvider<AddUserToParameterController, AsyncValue<void>>(
  (ref) => AddUserToParameterController(),
);

class AddUserToParameterController extends StateNotifier<AsyncValue<void>> {
  AddUserToParameterController() : super(const AsyncValue.data(null));

  Future<void> addUserToParameter(String businessId, String parameterName,
      List<String> userIds, String paramId) async {
    final url = '${domain}params/add-user-to-param/$paramId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'userIds': userIds,
    });

    try {
      state = const AsyncValue.loading();
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        state = const AsyncValue.data(null);
      } else {
        throw Exception('Failed to add user to parameter');
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
