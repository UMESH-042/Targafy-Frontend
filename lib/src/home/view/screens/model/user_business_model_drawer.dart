class User {
  final String id;
  final String name;
  final String jobTitle;
  final Map<String, String> contactNumber;
  final int notificationViewCounter;
  final String email;
  final List<Business> businesses;

  User({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.contactNumber,
    required this.notificationViewCounter,
    required this.email,
    required this.businesses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      jobTitle: json['jobTitle'] ?? '',
      contactNumber: {
        'countryCode': json['contactNumber']['countryCode'],
        'number': json['contactNumber']['number'],
      },
      notificationViewCounter: json['notificationViewCounter'],
      email: json['email'] ?? '',
      businesses: (json['businesses'] as List<dynamic>)
          .map((businessJson) => Business.fromJson(businessJson))
          .toList(),
    );
  }
}

class Business {
  final String name;
  final String userType;
  final String businessId;
  final int pendingRequest;
  final String userRole;
  final int activityCounter;

  Business({
    required this.name,
    required this.userType,
    required this.businessId,
    required this.pendingRequest,
    required this.userRole,
    required this.activityCounter,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'],
      userType: json['userType'],
      businessId: json['businessId'],
      pendingRequest: json['pendingRequest'],
      userRole: json['userRole'],
      activityCounter: json['activityCounter'],
    );
  }
}
