// lib/controllers/group_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/groups/ui/model/create_sub_group_model.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final SubgroupControllerProvider = Provider<SubGroupController>((ref) {
  return SubGroupController();
});

class SubGroupController {
  Future<void> createSubGroup(SubGroupModel subgroup, String parentGroupId,
      String token, String businessId) async {
    final url = Uri.parse('${domain}groups/create-subgroups/$businessId');
    print('This is ParentGroupId :- $parentGroupId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // final body = json.encode(group.toJson());

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'groupName': subgroup.groupName,
        'userIds': subgroup.usersIds,
        'parentGroupId': parentGroupId,
      }),
    );
    print(subgroup.groupName);
    // print(subgroup.logo);
    print(subgroup.usersIds);
    print(response.body);
    if (response.statusCode == 201) {
      print('Sub Group Created Successfully');
    } else {
      throw Exception('Failed to create group: ${response.body}');
    }
  }

  Future<String> uploadLogo(File image, String? token) async {
    final url = Uri.parse('${domain}upload/file');
    final mimeType = lookupMimeType(image.path);

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
}

final BusinessLogoControllerProvider = Provider<BusinessLogoController>((ref) {
  return BusinessLogoController();
});

class BusinessLogoController {
  Future<String> uploadLogo(File image) async {
    final url = Uri.parse('${domain}upload/file');
    final mimeType = lookupMimeType(image.path);

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

  Future<void> updateBusinessLogo(String businessId, String logoUrl) async {
    final updateUrl = Uri.parse('${domain}business/update/logo/$businessId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({'logo': logoUrl});
    print('this is business logo url :- $logoUrl');

    final response = await http.put(updateUrl, headers: headers, body: body);
    if (response.statusCode != 200) {
      print(response);
      throw Exception('Failed to update business logo: ${response.statusCode}');
    }
  }

  Future<String> fetchBusinessLogo(String businessId) async {
    final fetchUrl =
        Uri.parse('${domain}business/requests/user-business-logo/$businessId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(fetchUrl, headers: headers);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['data']['logo'];
    } else {
      throw Exception('Failed to fetch business logo: ${response.statusCode}');
    }
  }
}
