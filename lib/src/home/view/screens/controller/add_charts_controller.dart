import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';

final addChartsControllerProvider = Provider<AddChartsController>((ref) {
  return AddChartsController(ref);
});

class AddChartsController {
  final ProviderRef ref;
  AddChartsController(this.ref);

  Future<void> savePairs(
      String businessId, List<DropdownFieldPair> pairs) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url =
        'http://13.234.163.59/api/v1/params/create-typeBParam/$businessId';

    for (var pair in pairs) {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'paramName1': pair.firstSelectedItem,
          'paramName2': pair.secondSelectedItem,
          'benchMarks': pair.benchMarks,
        }),
      );
      print(response.body);
      if (response.statusCode != 201) {
        throw Exception('Failed to save pair');
      }
    }
  }
}




