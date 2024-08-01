// class GroupHierarchy {
//   final List<GroupNodeData> nodes;
//   final List<GroupEdgeData> edges;

//   GroupHierarchy({
//     required this.nodes,
//     required this.edges,
//   });

//   factory GroupHierarchy.fromJson(Map<String, dynamic> json) {
//     final List<GroupNodeData> nodes = (json['data']['data']['nodes'] as List)
//         .map((node) => GroupNodeData.fromJson(node))
//         .toList();
//     final List<GroupEdgeData> edges = (json['data']['data']['edges'] as List)
//         .map((edge) => GroupEdgeData.fromJson(edge))
//         .toList();

//     return GroupHierarchy(nodes: nodes, edges: edges);
//   }
// }

// class GroupNodeData {
//   final String id;
//   final GroupLabel label;

//   GroupNodeData({
//     required this.id,
//     required this.label,
//   });

//   factory GroupNodeData.fromJson(Map<String, dynamic> json) {
//     return GroupNodeData(
//       id: json['id'] ?? '',
//       label: GroupLabel.fromJson(json['label'] ?? {}),
//     );
//   }
// }

// class GroupLabel {
//   final String group;
//   final String groupId;
//   final int users;

//   GroupLabel({
//     required this.group,
//     required this.groupId,
//     required this.users,
//   });

//   factory GroupLabel.fromJson(Map<String, dynamic> json) {
//     return GroupLabel(
//       group: json['group'] ?? '',
//       groupId: json['groupId'] ?? '',
//       users: json['users'] ?? 0,
//     );
//   }
// }

// class GroupEdgeData {
//   final String from;
//   final String to;

//   GroupEdgeData({
//     required this.from,
//     required this.to,
//   });

//   factory GroupEdgeData.fromJson(Map<String, dynamic> json) {
//     return GroupEdgeData(
//       from: json['from'] ?? '',
//       to: json['to'] ?? '',
//     );
//   }
// }
class GroupHierarchy {
  final List<GroupNodeData> nodes;
  final List<GroupEdgeData> edges;

  GroupHierarchy({
    required this.nodes,
    required this.edges,
  });

  factory GroupHierarchy.fromJson(Map<String, dynamic> json) {
    // Logging the raw JSON for debugging
    print('Raw JSON: $json');

    // Assuming the structure is: {"data": {"data": {"nodes": [...], "edges": [...]} }}
    final data = json['data']['data'];
    if (data == null) {
      throw FormatException('Invalid JSON format');
    }

    final List<GroupNodeData> nodes = (data['nodes'] as List)
        .map((node) => GroupNodeData.fromJson(node))
        .toList();
    final List<GroupEdgeData> edges = (data['edges'] as List)
        .map((edge) => GroupEdgeData.fromJson(edge))
        .toList();

    return GroupHierarchy(nodes: nodes, edges: edges);
  }
}

class GroupNodeData {
  final String id;
  final GroupLabel label;

  GroupNodeData({
    required this.id,
    required this.label,
  });

  factory GroupNodeData.fromJson(Map<String, dynamic> json) {
    // Logging for debugging
    print('Node JSON: $json');

    return GroupNodeData(
      id: json['id'] ?? '',
      label: GroupLabel.fromJson(json['label'] ?? {}),
    );
  }
}

class GroupLabel {
  final String group;
  final String groupId;
  final int users;

  GroupLabel({
    required this.group,
    required this.groupId,
    required this.users,
  });

  factory GroupLabel.fromJson(Map<String, dynamic> json) {
    // Logging for debugging
    print('Label JSON: $json');

    return GroupLabel(
      group: json['group'] ?? '',
      groupId: json['groupId'] ?? '',
      users: json['users'] ?? 0,
    );
  }
}

class GroupEdgeData {
  final String from;
  final String to;

  GroupEdgeData({
    required this.from,
    required this.to,
  });

  factory GroupEdgeData.fromJson(Map<String, dynamic> json) {
    // Logging for debugging
    print('Edge JSON: $json');

    return GroupEdgeData(
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }
}
