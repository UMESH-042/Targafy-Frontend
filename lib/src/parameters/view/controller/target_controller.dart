import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';



class TargetNotifier extends StateNotifier<AsyncValue<Map<String, int>>> {
  TargetNotifier() : super(const AsyncValue.loading());

  Future<void> fetchTargets(String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse('http://13.234.163.59:5000/api/v1/target/get-target-values/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final targetData = data['data'] as List<dynamic>;

        Map<String, int> targetValues = {};
        for (var target in targetData) {
          targetValues[target['targetName']] = target['totalTargetValue'];
        }

        // Print the fetched target values for debugging
        print('Fetched target values: $targetValues');

        state = AsyncValue.data(targetValues);
      } else {
        state = AsyncValue.error('Failed to load target values', StackTrace.current);
      }
    } catch (e) {
      print('Error fetching target values: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

}


final parameterProvider = StateNotifierProvider<ParameterNotifier, List<Parameter>>((ref) {
  return ParameterNotifier();
});

final targetProvider = StateNotifierProvider.family<TargetNotifier, AsyncValue<Map<String, int>>, String>((ref, businessId) {
  return TargetNotifier()..fetchTargets(businessId);
});


