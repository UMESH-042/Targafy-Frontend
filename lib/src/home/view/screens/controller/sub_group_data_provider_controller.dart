import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SubGroupDataControllerProvider =
    Provider<SubGroupDataController>((ref) => SubGroupDataController());

class SubGroupDataController {
  Future<Map<String, List<List<dynamic>>>> fetchDataAdded(
      String businessId, String groupId, String groupName) async {
    final String url =
        'http://13.234.163.59:5000/api/v1/group/get-level-data/$businessId/$groupId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'groupName': groupName}),
      );
      print('This is groupId:-$groupId');
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
