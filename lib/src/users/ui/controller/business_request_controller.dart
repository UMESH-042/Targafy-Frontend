
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/users/ui/model/request_user_model.dart';

// final businessRequestsProvider =
//     ChangeNotifierProvider.autoDispose<BusinessRequestsProvider>((ref) {
//   return BusinessRequestsProvider();
// });

// class BusinessRequestsProvider extends ChangeNotifier {
//   List<RequestUserModel>? userRequestList;
//   bool isLoading = false;
//   String? errorMessage;

//   Future<void> getRequestsList(BuildContext context, String businessId) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       final response = await http.get(
//         Uri.parse(
//             'http://13.234.163.59:5000/api/v1/business/get/request/$businessId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['data'];
//         userRequestList = (data['requests'] as List)
//             .map((request) => RequestUserModel.fromJson(request))
//             .toList();
//         print('userRequestList: $userRequestList');

//       } else {
//         userRequestList = [];
//         errorMessage = 'Failed to load requests';
//       }
//     } catch (e) {
//       userRequestList = [];
//       errorMessage = 'An error occurred: $e';
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> refreshRequestList(BuildContext context, String businessId) async { // Add BuildContext as a parameter
//   await getRequestsList(context, businessId);
// }


//   void clear() {
//     userRequestList = null;
//     errorMessage = null;
//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/users/ui/model/request_user_model.dart';

final businessRequestsProvider =
    ChangeNotifierProvider.autoDispose<BusinessRequestsProvider>((ref) {
  return BusinessRequestsProvider();
});

class BusinessRequestsProvider extends ChangeNotifier {
  List<RequestUserModel>? userRequestList;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getRequestsList(BuildContext context, String businessId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(
            'http://13.234.163.59:5000/api/v1/business/get/request/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        userRequestList = (data['requests'] as List)
            .map((request) => RequestUserModel.fromJson(request))
            .toList();
        print('userRequestList: $userRequestList');

      } else {
        userRequestList = [];
        errorMessage = 'Failed to load requests';
      }
    } catch (e) {
      userRequestList = [];
      errorMessage = 'An error occurred: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshRequestList(BuildContext context, String businessId) async { 
    await getRequestsList(context, businessId);
  }

  void clear() {
    userRequestList = null;
    errorMessage = null;
    notifyListeners();
  }
}
