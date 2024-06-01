// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/parameters/view/model/parameter_model.dart';

// // Update the provider to accept businessId as a parameter
// final parameterListProvider = FutureProvider.family<List<Parameter>, String>((ref, businessId) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authToken');

//   final response = await http.get(
//     Uri.parse('http://13.234.163.59:5000/api/v1/params/get/assigned-parameter/$businessId'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body)['data'] as List;
//     return data.map((json) => Parameter.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load parameters');
//   }
// });
