class CreateBusiness {
  final String buisnessName;
  final String logo;
  final String industryType;
  final String city;
  final String country;
  final String parameters;

  CreateBusiness({
    required this.buisnessName,
    required this.logo,
    required this.industryType,
    required this.city,
    required this.country,
    required this.parameters,
  });

  Map<String, dynamic> toJson() {
    return {
      'buisnessName': buisnessName,
      'logo': logo,
      'industryType': industryType,
      'city': city,
      'country': country,
      'parameters': parameters,
    };
  }
}
