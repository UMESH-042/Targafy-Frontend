// lib/models/group_model.dart
class GroupDataModel {
  final String id;
  final String headOffice;
  final String logo;
  final int userAddedLength;

  GroupDataModel({
    required this.id,
    required this.headOffice,
    required this.logo,
    required this.userAddedLength,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(
      id: json['_id'],
      headOffice: json['headOfficeName'],
      logo: json['logo'],
      userAddedLength: json['userAddedLength'],
    );
  }
}
