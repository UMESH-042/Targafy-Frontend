// // subgroup_user_list.dart
// class User {
//   final String id;
//   final String name;
//   final String countryCode;
//   final String number;
//   final String role;

//   User({
//     required this.id,
//     required this.name,
//     required this.countryCode,
//     required this.number,
//     required this.role,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       countryCode: json['contactNumber']['countryCode'] ?? '',
//       number: json['contactNumber']['number'] ?? '',
//       role: json['role'] ?? '',
//     );
//   }
// }

// class SubGroupUserList {
//   final List<User> users;

//   SubGroupUserList({required this.users});

//   factory SubGroupUserList.fromJson(Map<String, dynamic> json) {
//     List<User> users = [];
//     if (json['data'] != null && json['data']['businessusers'] != null) {
//       users = (json['data']['businessusers'] as List)
//           .map((i) => User.fromJson(i))
//           .toList();
//     }
//     return SubGroupUserList(users: users);
//   }
// }

class UserGroupResponse {
  final List<User> users;
  final List<BusinessUser> businessUsers;
  final String message;
  final bool success;

  UserGroupResponse({
    required this.users,
    required this.businessUsers,
    required this.message,
    required this.success,
  });

  factory UserGroupResponse.fromJson(Map<String, dynamic> json) {
    var userList = json['data']['users'] as List;
    var businessUserList = json['data']['businessusers'] as List;

    List<User> users = userList.map((i) => User.fromJson(i)).toList();
    List<BusinessUser> businessUsers = businessUserList.map((i) => BusinessUser.fromJson(i)).toList();

    return UserGroupResponse(
      users: users,
      businessUsers: businessUsers,
      message: json['message'],
      success: json['success'],
    );
  }
}

class User {
  final String id;

  User({required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
    );
  }
}

class BusinessUser {
  final String name;
  final ContactNumber contactNumber;
  final String role;

  BusinessUser({required this.name, required this.contactNumber, required this.role});

  factory BusinessUser.fromJson(Map<String, dynamic> json) {
    return BusinessUser(
      name: json['name'],
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
      role: json['role'],
    );
  }
}

class ContactNumber {
  final String countryCode;
  final String number;

  ContactNumber({required this.countryCode, required this.number});

  factory ContactNumber.fromJson(Map<String, dynamic> json) {
    return ContactNumber(
      countryCode: json['countryCode'],
      number: json['number'],
    );
  }
}
