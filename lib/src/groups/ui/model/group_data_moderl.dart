// lib/models/group_model.dart
class GroupDataModel {
  final String id;
  final String groupName;
  final String logo;
  final int userAddedLength;

  GroupDataModel({
    required this.id,
    required this.groupName,
    required this.logo,
    required this.userAddedLength,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(
      id: json['_id'],
      groupName: json['groupName'],
      logo: json['logo'],
      userAddedLength: json['userAddedLength'],
    );
  }
}
