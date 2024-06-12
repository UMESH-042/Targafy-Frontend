// // lib/controllers/group_controller.dart
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
// import 'package:targafy/src/groups/ui/model/create_group_model.dart';

// final groupControllerProvider = Provider<GroupController>((ref) {
//   return GroupController();
// });

// class GroupController {
//   Future<void> createGroup(
//       GroupModel group, String businessId, String token) async {
//     final url =
//         Uri.parse('http://13.234.163.59:5000/api/v1/group/create/$businessId');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     // final body = json.encode(group.toJson());

//     final response = await http.post(
//       url,
//       headers: headers,
//       body: json.encode({
//         'groupName': group.groupName,
//         'logo': group.logo,
//         'usersIds': group.usersIds
//       }),
//     );
//     print(group.groupName);
//     print(group.logo);
//     print(group.usersIds);

//     if (response.statusCode == 201) {
//       print('Group Created Successfully');
//     } else {
//       throw Exception('Failed to create group: ${response.body}');
//     }
//   }

//   Future<String> uploadLogo(File image, String? token) async {
//     final url = Uri.parse('http://13.234.163.59:5000/api/v1/upload/file');
//     final mimeType = lookupMimeType(image.path);

//     final request = http.MultipartRequest('POST', url)
//       ..fields['folder'] = 'chats'
//       ..files.add(await http.MultipartFile.fromPath(
//         'file',
//         image.path,
//         contentType: MediaType.parse(mimeType!),
//       ));
//     final response = await request.send();

//     if (response.statusCode == 200) {
//       final responseBody = await response.stream.bytesToString();
//       final responseData = json.decode(responseBody);
//       return responseData['data']['fileUrl'];
//     } else {
//       throw Exception('Failed to upload image: ${response.statusCode}');
//     }
//   }
// }

// lib/src/groups/controller/group_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

final groupControllerProvider = Provider((ref) => GroupController());

String domain = AppRemoteRoutes.baseUrl;

class GroupController {
  Future<String> uploadLogo(File image) async {
    final url = Uri.parse('${domain}upload/file');
    final mimeType = lookupMimeType(image.path);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final request = http.MultipartRequest('POST', url)
      ..fields['folder'] = 'chats'
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

  Future<void> updateGroupLogo(
      String groupId, String businessId, String logoUrl) async {
    final url = Uri.parse('${domain}group/update-logo/$groupId/$businessId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'logo': logoUrl,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update group logo: ${response.statusCode}');
    }
  }
}
