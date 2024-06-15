// lib/models/group_model.dart
class SubGroupModel {
  final String subOfficeName;
  final List<String> usersIds;

  SubGroupModel({
    required this.subOfficeName,
    required this.usersIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'subOfficeName': subOfficeName,
      'usersIds': usersIds,
    };
  }
}

class SubgroupUserModel {
  final String id;
  final String name;

  SubgroupUserModel({
    required this.id,
    required this.name,
  });

  factory SubgroupUserModel.fromJson(Map<String, dynamic> json) {
    return SubgroupUserModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}
