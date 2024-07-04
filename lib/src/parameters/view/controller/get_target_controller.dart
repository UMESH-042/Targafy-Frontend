import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:targafy/src/parameters/view/model/target_data_model.dart';

final targetDataControllerProvider =
    StateNotifierProvider<TargetDataController, AsyncValue<List<TargetData>>>(
        (ref) {
  return TargetDataController();
});

class TargetDataController extends StateNotifier<AsyncValue<List<TargetData>>> {
  TargetDataController() : super(const AsyncLoading());

  Future<List<TargetData>> fetchThreeMonthsData(
      String userId, String businessId, String parameterName) async {
    final url = Uri.parse(
        'http://13.234.163.59/api/v1/data/get-three-months-data/$userId/$businessId/$parameterName');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Replace with your actual token
        },
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];

        // Convert responseData to List<TargetData>
        final List<TargetData> targets = responseData.map((json) {
          // Ensure each field is converted to string if it's not already
          final month = json['month'].toString();
          final targetValue = json['targetValue'].toString();
          final targetDone = json['targetDone'].toString();

          return TargetData(
            month: month,
            targetValue: targetValue,
            targetDone: targetDone,
          );
        }).toList();

        print('Converted targets: $targets');

        state = AsyncData(targets); // Update state with fetched data
        return targets; // Return the fetched targets
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current); // Update state with error
      throw Exception('Network error: $error');
    }
  }

  Future<void> updateTarget(String userId, String parameterName,
      String monthIndex, String comment, String newTargetValue,String businessId) async {
    final url = Uri.parse(
        'http://13.234.163.59/api/v1/target/update-user-target/$businessId/$parameterName');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'monthIndex': monthIndex,
          'comment': comment,
          'newTargetValue': newTargetValue,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print('Target updated successfully');
        // Optionally, you can fetch updated data after successful update
        // ref.read(fetchThreeMonthsDataProvider).fetchThreeMonthsData(userId, businessId, parameterName);
      } else {
        throw Exception('Failed to update target: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}
