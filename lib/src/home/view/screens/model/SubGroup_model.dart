class SubOffice {
  final String groupId;
  final String logo;
  final String subOfficeName;
  final int userAddedLength;

  SubOffice({
    required this.groupId,
    required this.logo,
    required this.subOfficeName,
    required this.userAddedLength,
  });

  factory SubOffice.fromJson(Map<String, dynamic> json) {
    return SubOffice(
      groupId: json['groupId'],
      logo: json['logo'],
      subOfficeName: json['subOfficeName'],
      userAddedLength: json['userAddedLength'],
    );
  }
}
