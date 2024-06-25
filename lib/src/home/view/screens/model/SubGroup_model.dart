class SubOffice {
  final String groupId;
  final String subOfficeName;

  SubOffice({
    required this.groupId,
    required this.subOfficeName,
  });

  factory SubOffice.fromJson(Map<String, dynamic> json) {
    return SubOffice(
      groupId: json['_id'],
      subOfficeName: json['officeName'],
    );
  }
}
