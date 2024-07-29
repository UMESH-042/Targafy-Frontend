// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ParamPair {
//   final String firstSelectedItem;
//   final String secondSelectedItem;
//   final List<String> values;

//   ParamPair(
//       {required this.firstSelectedItem,
//       required this.secondSelectedItem,
//       required this.values});

//   factory ParamPair.fromJson(List<dynamic> json) {
//     return ParamPair(
//       firstSelectedItem: json[0] as String,
//       secondSelectedItem: json[1] as String,
//       values: List<String>.from(json[2].map((item) => item['value'] as String)),
//     );
//   }
// }

// class ParamRepository {
//   final String baseUrl = 'http://13.234.163.59/api/v1/params/get-typeBParams/';

//   ParamRepository();

//   Future<List<ParamPair>> fetchParamPairs(String businessId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final response = await http.get(
//       Uri.parse('$baseUrl$businessId'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     print(response.body);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body)['data']['paramPairs'];
//       return List<ParamPair>.from(data.map((item) => ParamPair.fromJson(item)));
//     } else {
//       throw Exception('Failed to load param pairs');
//     }
//   }
// }

// final paramRepositoryProvider = Provider<ParamRepository>((ref) {
//   return ParamRepository();
// });

// final paramPairsProvider =
//     FutureProvider.family<List<ParamPair>, String>((ref, businessId) {
//   final repository = ref.watch(paramRepositoryProvider);
//   return repository.fetchParamPairs(businessId);
// });

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class ParamPair {
//   final String firstSelectedItem;
//   final String secondSelectedItem;
//   final List<String> values;

//   ParamPair({
//     required this.firstSelectedItem,
//     required this.secondSelectedItem,
//     required this.values,
//   });

//   factory ParamPair.fromJson(List<dynamic> json) {
//     return ParamPair(
//       firstSelectedItem: json[0] as String? ?? '',
//       secondSelectedItem: json[1] as String? ?? '',
//       values: (json[2] as List<dynamic>?)
//               ?.map((item) => item['value'] as String? ?? '')
//               .toList() ??
//           [],
//     );
//   }
// }
class ParamPair {
  final String id;
  final String firstSelectedItem;
  final String secondSelectedItem;
  final List<String> values;

  ParamPair({
    required this.id,
    required this.firstSelectedItem,
    required this.secondSelectedItem,
    required this.values,
  });

  factory ParamPair.fromJson(List<dynamic> json) {
    return ParamPair(
      id: json[0] as String? ?? '',
      firstSelectedItem: json[1] as String? ?? '',
      secondSelectedItem: json[2] as String? ?? '',
      values: (json[3] as List<dynamic>?)
              ?.map((item) => item['value'] as String? ?? '')
              .toList() ??
          [],
    );
  }
}

class ParamRepository {
  final String baseUrl =
      'http://13.234.163.59/api/v1/params/get-typeBParams-new/';

  ParamRepository();

  Future<List<ParamPair>> fetchParamPairs(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('Auth token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.body.isEmpty) {
      throw Exception('Response body is empty');
    }

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData == null ||
          jsonData['data'] == null ||
          jsonData['data']['paramPairs'] == null) {
        return [];
      }

      final data = jsonData['data']['paramPairs'] as List<dynamic>;
      return data
          .map((item) => ParamPair.fromJson(item as List<dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load param pairs');
    }
  }

  Future<void> deleteParamPair(String businessId, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('Auth token is null');
    }

    final response = await http.delete(
      Uri.parse('http://13.234.163.59/api/v1/params/delete-typeBParams/$businessId/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete parameter pair');
    }
  }
}

final paramRepositoryProvider = Provider<ParamRepository>((ref) {
  return ParamRepository();
});

final paramControllerProvider = Provider((ref) {
  final paramRepository = ref.watch(paramRepositoryProvider);
  return ParamController(paramRepository);
});

class ParamController {
  final ParamRepository _paramRepository;

  ParamController(this._paramRepository);

  Future<void> deleteParamPair(String businessId, String id) async {
    try {
      await _paramRepository.deleteParamPair(businessId, id);
      // Notify the user or handle success
    } catch (e) {
      // Handle error, show message to user
      print('Error deleting parameter pair: $e');
    }
  }
}

// final paramPairsProvider =
//     FutureProvider.family<List<ParamPair>, String>((ref, businessId) {
//   final repository = ref.watch(paramRepositoryProvider);
//   return repository.fetchParamPairs(businessId);
// });
