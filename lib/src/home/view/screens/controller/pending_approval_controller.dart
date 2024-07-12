import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final pendingBusinessProvider =
    FutureProvider.family<List<PendingBusiness>, String>((ref, token) async {
  final response = await http.get(
    Uri.parse('http://13.234.163.59/api/v1/business/check-approvalBusiness'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List data = json.decode(response.body)['data'];
    return data.map((json) => PendingBusiness.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch pending business requests');
  }
});

class PendingBusiness {
  final String businessId;
  final String businessName;

  PendingBusiness({required this.businessId, required this.businessName});

  factory PendingBusiness.fromJson(Map<String, dynamic> json) {
    return PendingBusiness(
      businessId: json['businessId'],
      businessName: json['businessName'],
    );
  }
}
