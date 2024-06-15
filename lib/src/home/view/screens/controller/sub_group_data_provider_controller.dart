import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

final SubGroupDataControllerProvider =
    Provider<SubGroupDataController>((ref) => SubGroupDataController());

String domain = AppRemoteRoutes.baseUrl;

class SubGroupDataController {
  Future<Map<String, List<List<dynamic>>>> fetchDataAdded(
 String groupId, String selectedParameter) async {
    final String url =
        '${domain}group/get-level-data/$groupId/$selectedParameter';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print('This is group Id :- $groupId');
    print('This is SelectedParameter :- $selectedParameter');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('This is groupId:-$groupId');
      print(response.body);
      if (response.statusCode == 200) {
        print('success');
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
