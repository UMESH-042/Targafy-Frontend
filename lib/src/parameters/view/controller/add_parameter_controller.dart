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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';

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
      Uri.parse(
          'http://13.234.163.59:5000/api/v1/params/get/assigned-parameter/$businessId'),
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
      Uri.parse(
          'http://13.234.163.59:5000/api/v1/params/get/assigned-parameter/$businessId'),
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
      List<String> userId,
      String chartType,
      String duration,
      String description) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final response = await http.post(
      Uri.parse('http://13.234.163.59:5000/api/v1/params/add/$businessId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': parameterName,
        'charts': chartType,
        'duration': duration,
        'description': description,
        'userIds': userId,
      }),
    );

    if (response.statusCode == 201) {
      // Refresh the parameter list after adding a new parameter
      await fetchParameters(businessId);
      return true;
    } else {
      return false;
    }
  }
}





// class Parameter {
//   final String name;
//   // Add other fields as necessary

//   Parameter({required this.name});

//   factory Parameter.fromJson(Map<String, dynamic> json) {
//     return Parameter(
//       name: json['name'],
//       // Initialize other fields as necessary
//     );
//   }
// }


