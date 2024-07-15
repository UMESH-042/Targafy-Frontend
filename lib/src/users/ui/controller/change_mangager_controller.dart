import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final changeManagerProvider =
    StateNotifierProvider<ChangeManagerController, AsyncValue<void>>((ref) {
  return ChangeManagerController();
});

class ChangeManagerController extends StateNotifier<AsyncValue<void>> {
  ChangeManagerController() : super(const AsyncData(null));

  Future<void> changeManager(
      String businessId, String userId, String newParentId) async {
    final url =
        'http://13.234.163.59/api/v1/business/change-manager/$businessId/$userId?newParentId=$newParentId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    try {
      state = const AsyncLoading();
      final response = await http.patch(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        state = const AsyncData(null);
      } else {
        state = AsyncError('Failed to change manager', StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
