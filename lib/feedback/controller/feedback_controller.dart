import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final apiProvider = Provider((ref) => ApiService());

class ApiService {
  Future<bool> submitFeedback({
    required String businessId,
    required String userId,
    required double rating,
    required String message,
    required bool isAnonymous,
    required String userName,
  }) async {
    try {
      // Construct the API URL
      final apiUrl = Uri.parse(
          'http://13.234.163.59/api/v1/business/rate/user/$businessId/$userId?isAnonymous=$isAnonymous&isFeedback=true');

      // Construct the request body
      final body = jsonEncode({
        "rating": rating.toString(),
        "message": message,
        "userName": userName,
      });
      print('this is the userName $userName');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      // Make the POST request
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return true; // Request succeeded
      } else {
        // Handle errors here if needed
        print('API request failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error submitting feedback: $e');
      return false;
    }
  }
}
