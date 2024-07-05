import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

final progressDataProvider = FutureProvider.family<Map<String, double>, Tuple2<String, String>>((ref, params) async {
  final businessId = params.item1;
  final selectedMonth = params.item2;
  final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';
  final response = await http.get(
    Uri.parse('http://13.234.163.59/api/v1/data/get-progress-data-param/$businessId/$selectedMonth'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final percentages = jsonData['data']['percentages'] as Map<String, dynamic>;
    return percentages.map((key, value) => MapEntry(key, value.toDouble()));
  } else {
    throw Exception('Failed to fetch progress data');
  }
});