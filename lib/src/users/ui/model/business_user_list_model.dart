// user_model.dart
class BusinessUserModel {
  final String name;
  final String userId;
  final String role;
  final String userType;
  final String lastSeen;
  final int unseenMessagesCount;

  BusinessUserModel({
    required this.name,
    required this.userId,
    required this.role,
    required this.userType,
    required this.lastSeen,
    required this.unseenMessagesCount,
  });

  factory BusinessUserModel.fromJson(Map<String, dynamic> json) {
    return BusinessUserModel(
      name: json['name'],
      userId: json['userId'],
      role: json['role'],
      userType: json['userType'],
      lastSeen: json['lastSeen'],
      unseenMessagesCount: json['unseenMessagesCount'],
    );
  }
}






// user_model.dart
class BusinessUserModel2 {
  final String name;
  final String userId;
  final String role;
  final String userType;
  final String lastSeen;
  final int unseenMessagesCount;

  BusinessUserModel2({
    required this.name,
    required this.userId,
    required this.role,
    required this.userType,
    required this.lastSeen,
    required this.unseenMessagesCount,
  });

  factory BusinessUserModel2.fromJson(Map<String, dynamic> json) {
    return BusinessUserModel2(
      name: json['name'],
      userId: json['userId'],
      role: json['role'],
      userType: json['userType'],
      lastSeen: json['lastSeen'],
      unseenMessagesCount: json['unseenMessagesCount'],
    );
  }
}
