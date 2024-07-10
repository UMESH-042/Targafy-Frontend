class User {
  final String name;
  final String userId;

  User({required this.name, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      userId: json['userId'],
    );
  }
}

class Target {
  final String targetValue;
  final String paramName;
  final String comment;
  final List<String> userIds;
  final String monthIndex;
  final List<String> benchMarks;

  Target({
    required this.targetValue,
    required this.paramName,
    required this.comment,
    required this.userIds,
    required this.monthIndex,
    required this.benchMarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'targetValue': targetValue,
      'paramName': paramName,
      'comment': comment,
      'userIds': userIds,
      'monthIndex': monthIndex,
      'benchMarks': benchMarks,
    };
  }
}
