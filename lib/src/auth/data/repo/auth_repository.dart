import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:targafy/core/constants/url.dart';
import 'package:targafy/core/utils/print_log.dart';

class AuthRepo {
  static Future<Map<String, dynamic>> login(
      {required String countryCode, required String phone}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({
        "contactNumber": {
          "countryCode": countryCode,
          "number": phone,
        }
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      PrintLog.printLog(response.body);
      return jsonDecode(response.body);
    } else {
      PrintLog.printLog(response.body);
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
      {required String countryCode,
      required String phone,
      required String otp}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verifyotp'),
      body: jsonEncode({
        "otp": otp,
        "contactNumber": {"countryCode": countryCode, "number": phone}
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      PrintLog.printLog(response.body);
      return jsonDecode(response.body);
    } else {
      PrintLog.printLog(response.body);
      throw Exception('Failed to verify otp');
    }
  }
}
