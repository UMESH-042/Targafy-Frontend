class Target {
  final String name;
  final int value;

  Target({
    required this.name,
    required this.value,
  });

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      name: json['targetName'],
      value: json['targetValue'],
    );
  }
}