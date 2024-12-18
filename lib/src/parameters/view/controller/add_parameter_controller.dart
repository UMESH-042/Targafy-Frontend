// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// final parameterProvider =
//     StateNotifierProvider<ParameterNotifier, AsyncValue<void>>((ref) {
//   return ParameterNotifier();
// });

// class ParameterNotifier extends StateNotifier<AsyncValue<void>> {
//   ParameterNotifier() : super(const AsyncValue.data(null));

//   Future<bool> addParameter(
//       String businessId,
//       String parameterName,
//       List<String> userId,
//       String chartType,
//       String duration,
//       String description) async {
//     state = const AsyncValue.loading();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       // print(token);
//       // print(businessId);
//       // print(userId);
//       // print(parameterName);
//       // print(chartType);
//       // print(duration);

//       final response = await http.post(
//         Uri.parse('http://13.234.163.59:5000/api/v1/params/add/$businessId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'name': parameterName,
//           'charts': chartType,
//           'duration': duration,
//           'description': description,
//           'userIds': userId,
//         }),
//       );
//       if (response.statusCode == 201) {
//         state = const AsyncValue.data(null);
//         print("Success");
//         return true;
//       } else {
//         print("${response.statusCode} no Success");
//         state =
//             AsyncValue.error('Failed to submit parameter', StackTrace.current);
//         return false;
//       }
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);
//       return false;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final parameterNotifierProvider =
    StateNotifierProvider<ParameterNotifier, List<Parameter>>((ref) {
  return ParameterNotifier();
});

class ParameterNotifier extends StateNotifier<List<Parameter>> {
  ParameterNotifier() : super([]);

  Future<void> fetchParameters(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse('${domain}params/get/assigned-parameter/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      state = data.map((json) => Parameter.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parameters');
    }
  }

  Future<List<String>> fetchParameterNames(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse('${domain}params/get/assigned-parameter/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      // Extract parameter names from the response
      List<String> parameterNames =
          data.map((param) => param['name'].toString()).toList();
      return parameterNames;
    } else {
      throw Exception('Failed to load parameters');
    }
  }

  Future<bool> addParameter(
      String businessId,
      String parameterName,
      List<String> departmentIds,
      String description,
      BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.post(
      Uri.parse('${domain}params/add/$businessId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': parameterName,
        'description': description,
        'departmentIds': departmentIds,
      }),
    );
    print(parameterName);
    print(description);
    print(departmentIds);
    print(response.body);

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String errorMessage =
          responseBody['message'] ?? 'Failed to add parameter';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
      return false;
    }
  }
}

// StateNotifier to manage the state of the parameters
class ParametersNotifierHome extends StateNotifier<List<Parameter2>> {
  ParametersNotifierHome() : super([]);

  Future<void> fetchParametersforHome(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse('${domain}params/get-param-id/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['params'] as List;
      state = data.map((json) => Parameter2.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parameters');
    }
  }

  Future<void> fetchParametersforHomeDepartment(
      String businessId, String departmentId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse('${domain}department/get-params/$businessId/$departmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print('This is response for department parameters :- ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      state = data.map((json) => Parameter2.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parameters');
    }
  }
}

// Create a provider for the ParametersNotifier
final parametersProviderHome =
    StateNotifierProvider<ParametersNotifierHome, List<Parameter2>>((ref) {
  return ParametersNotifierHome();
});
