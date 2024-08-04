class Business {
  final String id;
  final String businessCode;
  final String name;
  final String logo;
  final String industryType;
  final String city;
  final String country;

  Business({
    required this.id,
    required this.businessCode,
    required this.name,
    required this.logo,
    required this.industryType,
    required this.city,
    required this.country,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      businessCode: json['businessCode'],
      name: json['name'],
      logo: json['logo'],
      industryType: json['industryType'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'businessCode': businessCode,
      'name': name,
      'logo': logo,
      'industryType': industryType,
      'city': city,
      'country': country,
    };
  }
}

class BusinessUser {
  final String name;
  final String userType;
  final String businessId;

  BusinessUser({
    required this.name,
    required this.userType,
    required this.businessId,
  });

  factory BusinessUser.fromJson(Map<String, dynamic> json) {
    return BusinessUser(
      name: json['name'],
      userType: json['userType'],
      businessId: json['businessId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userType': userType,
      'businessId': businessId,
    };
  }
}

class User {
  final String id;
  final String name;
  final List<BusinessUser> businesses;

  User({
    required this.id,
    required this.name,
    required this.businesses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      businesses: (json['businesses'] as List)
          .map((business) => BusinessUser.fromJson(business))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'businesses': businesses.map((e) => e.toJson()).toList(),
    };
  }
}




// department.dart
class department {
  final String departmentId;
  final String departmentName;
  final String role;

  department({
    required this.departmentId,
    required this.departmentName,
    required this.role,
  });

  factory department.fromJson(Map<String, dynamic> json) {
    return department(
      departmentId: json['departmentId'],
      departmentName: json['departmentName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentId': departmentId,
      'departmentName': departmentName,
      'role': role,
    };
  }
}
