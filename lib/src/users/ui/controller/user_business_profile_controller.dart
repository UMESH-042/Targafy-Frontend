import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'dart:convert';
import 'package:targafy/src/users/ui/model/user_Business_Profile_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final userProvider = FutureProvider.autoDispose
    .family<UserProfileBusinessModel, String>((ref, userId) async {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final selectedBusiness = selectedBusinessData?['business'] as Business?;
  final businessId = selectedBusiness?.id;
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  final url = '${domain}business/user/$businessId/$userId';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization':
          'Bearer $token', // Replace YOUR_TOKEN_HERE with your actual token
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final userData = responseData['data']['user'];
    return UserProfileBusinessModel.fromJson(userData);
  } else {
    throw Exception('Failed to load user details');
  }
});
