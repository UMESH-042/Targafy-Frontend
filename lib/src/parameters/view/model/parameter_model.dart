class Parameter {
  final String name;
  final int assignedUsersCount;

  Parameter({required this.name, required this.assignedUsersCount});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      name: json['name'],
      assignedUsersCount: json['assignedUsersCount'],
    );
  }
}
