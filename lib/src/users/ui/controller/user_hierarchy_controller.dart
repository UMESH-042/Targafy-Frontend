// // controllers/business_user_hierarchy_controller.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';

// final businessUserHierarchyProvider = StateNotifierProvider<
//     BusinessUserHierarchyController, AsyncValue<BusinessUserHierarchy>>((ref) {
//   return BusinessUserHierarchyController();
// });

// class BusinessUserHierarchyController
//     extends StateNotifier<AsyncValue<BusinessUserHierarchy>> {
//   BusinessUserHierarchyController() : super(const AsyncValue.loading());

//   Future<void> fetchBusinessUserHierarchy(
//       String businessId, String token) async {
//     final url =
//         'http://13.234.163.59:5000/api/v1/business/get-user-hierarchy/$businessId';
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final hierarchy = BusinessUserHierarchy.fromJson(jsonResponse);
//         state = AsyncValue.data(hierarchy);
//       } else {
//     state =
//         AsyncValue.error('Failed to fetch hierarchy', StackTrace.current);
//   }
// } catch (e, stackTrace) {
//   state = AsyncValue.error('Error: $e', stackTrace);
// }
//   }
// }

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';

final businessControllerProvider = StateNotifierProvider<BusinessController,
    AsyncValue<BusinessUserHierarchy>>((ref) {
  return BusinessController();
});

class BusinessController
    extends StateNotifier<AsyncValue<BusinessUserHierarchy>> {
  BusinessController() : super(const AsyncLoading());

  Future<void> fetchBusinessUserHierarchy(
      String businessId) async {

         final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse(
            'http://13.234.163.59:5000/api/v1/business/get-user-hierarchy/$businessId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['data'];
        final userHierarchy = BusinessUserHierarchy.fromJson(data);
        state = AsyncValue.data(userHierarchy);
      } else {
        state =
            AsyncValue.error('Failed to fetch hierarchy', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error: $e', stackTrace);
    }
  }
}
