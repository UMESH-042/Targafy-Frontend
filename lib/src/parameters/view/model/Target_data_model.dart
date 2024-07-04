class TargetData {
  final String month;
  final String targetValue;
  final String targetDone;

  TargetData({
    required this.month,
    required this.targetValue,
    required this.targetDone,
  });

  factory TargetData.fromJson(Map<String, dynamic> json) {
    return TargetData(
      month: json['month'].toString(), // Ensure month is always a string
      targetValue: json['targetValue']
          .toString(), // Ensure targetValue is always a string
      targetDone:
          json['targetDone'].toString(), // Ensure targetDone is always a string
    );
  }
}
