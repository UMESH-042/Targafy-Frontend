class ContactNumber {
  final String countryCode;
  final String number;

  ContactNumber({
    required this.countryCode,
    required this.number,
  });

  factory ContactNumber.fromJson(Map<String, dynamic> json) {
    return ContactNumber(
      countryCode: json['countryCode'],
      number: json['number'],
    );
  }

  @override
  String toString() {
    return 'ContactNumber(countryCode: $countryCode, number: $number)';
  }
}

class RequestUserModel {
  final String userId;
  final String name;
  final ContactNumber contactNumber;
  final String date;

  RequestUserModel({
    required this.userId,
    required this.name,
    required this.contactNumber,
    required this.date,
  });

  factory RequestUserModel.fromJson(Map<String, dynamic> json) {
    return RequestUserModel(
      userId: json['userId'],
      name: json['name'],
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
      date: json['date'],
    );
  }

  @override
  String toString() {
    return 'RequestUserModel(userId: $userId, name: $name, contactNumber: $contactNumber, date: $date)';
  }
}


