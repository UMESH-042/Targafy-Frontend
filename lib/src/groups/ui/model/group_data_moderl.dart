// // lib/models/group_model.dart
class GroupDataModel {
  final String name;
  final String id;

  GroupDataModel({
    required this.name,
    required this.id,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(id: json['_id'], name: json['name']);
  }
}
