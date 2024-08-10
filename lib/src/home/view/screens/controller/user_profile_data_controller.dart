import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/model/user_business_model_drawer.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final userProvider = FutureProvider<User>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  if (token == null) {
    throw Exception('No token found');
  }

  final response = await http.get(
    Uri.parse('${domain}user/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return User.fromJson(data);
  } else {
    throw Exception('Failed to fetch user data');
  }
});

final userProfileLogoControllerProvider =
    Provider<UserProfileLogoController>((ref) {
  return UserProfileLogoController();
});

class UserProfileLogoController {
  Future<String> uploadLogo(File image) async {
    final url = Uri.parse('${domain}upload/file');
    final mimeType = lookupMimeType(image.path);

    final request = http.MultipartRequest('POST', url)
      ..fields['folder'] = 'userprofile'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
        contentType: MediaType.parse(mimeType!),
      ));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);
      return responseData['data']['fileUrl'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> updateUserProfileLogo(String avatarUrl) async {
    final updateUrl = Uri.parse('${domain}user/update/user-avatar');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({'avatar': avatarUrl});
    print('this is user avatar url :- $avatarUrl');
    final response = await http.post(updateUrl, headers: headers, body: body);
    if (response.statusCode != 200) {
      print(response);
      throw Exception(
          'Failed to update user profile logo: ${response.statusCode}');
    }
  }

  Future<String> fetchUserAvatar(String token) async {
    final fetchUrl = Uri.parse('${domain}user/request/user-avatar');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(fetchUrl, headers: headers);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['data']['avatar'];
    } else {
      throw Exception('Failed to fetch user avatar: ${response.statusCode}');
    }
  }
}
