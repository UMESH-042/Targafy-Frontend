import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';

// Provider to fetch auth token from shared preferences
final authTokenProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken');
});

// Provider to fetch business and user details
final businessAndUserProvider =
    StreamProvider<Map<String, dynamic>>((ref) async* {
  final token = await ref.watch(authTokenProvider.future);
  if (token == null) throw Exception('No token found');

  while (true) {
    final response = await http.get(
      Uri.parse(
          'http://13.234.163.59:5000/api/v1/business/get-business-details'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List businesses = data['data']['businesses'];
      final user = data['data']['user'];

      yield {
        'businesses': businesses.map((e) => Business.fromJson(e)).toList(),
        'user': User.fromJson(user),
      };
    } else {
      throw Exception('Failed to fetch business details');
    }

    // Wait for a short duration before fetching data again
    await Future.delayed(
        Duration(seconds: 3)); // Adjust the duration as needed
  }
});

// Provider to track the currently selected business and userType
final currentBusinessProvider =
    StateProvider<Map<String, dynamic>?>((ref) => null);

// Function to update the currently selected business and userType
Future<void> selectBusiness(Business business, String userType,
    String businessCode, WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final selectedBusinessData = {
    'business': business.toJson(),
    'userType': userType,
    'businessCode': businessCode,
  };

  await prefs.setString(
      'selectedBusinessData', json.encode(selectedBusinessData));
  ref.read(currentBusinessProvider.state).state = selectedBusinessData;
}

// Function to load the selected business from shared preferences
Future<void> loadSelectedBusiness(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final selectedBusinessDataString = prefs.getString('selectedBusinessData');

  if (selectedBusinessDataString != null) {
    final Map<String, dynamic> data = json.decode(selectedBusinessDataString);
    final business = Business.fromJson(data['business']);
    ref.read(currentBusinessProvider.state).state = {
      'business': business,
      'userType': data['userType'] as String,
      'businessCode': data['businessCode'] as String,
    };
  }
}
