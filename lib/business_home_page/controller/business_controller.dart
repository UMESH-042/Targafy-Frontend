import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final businessAndUserProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>?, String>((ref, token) async* {
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString('authToken');
  print('this is the token for drawer:- $token');

  while (true) {
    final response = await http.get(
      Uri.parse('${domain}business/get-business-details'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List businesses = data['data']['businesses'];
      final user = data['data']['user'];

      // print('Fetched User: $user');
      // print('Fetched Businesses: $businesses');

      yield {
        'businesses': businesses.map((e) => Business.fromJson(e)).toList(),
        'user': User.fromJson(user),
      };
    } else if (response.statusCode == 400) {
      final data = json.decode(response.body);
      final List businesses = data['data']['businesses'];
      final user = data['data']['user'];

      // print('Fetched User: $user');
      // print('Fetched Businesses: $businesses');

      yield {
        'businesses': businesses.map((e) => Business.fromJson(e)).toList(),
        'user': User.fromJson(user),
      };
    } else {
      throw Exception('Failed to fetch business details');
    }

    await Future.delayed(const Duration(seconds: 4));
  }
});

final currentBusinessProvider =
    StateProvider<Map<String, dynamic>?>((ref) => null);

Future<void> selectBusiness(Business business, String userType,
    String businessCode, WidgetRef ref) async {
  // final selectedBusinessData = {
  //   'business': business,
  //   'userType': userType,
  //   'businessCode': businessCode,
  // };
  final Map<String, dynamic> selectedBusinessData = {
    'business': Business(
        id: business.id,
        businessCode: business.businessCode,
        name: business.name,
        logo: business.logo,
        industryType: business.industryType,
        city: business.city,
        country: business.country,
        createdDate: business.createdDate),
    'userType': userType,
    'businessCode': businessCode,
  };

  ref.read(currentBusinessProvider.state).state = selectedBusinessData;
}

Future<void> clearSelectedBusiness(WidgetRef ref) async {
  final Map<String, dynamic> selectedBusinessData = {
    'business': Business(
        id: '',
        businessCode: '',
        name: '',
        logo: '',
        industryType: '',
        city: '',
        country: '',
        createdDate: DateTime.now()),
    'userType': '',
    'businessCode': '',
  };
  // ref.read(currentBusinessProvider.notifier).state = selectedBusinessData;
  ref.read(currentBusinessProvider.notifier).state = null;
}
