// lib/models/group_model.dart
class GroupModel {
  final String groupName;
  final String logo;
  final List<String> usersIds;

  GroupModel({
    required this.groupName,
    required this.logo,
    required this.usersIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'logo': logo,
      'usersIds': usersIds,
    };
  }
}
