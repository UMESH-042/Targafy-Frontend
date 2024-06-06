class UserProfileBusinessModel {
  final String id;
  final String userId;
  final String businessId;
  final String name;
  final Map<String, dynamic> contactNumber;
  final String userType;
  final String role;
  final String lastSeen;
  final int totalRating;

  UserProfileBusinessModel({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.name,
    required this.contactNumber,
    required this.userType,
    required this.role,
    required this.lastSeen,
    required this.totalRating,
  });

  factory UserProfileBusinessModel.fromJson(Map<String, dynamic> json) {
    return UserProfileBusinessModel(
      id: json['_id'],
      userId: json['userId'],
      businessId: json['businessId'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      userType: json['userType'],
      role: json['role'],
      lastSeen: json['lastSeen'],
      totalRating: json['totalRating'],
    );
  }
}
