// // business_model.dart
// class Business {
//   final String id;
//   final String name;
//   final String logo;
//   final String industryType;
//   final String city;
//   final String country;
//   final String email;
//   final List<String> parameters;

//   Business({
//     required this.id,
//     required this.name,
//     required this.logo,
//     required this.industryType,
//     required this.city,
//     required this.country,
//     required this.email,
//     required this.parameters,
//   });

//   factory Business.fromJson(Map<String, dynamic> json) {
//     return Business(
//       id: json['_id'],
//       name: json['name'],
//       logo: json['logo'],
//       industryType: json['industryType'],
//       city: json['city'],
//       country: json['country'],
//       email: json['email'],
//       parameters: List<String>.from(json['parameters']),
//     );
//   }
// }

// // user_model.dart
// class User {
//   final String id;
//   final String name;
//   final List<BusinessUser> businesses;

//   User({
//     required this.id,
//     required this.name,
//     required this.businesses,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       name: json['name'],
//       businesses: (json['businesses'] as List)
//           .map((business) => BusinessUser.fromJson(business))
//           .toList(),
//     );
//   }
// }

// class BusinessUser {
//   final String name;
//   final String userType;
//   final String businessId;

//   BusinessUser({
//     required this.name,
//     required this.userType,
//     required this.businessId,
//   });

//   factory BusinessUser.fromJson(Map<String, dynamic> json) {
//     return BusinessUser(
//       name: json['name'],
//       userType: json['userType'],
//       businessId: json['businessId'],
//     );
//   }
// }

// business_model.dart
class Business {
  final String id;
  final String businessCode;
  final String name;
  final String logo;
  final String industryType;
  final String city;
  final String country;
  final List<String> parameters;

  Business({
    required this.id,
     required this.businessCode,
    required this.name,
    required this.logo,
    required this.industryType,
    required this.city,
    required this.country,
    required this.parameters,
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
      parameters: List<String>.from(json['parameters']),
    );
  }
}

// user_model.dart
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
}
