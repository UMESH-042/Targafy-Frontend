import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final userAvatarProvider =
    FutureProvider.family<String, String>((ref, userId) async {
  final url =
      Uri.parse('http://13.234.163.59/api/v1/user/get-user-avatar/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['data']['avatar'];
  } else {
    throw Exception('Failed to load avatar');
  }
});
