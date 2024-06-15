// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

// final groupDataControllerProvider = StateNotifierProvider.autoDispose<
//     GroupDataController, List<GroupDataModel>>((ref) {
//   return GroupDataController();
// });

// class GroupDataController extends StateNotifier<List<GroupDataModel>> {
//   GroupDataController() : super([]);

//   Future<void> fetchGroups(String businessId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final url = Uri.parse(
//         'http://13.234.163.59:5000/api/v1/group/get-all-groups/$businessId');
//     final headers = {
//       'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       final List<GroupDataModel> groups =
//           (responseData['data']['groups'] as List)
//               .map((data) => GroupDataModel.fromJson(data))
//               .toList();
//       state = groups;
//     } else {
//       throw Exception('Failed to load groups');
//     }
//   }

//     String? getGroupIdByName(String groupName) {
//     try {
//       return state.firstWhere((group) => group.groupName == groupName).id;
//     } catch (e) {
//       return null; // or handle the error as needed
//     }
//   }
// }

// group_data_controller.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final GroupDataControllerProvider = StateNotifierProvider.autoDispose<
    GroupDataController, List<GroupDataModel>>((ref) {
  return GroupDataController();
});

class GroupDataController extends StateNotifier<List<GroupDataModel>> {
  GroupDataController() : super([]);

  Future<void> fetchGroups(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = Uri.parse('${domain}group/get-all-groups/$businessId');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<GroupDataModel> groups =
          (responseData['data']['headOffice'] as List)
              .map((data) => GroupDataModel.fromJson(data))
              .toList();
      state = groups;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  String? getGroupIdByName(String groupName) {
    try {
      return state.firstWhere((group) => group.headOffice == groupName).id;
    } catch (e) {
      return null; // or handle the error as needed
    }
  }
}
