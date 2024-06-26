// models/user_hierarchy_model.dart
class HierarchyNode {
  final String id;
  final String office;
  final List<User> users;

  HierarchyNode({required this.id, required this.office, required this.users});

  factory HierarchyNode.fromJson(Map<String, dynamic> json) {
    return HierarchyNode(
      id: json['id'],
      office: json['label']['office'],
      users: (json['label']['users'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
    );
  }
}

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

class HierarchyEdge {
  final String from;
  final String to;

  HierarchyEdge({required this.from, required this.to});

  factory HierarchyEdge.fromJson(Map<String, dynamic> json) {
    return HierarchyEdge(
      from: json['from'],
      to: json['to'],
    );
  }
}

class BusinessUserHierarchy {
  final List<HierarchyNode> nodes;
  final List<HierarchyEdge> edges;

  BusinessUserHierarchy({required this.nodes, required this.edges});

  factory BusinessUserHierarchy.fromJson(Map<String, dynamic> json) {
    return BusinessUserHierarchy(
      nodes: (json['nodes'] as List)
          .map((node) => HierarchyNode.fromJson(node))
          .toList(),
      edges: (json['edges'] as List)
          .map((edge) => HierarchyEdge.fromJson(edge))
          .toList(),
    );
  }
}
