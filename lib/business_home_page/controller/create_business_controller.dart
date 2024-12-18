import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

class CreateBusinessController {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

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

  Future<void> createBusiness({
    required String buisnessName,
    required String logo,
    required String industryType,
    required String city,
    required String country,
    required Function(bool isSuccess) onCompletion,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      // Handle token not found
      return;
    }

    final url = '${domain}business/create';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final businessData = {
      'businessName': buisnessName,
      'logo': logo,
      'industryType': industryType,
      'city': city,
      'country': country,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(businessData),
    );

    if (response.statusCode == 201) {
      // final data = jsonDecode(response.body);
      print("Success");
      // Handle successful response
      onCompletion(true); // Invoke callback with failure status
    } else {
      // Handle error
      print("Error: ${response.statusCode}");
      onCompletion(false); // Invoke callback with success status
    }
  }
}
//   Future<Map<String, dynamic>?> createBusiness({
//     required String buisnessName,
//     required String logo,
//     required String industryType,
//     required String city,
//     required String country,
//   }) async {
//     final token = await _getAuthToken();
//     if (token == null) {
//       // Handle token not found
//       return null;
//     }

//     final url = '${domain}business/create';
//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };

//     final businessData = {
//       'businessName': buisnessName,
//       'logo': logo,
//       'industryType': industryType,
//       'city': city,
//       'country': country,
//     };
//     print('This is BusinessName :- $businessData');

//     final response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonEncode(businessData),
//     );

//     if (response.statusCode == 201) {
//       final data = jsonDecode(response.body);
//       print(data);
//       return data; // Return the entire response data
//     } else {
//       // Handle error
//       print(response.body);
//       print("Error: ${response.statusCode}");
//       return null;
//     }
//   }
// }
