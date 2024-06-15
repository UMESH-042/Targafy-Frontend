// models/subgroup_model.dart
class Group {
  final String id;
  final String headOfficeName;

  Group({required this.id, required this.headOfficeName});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'],
      headOfficeName: json['headOfficeName'],
    );
  }
}

class GroupResponse {
  final List<Group> groups;

  GroupResponse({required this.groups});

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    return GroupResponse(
      groups: (json['data']['headOffice'] as List)
          .map((group) => Group.fromJson(group))
          .toList(),
    );
  }
}
