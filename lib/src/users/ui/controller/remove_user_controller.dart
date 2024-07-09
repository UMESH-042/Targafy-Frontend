import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

final removeUserProvider = Provider<RemoveUserService>((ref) {
  return RemoveUserService();
});

String domain = AppRemoteRoutes.baseUrl;

class RemoveUserService {
  Future<void> removeUser(String businessId, String userId) async {
    final url = '${domain}business/remove/user/$businessId/$userId';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Handle success
      print('User removed successfully');
    } else {
      // Handle error
      print('Failed to remove user');
    }
  }
}
