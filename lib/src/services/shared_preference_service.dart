// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferenceService {
//   String logInkey = "LOGIN";
//   String accessTokenKey = "ACCESS_TOKEN";
//   String roleKey = "ROLE";
//   String mandatoryFieldKey = "Mandatory-Field";
//   String selectedBusinessKey = "selected-business";

//   void setLogin(String accessToken) async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setBool(logInkey, true);
//     sp.setString(accessTokenKey, accessToken);
//   }

//   Future<bool> checkLogin() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     return sp.getBool(logInkey) ?? false;
//   }

//   void clearLogin() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     await sp.clear();
//   }

//   Future<String> getAccessToken() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     return sp.getString(accessTokenKey) ?? '';
//   }

//   void setSelectedBusiness(String businessId) async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString(selectedBusinessKey, businessId);
//   }

//   Future<void> clearSelectedBusiness() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     await sp.remove(selectedBusinessKey);
//   }

//   Future<String> getSelectedBusiness() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     return sp.getString(selectedBusinessKey) ?? '';
//   }

// }

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String _authTokenKey = 'authToken';

  Future<void> setLogin(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }
}
