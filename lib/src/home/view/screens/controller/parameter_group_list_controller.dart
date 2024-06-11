// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/home/view/screens/model/parameter_group_model.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   Future<SubGroupResponse> fetchSubGroups(
//       String businessId, String parameterName, String token) async {
//     final url = Uri.parse(
//       'http://13.234.163.59:5000/api/v1/group/get-sublevel-group-name/$businessId/$parameterName',
//     );

//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       return SubGroupResponse.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load subgroups');
//     }
//   }
// }

// // providers/subgroup_provider.dart

// final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// final subGroupProvider =
//     FutureProvider.family<List<SubGroup>, String>((ref, parameter) async {
//   final apiService = ref.read(apiServiceProvider);
//   final selectedBusinessData = ref.watch(currentBusinessProvider);
//   final businessId = selectedBusinessData?['business']?.id;
//   // Ensure you have a provider for the auth token
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authToken');

//   if (businessId != null && token != null) {
//     final subGroupResponse =
//         await apiService.fetchSubGroups(businessId, parameter, token);
//     return subGroupResponse.groups;
//   } else {
//     return [];
//   }
// }); 

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/model/parameter_group_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<SubGroupResponse> fetchSubGroups(String businessId, String parameterName, String token) async {
    final url = Uri.parse(
      'http://13.234.163.59:5000/api/v1/group/get-sublevel-group-name/$businessId/$parameterName',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return SubGroupResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load subgroups');
    }
  }
}

// providers/subgroup_provider.dart

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final subGroupProvider = FutureProvider.family<List<SubGroup>, String>((ref, parameter) async {
  final apiService = ref.read(apiServiceProvider);
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (businessId != null && token != null) {
    final subGroupResponse = await apiService.fetchSubGroups(businessId, parameter, token);
    return subGroupResponse.groups;
  } else {
    return [];
  }
});


