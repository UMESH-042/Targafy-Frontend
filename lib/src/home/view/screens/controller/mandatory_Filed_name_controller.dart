import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/utils/remote_routes.dart';

final nameControllerProvider =
    StateNotifierProvider<NameController, NameState>((ref) {
  return NameController();
});

String domain = AppRemoteRoutes.baseUrl;

class NameState {
  final bool isFirstTime;
  final String name;

  NameState({required this.isFirstTime, required this.name});
}

class NameController extends StateNotifier<NameState> {
  NameController() : super(NameState(isFirstTime: true, name: ''));

  Future<void> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    state = NameState(isFirstTime: isFirstTime, name: state.name);
  }

  Future<void> updateName(String name) async {
    final token = await SharedPreferenceService().getAuthToken();
    final response = await http.patch(
      Uri.parse('${domain}user/update/name/$name'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);
      final responseData = jsonDecode(response.body);
      final newAuthToken = responseData['data']['authToken'];
      await _storeAuthToken(newAuthToken);
      state = NameState(isFirstTime: false, name: name);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update name');
    }
  }

  Future<void> _storeAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
    await prefs.setString('authToken', token);
    await prefs.setInt('expiryTime', expiryTime);
    print('New auth token has been set: $token');
  }
}

class SharedPreferenceService {
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
