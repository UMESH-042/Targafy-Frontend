// models/subgroup_model.dart
class SubGroup {
  final String id;
  final String groupName;

  SubGroup({required this.id, required this.groupName});

  factory SubGroup.fromJson(Map<String, dynamic> json) {
    return SubGroup(
      id: json['_id'],
      groupName: json['groupName'],
    );
  }
}

class SubGroupResponse {
  final List<SubGroup> groups;

  SubGroupResponse({required this.groups});

  factory SubGroupResponse.fromJson(Map<String, dynamic> json) {
    return SubGroupResponse(
      groups: (json['data']['groups'] as List)
          .map((group) => SubGroup.fromJson(group))
          .toList(),
    );
  }
}

