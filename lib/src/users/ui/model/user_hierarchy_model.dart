class BusinessUserHierarchy {
  final List<NodeData> nodes;
  final List<EdgeData> edges;


  BusinessUserHierarchy({
    required this.nodes,
    required this.edges,
  });

  factory BusinessUserHierarchy.fromJson(Map<String, dynamic> json) {
    final List<NodeData> nodes =
        (json['nodes'] as List).map((node) => NodeData.fromJson(node)).toList();
    final List<EdgeData> edges =
        (json['edges'] as List).map((edge) => EdgeData.fromJson(edge)).toList();

    return BusinessUserHierarchy(nodes: nodes, edges: edges);
  }
}

class NodeData {
  final String id;
  final Label label;

  NodeData({
    required this.id,
    required this.label,
  });

  factory NodeData.fromJson(Map<String, dynamic> json) {
    return NodeData(
      id: json['id'] ?? '',
      label: Label.fromJson(json['label'] ?? {}),
    );
  }
}

class Label {
  final String name;
  final String userId;
  final String role;
  final int allSubordinatesCount;

  Label({
    required this.name,
    required this.userId,
    required this.role,
     required this.allSubordinatesCount,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      role: json['role'] ?? '',
       allSubordinatesCount: json['allSubordinatesCount'] ?? 0,
    );
  }
}

class EdgeData {
  final String from;
  final String to;

  EdgeData({
    required this.from,
    required this.to,
  });

  factory EdgeData.fromJson(Map<String, dynamic> json) {
    return EdgeData(
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }
}
