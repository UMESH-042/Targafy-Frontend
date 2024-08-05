// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share/share.dart';

// import 'package:targafy/src/users/ui/controller/user_hierarchy_controller.dart';
// import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';

// class UserHierarchy extends ConsumerStatefulWidget {
//   final String departmentId;
//   final String businessId;

//   const UserHierarchy({
//     required this.departmentId,
//     required this.businessId,
//   });

//   @override
//   _UserHierarchyState createState() => _UserHierarchyState();
// }

// class _UserHierarchyState extends ConsumerState<UserHierarchy> {
//   late Graph graph = Graph()..isTree = true;
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
//   BusinessUserHierarchy? userHierarchy;
//   late TransformationController _transformationController;
//   Node? selectedNode;
//   final GlobalKey _graphKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     builder
//       ..siblingSeparation = 50
//       ..levelSeparation = 100
//       ..subtreeSeparation = 150;
//     _transformationController = TransformationController();

//     ref
//         .read(businessControllerProvider.notifier)
//         .fetchBusinessUserHierarchy(widget.businessId,widget.departmentId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hierarchyState = ref.watch(businessControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Hierarchy"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await generatePDF();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text(
//                     'PDF downloaded successfully at storage/emulated/0/Android/data/com.targafy.app/files',
//                   ),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             icon: const Icon(Icons.download),
//           ),
//         ],
//       ),
//       body: hierarchyState.when(
//         data: (data) {
//           userHierarchy = data;
//           graph = constructGraph(data);
//           return Stack(
//             children: [
//               InteractiveViewer(
//                 transformationController: _transformationController,
//                 constrained: false,
//                 boundaryMargin: const EdgeInsets.all(100),
//                 minScale: 0.01,
//                 maxScale: 5.6,
//                 child: RepaintBoundary(
//                   key: _graphKey,
//                   child: GraphView(
//                     graph: graph,
//                     algorithm: BuchheimWalkerAlgorithm(
//                         builder, TreeEdgeRenderer(builder)),
//                     paint: Paint()
//                       ..color = Colors.green
//                       ..strokeWidth = 1
//                       ..style = PaintingStyle.stroke,
//                     builder: (Node node) {
//                       var nodeId = node.key!.value as String;
//                       var nodeData = userHierarchy!.nodes
//                           .firstWhere((element) => element.id == nodeId);
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedNode = node;
//                           });
//                         },
//                         child: rectangleWidget(
//                           nodeData.label.name,
//                           nodeData.label.role,
//                           selected: selectedNode == node,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Column(
//                   children: [
//                     IconButton(
//                       onPressed: _zoomOut,
//                       icon: const Icon(Icons.zoom_out),
//                     ),
//                     IconButton(
//                       onPressed: _zoomIn,
//                       icon: const Icon(Icons.zoom_in),
//                     ),
//                     Image.asset(
//                       "assets/img/graph.png",
//                       height: 100,
//                       width: 100,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }

//   Graph constructGraph(BusinessUserHierarchy data) {
//     final graph = Graph();
//     for (var node in data.nodes) {
//       graph.addNode(Node.Id(node.id));
//     }
//     for (var edge in data.edges) {
//       graph.addEdge(Node.Id(edge.from), Node.Id(edge.to));
//     }
//     return graph;
//   }

//   Widget rectangleWidget(String name, String role, {bool selected = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: selected ? Colors.blue : Colors.transparent,
//         borderRadius: BorderRadius.circular(4),
//         boxShadow: [
//           BoxShadow(color: Colors.blue.withOpacity(0.2), spreadRadius: 1),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$name [$role]',
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           ),
//           const SizedBox(height: 2),
//           Text('Role: $role', style: const TextStyle(fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   void _zoomIn() {
//     _transformationController.value *= Matrix4.diagonal3Values(1.5, 1.5, 1);
//   }

//   void _zoomOut() {
//     _transformationController.value *= Matrix4.diagonal3Values(0.5, 0.5, 1);
//   }

//   Future<void> generatePDF() async {
//     try {
//       final pdf = pw.Document();
//       final ui.Image graphImage = await _capturePng();
//       final ByteData? byteData =
//           await graphImage.toByteData(format: ui.ImageByteFormat.png);
//       final Uint8List graphBytes = byteData!.buffer.asUint8List();
//       final pdfGraphImage = pw.MemoryImage(graphBytes);

//       final ByteData logoData = await rootBundle.load('assets/img/targafy.png');
//       final Uint8List logoBytes = logoData.buffer.asUint8List();
//       final pdfLogoImage = pw.MemoryImage(logoBytes);

//       pdf.addPage(pw.Page(
//         build: (pw.Context context) {
//           return pw.Stack(
//             children: [
//               pw.Center(
//                   child: pw.Image(pdfGraphImage, height: 100, width: 100)),
//               pw.Align(
//                 alignment: pw.Alignment.bottomRight,
//                 child: pw.Image(pdfLogoImage, height: 50, width: 50),
//               ),
//             ],
//           );
//         },
//       ));

