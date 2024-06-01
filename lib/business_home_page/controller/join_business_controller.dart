// controllers/join_business_controller.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/models/business_request.dart';

// Provider to fetch auth token from shared preferences
final authTokenProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken');
});

// Provider to handle join business request
final joinBusinessProvider =
    FutureProvider.family<bool, JoinBusinessRequest>((ref, request) async {
  final token = await ref.watch(authTokenProvider.future);
  if (token == null) throw Exception('No token found');

  final response = await http.post(
    Uri.parse('http://13.234.163.59:5000/api/v1/business/send/request/JMJTKF'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode(request.toJson()),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to join business');
  }
});