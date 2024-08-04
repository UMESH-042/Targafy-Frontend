import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final departmentProvider =
    FutureProvider.family<List<Department>, String>((ref, businessId) async {
  final url = '${domain}department/get/$businessId';
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data']['departments'] as List;
    return data.map((json) => Department.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load departments');
  }
});

class Department {
  final String name;
  final String id;

  Department({required this.name, required this.id});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json['name'],
      id: json['id'],
    );
  }
}
