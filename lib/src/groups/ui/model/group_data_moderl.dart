// // lib/models/group_model.dart
class GroupDataModel {
  final String id;
  final String headGroupName;
  // final String logo;
  final int userAddedLength;

  GroupDataModel({
    required this.id,
    required this.headGroupName,
    // required this.logo,
    required this.userAddedLength,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(
      id: json['_id'],
      headGroupName: json['headGroupName'],
      // logo: json['logo'],
      userAddedLength: json['userAddedLength'],
    );
  }
}



class SubGroupDataModel {
  final String groupId;
  final String groupName;
  // final String logo;
  final int userAddedLength;

  SubGroupDataModel({
    required this.groupId,
    required this.groupName,
    // required this.logo,
    required this.userAddedLength,
  });

  factory SubGroupDataModel.fromJson(Map<String, dynamic> json) {
    return SubGroupDataModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      // logo: json['logo'],
      userAddedLength: json['userAddedLength'],
    );
  }
}


// class BaseGroupDataModel {
//   final String id;
//   final String name;
//   final int userAddedLength;

//   BaseGroupDataModel({
//     required this.id,
//     required this.name,
//     required this.userAddedLength,
//   });
// }

// class GroupDataModel extends BaseGroupDataModel {
//   GroupDataModel({
//     required String id,
//     required String headGroupName,
//     required int userAddedLength,
//   }) : super(
//           id: id,
//           name: headGroupName,
//           userAddedLength: userAddedLength,
//         );

//   factory GroupDataModel.fromJson(Map<String, dynamic> json) {
//     return GroupDataModel(
//       id: json['_id'],
//       headGroupName: json['headGroupName'],
//       userAddedLength: json['userAddedLength'],
//     );
//   }
// }

// class SubGroupDataModel extends BaseGroupDataModel {
//   SubGroupDataModel({
//     required String groupId,
//     required String groupName,
//     required int userAddedLength,
//   }) : super(
//           id: groupId,
//           name: groupName,
//           userAddedLength: userAddedLength,
//         );

//   factory SubGroupDataModel.fromJson(Map<String, dynamic> json) {
//     return SubGroupDataModel(
//       groupId: json['groupId'],
//       groupName: json['groupName'],
//       userAddedLength: json['userAddedLength'],
//     );
//   }
// }