//       final String dir = (await getExternalStorageDirectory())?.path ?? '';
//       if (dir.isEmpty) return;
//       final String path = '$dir/organization_chart.pdf';
//       final File file = File(path);
//       await file.writeAsBytes(await pdf.save());
//       // await Share.shareFiles([path]);
//       print(path);
//       await Share.shareFiles([path], text: 'Check out this PDF file:');
//     } catch (e, stackTrace) {
//       print('Error generating PDF: $e');
//       print(stackTrace);
//     }
//   }

//   Future<ui.Image> _capturePng() async {
//     RenderRepaintBoundary boundary =
//         _graphKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage();
//     return image;
//   }
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

import 'package:targafy/src/users/ui/controller/user_hierarchy_controller.dart';
import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';

class UserHierarchy extends ConsumerStatefulWidget {
  final String departmentId;
  final String businessId;

  const UserHierarchy({
    required this.departmentId,
    required this.businessId,
  });

  @override
  _UserHierarchyState createState() => _UserHierarchyState();
}

class _UserHierarchyState extends ConsumerState<UserHierarchy> {
  late Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  BusinessUserHierarchy? userHierarchy;
  late TransformationController _transformationController;
  Node? selectedNode;
  final GlobalKey _graphKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    builder
      ..siblingSeparation = 50
      ..levelSeparation = 100
      ..subtreeSeparation = 150;
    _transformationController = TransformationController();

    ref
        .read(businessControllerProvider.notifier)
        .fetchBusinessUserHierarchy(widget.businessId, widget.departmentId);
  }

  @override
  Widget build(BuildContext context) {
    final hierarchyState = ref.watch(businessControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Hierarchy"),
        actions: [
          IconButton(
            onPressed: () async {
              await generatePDF();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'PDF downloaded successfully at storage/emulated/0/Android/data/com.targafy.app/files',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: hierarchyState.when(
        data: (data) {
          userHierarchy = data;
          graph = constructGraph(data);
          return Stack(
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: RepaintBoundary(
                  key: _graphKey,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      var nodeId = node.key!.value as String;
                      var defaultNodeData = NodeData(
                        id: 'default',
                        label: Label(
                            name: 'Unknown',
                            role: 'Unknown',
                            userId: '',
                            allSubordinatesCount: 0),
                      );
                      var nodeData = userHierarchy!.nodes.firstWhere(
                        (element) => element.id == nodeId,
                        orElse: () => defaultNodeData,
                      );

                      if (nodeData == null) {
                        return Container(); // Return an empty container if no node data is found
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedNode = node;
                          });
                        },
                        child: rectangleWidget(
                          nodeData.label.name,
                          nodeData.label.role,
                          selected: selectedNode == node,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: _zoomOut,
                      icon: const Icon(Icons.zoom_out),
                    ),
                    IconButton(
                      onPressed: _zoomIn,
                      icon: const Icon(Icons.zoom_in),
                    ),
                    Image.asset(
                      "assets/img/graph.png",
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Graph constructGraph(BusinessUserHierarchy data) {
    final graph = Graph();
    for (var node in data.nodes) {
      graph.addNode(Node.Id(node.id));
    }
    for (var edge in data.edges) {
      graph.addEdge(Node.Id(edge.from), Node.Id(edge.to));
    }
    return graph;
  }

  Widget rectangleWidget(String name, String role, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.2), spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name [$role]',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text('Role: $role', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _zoomIn() {
    _transformationController.value *= Matrix4.diagonal3Values(1.5, 1.5, 1);
  }

  void _zoomOut() {
    _transformationController.value *= Matrix4.diagonal3Values(0.5, 0.5, 1);
  }

  Future<void> generatePDF() async {
    try {
      final pdf = pw.Document();
      final ui.Image graphImage = await _capturePng();
      final ByteData? byteData =
          await graphImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List graphBytes = byteData!.buffer.asUint8List();
      final pdfGraphImage = pw.MemoryImage(graphBytes);

      final ByteData logoData = await rootBundle.load('assets/img/targafy.png');
      final Uint8List logoBytes = logoData.buffer.asUint8List();
      final pdfLogoImage = pw.MemoryImage(logoBytes);

      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Center(
                  child: pw.Image(pdfGraphImage, height: 100, width: 100)),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Image(pdfLogoImage, height: 50, width: 50),
              ),
            ],
          );
        },
      ));

      final String dir = (await getExternalStorageDirectory())?.path ?? '';
      if (dir.isEmpty) return;
      final String path = '$dir/organization_chart.pdf';
      final File file = File(path);
      await file.writeAsBytes(await pdf.save());
      // await Share.shareFiles([path]);
      print(path);
      await Share.shareFiles([path], text: 'Check out this PDF file:');
    } catch (e, stackTrace) {
      print('Error generating PDF: $e');
      print(stackTrace);
    }
  }

  Future<ui.Image> _capturePng() async {
    RenderRepaintBoundary boundary =
        _graphKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }
}
