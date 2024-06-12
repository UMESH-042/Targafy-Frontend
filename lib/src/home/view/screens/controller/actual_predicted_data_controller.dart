import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final dataAddedControllerProvider =
    Provider<DataAddedController>((ref) => DataAddedController());

class DataAddedController {
  Future<Map<String, List<List<dynamic>>>> fetchDataAdded(
      String businessId, String parameter) async {
    final String url = '${domain}data/get-param-data/$businessId/$parameter';
    final authToken = await _getAuthToken(); // Get the auth token

    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> data = responseData['data'];
          final List<List<dynamic>> userEntries = data['userEntries'] != null
              ? List<List<dynamic>>.from(data['userEntries'])
              : [];
          final List<List<dynamic>> dailyTarget = data['dailyTarget'] != null
              ? List<List<dynamic>>.from(data['dailyTarget'])
              : [];
          return {'userEntries': userEntries, 'dailyTarget': dailyTarget};
        }
      }
    } catch (e) {
      print('Error fetching growth data: $e');
    }
    return {'userEntries': [], 'dailyTarget': []};
  }
}

// Function to get the auth token
Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}
