import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/api%20repository/api_http_response.dart';
import 'package:targafy/api%20repository/product_repository.dart';
import 'package:targafy/src/auth/view/screens/login_screen.dart';
import 'package:targafy/src/auth/view/screens/verify_login_otp.dart';
import 'package:targafy/src/services/shared_preference_service.dart';
import 'package:targafy/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/utils/utils.dart';

String domain = AppRemoteRoutes.baseUrl;

class LoginState {
  final String countryCode;
  final String number;
  final String otpCode;
  final String accessToken;
  final bool isRequestSent;
  final bool codeSentDone;
  final bool isSendingOTP;
  final bool isError;

  LoginState({
    this.countryCode = "+91",
    this.number = "",
    this.otpCode = "",
    this.accessToken = "",
    this.isRequestSent = false,
    this.codeSentDone = false,
    this.isSendingOTP = false,
    this.isError = false,
  });

  LoginState copyWith({
    String? countryCode,
    String? number,
    String? otpCode,
    String? accessToken,
    bool? isRequestSent,
    bool? codeSentDone,
    bool? isSendingOTP,
    bool? isError,
  }) {
    return LoginState(
      countryCode: countryCode ?? this.countryCode,
      number: number ?? this.number,
      otpCode: otpCode ?? this.otpCode,
      accessToken: accessToken ?? this.accessToken,
      isRequestSent: isRequestSent ?? this.isRequestSent,
      codeSentDone: codeSentDone ?? this.codeSentDone,
      isSendingOTP: isSendingOTP ?? this.isSendingOTP,
      isError: isError ?? this.isError,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void updateCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  void updateNumber(String number) {
    state = state.copyWith(number: number);
  }

  void updateOtpCode(String otp) {
    state = state.copyWith(otpCode: otp);
  }

  Future<bool> login(BuildContext context) async {
    debugPrint("Number ${state.number}");

    if (state.number.isNotEmpty && state.number.length == 10) {
      String res = await sendLoginRequest();

      if (res == "Login request sent successfully") {
        debugPrint("Done");
        // GoRouter.of(context).pushNamed(MyAppRouteConstants.verifyRouteName);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VerifyOTPScreen()));
        return true;
      } else {
        showSnackBar(context, res, Colors.red);
        return false;
      }
    } else {
      showSnackBar(
          context, "Please enter a valid contact number", invalidColor);
      return false;
    }
  }

  Future<String> sendLoginRequest() async {
    String res = "Some error occurred";
    ApiHttpResponse response = await callPostMethod(
      {
        "contactNumber": {
          "countryCode": state.countryCode,
          "number": state.number,
        },
      },
      "auth/login",
    );

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      state = state.copyWith(isRequestSent: true);
      res = "Login request sent successfully";
    } else {
      res = data["message"];
    }

    return res;
  }

  Future<bool> verifyLoginOtp(BuildContext context) async {
    if (state.number.isNotEmpty && state.number.length == 10) {
      String res = await verifyLoginOtpRequest();

      if (res == "Login request for verification sent successfully") {
        await _storeAuthToken(state.accessToken);
        SharedPreferenceService().setLogin(state.accessToken);
        debugPrint("Done");
        return true;
      } else {
        showSnackBar(context, res, Colors.red);
        return false;
      }
    } else {
      showSnackBar(
          context, "Please enter a valid contact number", invalidColor);
      return false;
    }
  }

  Future<String> verifyLoginOtpRequest() async {
    String res = "Some error occurred";
    try {
      ApiHttpResponse response = await callPostMethod(
        {
          "otp": state.otpCode,
          "contactNumber": {
            "countryCode": state.countryCode,
            "number": state.number,
          },
        },
        "auth/verifyotp",
      );

      final data = jsonDecode(response.responceString!);

      debugPrint("This is data : $data");

      if (response.responseCode == 200) {
        state = state.copyWith(accessToken: data["data"]["authToken"]);
        debugPrint(state.accessToken);
        res = "Login request for verification sent successfully";
      } else {
        res = data["message"];
      }
    } catch (e) {
      debugPrint("Error during OTP verification: $e");
      res = "Failed to verify OTP. Please try again.";
    }
    return res;
  }

  Future<void> _storeAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
    await prefs.setString('authToken', token);
    await prefs.setInt('expiryTime', expiryTime);
  }

  Future<bool> _isAuthTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime = prefs.getInt('expiryTime') ?? 0;
    return DateTime.now().millisecondsSinceEpoch < expiryTime;
  }

  Future<void> checkAndUpdateAuthToken(BuildContext context) async {
    if (!await _isAuthTokenValid()) {
      showSnackBar(
          context, "Session expired. Please log in again.", Colors.red);
      // Navigate to login screen or handle re-login logic
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<bool> checkBusinessExists() async {
    final token = await _getAuthToken();
    if (token == null) {
      debugPrint('Authentication token not found');
      return false;
    }

    final url = '${domain}business/checkBusiness';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'];
    } else {
      debugPrint('Failed to check business existence: ${response.body}');
      return false;
    }
  }

  bool isEligibleToLogin(bool tnc) {
    return state.number.isNotEmpty && state.number.length == 10 && tnc;
  }

  Future<void> logout(BuildContext context) async {
    try {
      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      await prefs.remove('expiryTime');

      // Verify removal
      String? authToken = prefs.getString('authToken');
      int? expiryTime = prefs.getInt('expiryTime');

      if (authToken == null && expiryTime == null) {
        debugPrint("AuthToken and ExpiryTime successfully removed.");
      } else {
        debugPrint("Failed to remove AuthToken or ExpiryTime.");
      }

      // Reset state to initial state
      state = LoginState();

      // Navigate to login screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      debugPrint("Error during logout: $e");
      // Optionally show a snack bar with the error
      showSnackBar(context, "Failed to log out. Please try again.", Colors.red);
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
