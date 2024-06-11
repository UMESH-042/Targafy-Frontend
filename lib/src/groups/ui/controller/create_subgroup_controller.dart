// lib/controllers/group_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:targafy/src/groups/ui/model/create_sub_group_model.dart';

final SubgroupControllerProvider = Provider<SubGroupController>((ref) {
  return SubGroupController();
});

class SubGroupController {
  Future<void> createSubGroup(
      SubGroupModel subgroup, String parentGroupId, String token) async {
    final url = Uri.parse(
        'http://13.234.163.59:5000/api/v1/group/create-subgroups/$parentGroupId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // final body = json.encode(group.toJson());

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'subgroupName': subgroup.subgroupName,
        'logo': subgroup.logo,
        'usersIds': subgroup.usersIds
      }),
    );
    print(subgroup.subgroupName);
    print(subgroup.logo);
    print(subgroup.usersIds);

    if (response.statusCode == 201) {
      print('Sub Group Created Successfully');
    } else {
      throw Exception('Failed to create group: ${response.body}');
    }
  }

  Future<String> uploadLogo(File image, String? token) async {
    final url = Uri.parse('http://13.234.163.59:5000/api/v1/upload/file');
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
