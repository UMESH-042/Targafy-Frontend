class Parameter {
  final String id;
  final String name;
  final int assignedUsersCount;

  Parameter(
      {required this.id, required this.name, required this.assignedUsersCount});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      id: json['id'],
      name: json['name'],
      assignedUsersCount: json['assignedUsersCount'],
    );
  }
}

class Parameter2 {
  final String id;
  final String name;

  Parameter2({required this.id, required this.name});

  factory Parameter2.fromJson(Map<String, dynamic> json) {
    return Parameter2(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
