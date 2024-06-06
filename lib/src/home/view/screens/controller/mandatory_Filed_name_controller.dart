import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final nameControllerProvider =
    StateNotifierProvider<NameController, NameState>((ref) {
  return NameController();
});

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
      Uri.parse('http://13.234.163.59:5000/api/v1/user/update/name/$name'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);
      state = NameState(isFirstTime: false, name: name);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update name');
    }
  }
}

class SharedPreferenceService {
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
