import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/api%20repository/product_repository.dart';
import 'package:targafy/src/home/view/screens/model/SubGroup_model.dart';

final subGroupDetailsProvider =
    FutureProvider.family<List<SubOffice>, String>((ref, parentGroupId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  print('this is the parentGroupid for sub offices:- $parentGroupId');

  if (token == null) {
    throw Exception('Bearer token not found');
  }

  final response = await http.get(
    Uri.parse('${domain}office/get-sublevel-office-name/$parentGroupId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final subOffices = (data['data']['suboffices'] as List)
        .map((subOffice) => SubOffice.fromJson(subOffice))
        .toList();
    return subOffices;
  } else {
    print(response.body);
    throw Exception('Failed to fetch subgroup details');
  }
});
