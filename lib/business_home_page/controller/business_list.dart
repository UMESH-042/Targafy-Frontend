import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';

final businessListProvider = StateNotifierProvider<BusinessListNotifier, List<Business>>((ref) => BusinessListNotifier());

class BusinessListNotifier extends StateNotifier<List<Business>> {
  BusinessListNotifier() : super([]);

  void updateBusinessList(List<Business> newList) {
    state = newList;
  }
}
