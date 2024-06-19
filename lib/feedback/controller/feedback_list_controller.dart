import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart'; // Adjust import as per your project structure
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:targafy/feedback/model/feedback_model.dart';

Stream<List<FeedbackModel>> feedbackStream(Business? selectedBusiness) async* {
  if (selectedBusiness == null) {
    throw StateError('Business ID is null');
  }

  final url =
      'http://13.234.163.59/api/v1/business/get-business-user-rating/${selectedBusiness.id}';
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  while (true) {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data']['usersRatings'];
      final feedbackList = data.map((json) => FeedbackModel.fromJson(json)).toList();
      yield feedbackList;
    } else {
      throw StateError('Failed to load ratings');
    }

    await Future.delayed(Duration(seconds: 2)); // Polling interval
  }
}

final feedbackProvider = StreamProvider.autoDispose<List<FeedbackModel>>(
  (ref) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    return feedbackStream(selectedBusiness);
  },
);
