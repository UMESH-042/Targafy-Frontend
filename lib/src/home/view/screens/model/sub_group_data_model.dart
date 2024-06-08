// sub_group_data_model.dart
class SubGroupData {
  final List<List<dynamic>> userEntries;
  final List<List<dynamic>> dailyTarget;

  SubGroupData({required this.userEntries, required this.dailyTarget});

  factory SubGroupData.fromJson(Map<String, dynamic> json) {
    return SubGroupData(
      userEntries: List<List<dynamic>>.from(
          json['userEntries'].map((x) => List<dynamic>.from(x))),
      dailyTarget: List<List<dynamic>>.from(
          json['dailyTarget'].map((x) => List<dynamic>.from(x))),
    );
  }
}
