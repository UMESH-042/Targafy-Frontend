import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/home/view/screens/controller/Comment_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/actual_predicted_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/get_drop_downfield_pair.dart';
import 'package:targafy/src/home/view/screens/controller/user_hierarchy_comments_controller.dart';
import 'package:targafy/src/home/view/screens/controller/user_hierarchy_data_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
import 'package:targafy/src/home/view/screens/widgets/CommentBubbleWidget.dart';
import 'package:targafy/src/home/view/screens/widgets/CustomRatioChart.dart';
import 'package:targafy/src/home/view/screens/widgets/DataTableForRatio.dart';
import 'package:targafy/src/home/view/screens/widgets/GraphicalStatistics.dart';
import 'package:targafy/src/home/view/widgets/progress_bar.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/home/view/widgets/selectable_sub_group.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';
import 'package:targafy/src/users/ui/controller/user_hierarchy_controller.dart';
import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/utils/socketsServices.dart';
import 'package:tuple/tuple.dart';
import 'widgets/CustomCharts.dart';
import 'widgets/DataTable.dart';
import 'widgets/PieChart.dart';

String domain = AppRemoteRoutes.baseUrl;

// Providers
final selectedBusinessData = Provider<Map<String, dynamic>?>((ref) {
  return ref.watch(currentBusinessProvider);
});

final paramPairsProvider = FutureProvider<List<ParamPair>>((ref) {
  final repository = ref.watch(paramRepositoryProvider);
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;
  return repository.fetchParamPairs(businessId);
});

final parameterListProvider =
    FutureProvider.autoDispose<List<Parameter2>>((ref) async {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;

  if (businessId != null) {
    final notifier = ref.read(parametersProviderHome.notifier);
    await notifier.fetchParametersforHome(businessId);
    return ref.watch(parametersProviderHome);
  } else {
    return <Parameter2>[];
  }
});

final businessHierarchyProvider =
    FutureProvider.autoDispose<BusinessUserHierarchy>((ref) async {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;

  if (businessId != null) {
    final notifier = ref.read(businessControllerProvider.notifier);
    await notifier.fetchBusinessUserHierarchy(businessId);
    final result = ref.watch(businessControllerProvider);

    if (result is AsyncData<BusinessUserHierarchy>) {
      return result.value; // Return the fetched BusinessUserHierarchy
    } else {
      throw StateError('Failed to fetch business hierarchy');
    }
  } else {
    throw StateError(
        'Business ID is null'); // Throw an error if businessId is null
  }
});

final userDataFutureProvider =
    FutureProvider.family<UserData, Tuple4<String, String, String, String>>(
        (ref, params) async {
  final businessId = params.item1;
  final userId = params.item2;
  final selectedParameter = params.item3;
  final month = params.item4;

  final controller = ref.read(userDataProvider.notifier);
  await controller.fetchUserData(businessId, userId, selectedParameter, month);
  final result = ref.watch(userDataProvider);

  if (result is AsyncData<UserData>) {
    return result.value; // Return the fetched UserData
  } else {
    throw StateError('Failed to fetch user data');
  }
});

final combinedUserDataFutureProvider = FutureProvider.family<List<UserData>,
    Tuple5<String, String, String, String, String>>((ref, tuple) async {
  final businessId = tuple.item1;
  final selectedUserId = tuple.item2;
  final firstSelectedItem = tuple.item3;
  final secondSelectedItem = tuple.item4;
  final currentMonth = tuple.item5;

  final futures = [
    ref.read(userDataFutureProvider(
            Tuple4(businessId, selectedUserId, firstSelectedItem, currentMonth))
        .future),
    ref.read(userDataFutureProvider(Tuple4(
            businessId, selectedUserId, secondSelectedItem, currentMonth))
        .future),
  ];

  return Future.wait(futures);
});

final userCommentsFutureProvider = FutureProvider.family<List<Comment>,
    Tuple4<String, String, String, String>>((ref, params) async {
  final businessId = params.item1;
  final userId = params.item2;
  final selectedParameter = params.item3;
  final month = params.item4;

  final controller = ref.read(commentsDataProvider.notifier);
  await controller.fetchComments(businessId, userId, selectedParameter, month);
  final result = ref.watch(commentsDataProvider);

  if (result is AsyncData<List<Comment>>) {
    return result.value; // Return the fetched UserData
  } else {
    throw StateError('Failed to fetch user data');
  }
});

final userPieDataFutureProvider =
    FutureProvider.family<UserPieData, Tuple4<String, String, String, String>>(
        (ref, params) async {
  final businessId = params.item1;
  final userId = params.item2;
  final selectedParameter = params.item3;
  final currentMonth = params.item4;

  final controller = ref.read(userPieDataProvider.notifier);
  await controller.fetchUserPieData(
      businessId, userId, selectedParameter, currentMonth);
  final result = ref.watch(userPieDataProvider);

  if (result is AsyncData<UserPieData>) {
    return result.value; // Return the fetched UserData
  } else {
    throw StateError('Failed to fetch user data');
  }
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<bool> selectedStates;
  late String selectedParameter;
  late String selectedUser;
  late String selectedUserId;
  int currentIndex = 0;
  int currentMonth = DateTime.now().month;

  List<String> currentPath = [];

  Map<int, String> selectedItemsByRow = {};

  bool _isRefreshing = false;
  late bool selectedHierarchyUser;

  late List<ParamPair> dropdownPairs = [];

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameter = '';
    selectedUser = '';
    selectedUserId = '';
    selectedHierarchyUser = false;
    currentPath = [];
    selectedItemsByRow = {};
    _isRefreshing = false;
    dropdownPairs = [];
    // loadSavedPairs();
    // _getToken();
  }

  @override
  void dispose() {
    // Dispose variables here if necessary
    selectedStates = [];
    selectedParameter = '';
    selectedUser = '';
    selectedUserId = '';
    currentPath = [];
    selectedItemsByRow = {};
    _isRefreshing = false;
    selectedHierarchyUser = false;
    dropdownPairs = [];
    super.dispose();
  }

  static const List<String> images = [
    'assets/img/line_chart_invert.png',
    'assets/img/pie_invert.png',
    'assets/img/table_invert.png',
    'assets/img/chat_invert.png',
  ];

  void handleTapForCharts(int index) {
    setState(() {
      for (int i = 0; i < selectedStates.length; i++) {
        if (i != index) {
          selectedStates[i] = false;
        }
      }
      selectedStates[index] = !selectedStates[index];
    });
  }

  Future<void> _handleTapForParameters(
      String parameterName, String paramId) async {
    setState(() {
      selectedParameter =
          selectedParameter == parameterName ? '' : parameterName;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    ref.invalidate(parameterListProvider);
    // ref.invalidate(currentBusinessProvider);
    ref.invalidate(dataAddedControllerProvider);
    // ref.invalidate(businessHierarchyProvider);
    ref.invalidate(paramPairsProvider);

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

//   void _handleNodeTap(String nodeName, String nodeId,
//       Map<String, List<String>> parentIdToChildren) {
//     setState(() {
//       if (currentPath.contains(nodeId)) {
//         _removeDescendants(nodeId, parentIdToChildren);
//         selectedUserId = currentPath.isNotEmpty ? currentPath.last : '';
//         selectedHierarchyUser = currentPath.isNotEmpty;
//       } else {
//         final parent = parentIdToChildren.entries
//             .firstWhere(
//               (entry) => entry.value.contains(nodeId),
//               orElse: () => MapEntry('', []),
//             )
//             .key;

//         // Unselect the previously selected node in the same row
//         if (parent.isNotEmpty) {
//           parentIdToChildren[parent]?.forEach((child) {
//             currentPath.remove(child);
//           });
//         }

//         selectedUserId = nodeId;
//         currentPath.add(nodeId);
//         selectedHierarchyUser = true;
//       }
//     });
//   }

// // Function to remove descendants of a node
//   void _removeDescendants(
//       String nodeId, Map<String, List<String>> parentIdToChildren) {
//     final nodesToRemove = _getDescendants(nodeId, parentIdToChildren);
//     currentPath.removeWhere((id) => nodesToRemove.contains(id));
//     currentPath.remove(nodeId);
//   }

//   List<String> _getDescendants(
//       String nodeId, Map<String, List<String>> parentIdToChildren) {
//     final List<String> descendants = [];
//     void addDescendants(String id) {
//       if (parentIdToChildren.containsKey(id)) {
//         parentIdToChildren[id]!.forEach((childId) {
//           descendants.add(childId);
//           addDescendants(childId);
//         });
//       }
//     }

//     addDescendants(nodeId);
//     return descendants;
//   }
  void _handleNodeTap(String nodeName, String nodeId,
      Map<String, List<String>> parentIdToChildren) {
    setState(() {
      if (currentPath.contains(nodeId)) {
        _removeDescendants(nodeId, parentIdToChildren);
        selectedUserId = currentPath.isNotEmpty ? currentPath.last : '';
        selectedHierarchyUser = currentPath.isNotEmpty;
      } else {
        final parent = parentIdToChildren.entries
            .firstWhere(
              (entry) => entry.value.contains(nodeId),
              orElse: () => MapEntry('', []),
            )
            .key;

        // Unselect the previously selected node in the same row
        if (parent.isNotEmpty) {
          parentIdToChildren[parent]?.forEach((child) {
            currentPath.remove(child);
          });
        }

        selectedUserId = nodeId;
        currentPath.add(nodeId);
        selectedHierarchyUser = true;
      }
    });
  }

  void _removeDescendants(
      String nodeId, Map<String, List<String>> parentIdToChildren) {
    final nodesToRemove = _getDescendants(nodeId, parentIdToChildren);
    currentPath.removeWhere((id) => nodesToRemove.contains(id));
    currentPath.remove(nodeId);
  }

  List<String> _getDescendants(
      String nodeId, Map<String, List<String>> parentIdToChildren) {
    final List<String> descendants = [];
    void addDescendants(String id) {
      if (parentIdToChildren.containsKey(id)) {
        parentIdToChildren[id]!.forEach((childId) {
          descendants.add(childId);
          addDescendants(childId);
        });
      }
    }

    addDescendants(nodeId);
    return descendants;
  }

  void _handlePrevTap() {
    setState(() {
      currentMonth = (currentMonth - 1) % 12;
      if (currentMonth == 0) currentMonth = 12;
    });
  }

  void _handleNextTap() {
    setState(() {
      currentMonth = (currentMonth + 1) % 12;
      if (currentMonth == 0) currentMonth = 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(currentMonth);

    final parameterListAsync = ref.watch(parameterListProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final dataAddedController = ref.watch(dataAddedControllerProvider);

    final businessId = selectedBusinessData?['business']?.id;
    final hierarchyAsync = ref.watch(businessHierarchyProvider);
    final paramPairsAsync = ref.watch(paramPairsProvider);

    if (parameterListAsync == null ||
        selectedBusinessData == null ||
        dataAddedController == null ||
        businessId == null ||
        hierarchyAsync == null ||
        paramPairsAsync == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/animations/empty_list.json',
                height: 200, width: 200),
            const Text(
              "Nothing to display",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    String jsonData = '''
  {
    "statusCode": 200,
    "data": {
      "totalSum": 2424,
      "userData": [
        {
          "name": "",
          "value": 0,
          "percentage": 0
        },
        {
         "name": "",
          "value": 0,
          "percentage": 100
        }
      ]
    },
    "message": "Data retrieved successfully",
    "success": true
  }
  ''';
    Map<String, dynamic> parsedData = json.decode(jsonData);
    List<dynamic> userData = parsedData['data']['userData'];
    List<UserEntry> parseUserEntries(List<dynamic> jsonList) {
      List<UserEntry> entries =
          jsonList.map((json) => UserEntry.fromJson(json)).toList();
      return entries;
    }

    // Convert JSON data to List<UserEntry>
    List<UserEntry> userEntries = parseUserEntries(userData);

    paramPairsAsync.when(
      data: (pairs) {
        dropdownPairs = pairs;
      },
      loading: () {},
      error: (error, stackTrace) {
        print(error);
      },
    );

    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: _isRefreshing
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      parameterListAsync.when(
                        data: (parameterList) {
                          if (selectedParameter.isEmpty &&
                              parameterList.isNotEmpty) {
                            selectedParameter = parameterList[0].name;
                          }
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02,
                            ).copyWith(
                              top: MediaQuery.of(context).size.height * 0.005,
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: parameterList.length,
                              itemBuilder: (context, index) {
                                final parameterName = parameterList[index].name;
                                final paramId = parameterList[index].id;
                                print('This is param Id :-$paramId');
                                return SelectableParameterWidget(
                                  text: parameterName,
                                  isSelected:
                                      parameterName == selectedParameter,
                                  onTap: () => _handleTapForParameters(
                                      parameterName, paramId),
                                );
                              },
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(
                          child: Text('No Parameters Added'),
                        ),
                      ),
                      // if (selectedParameter.isNotEmpty)
                      //   hierarchyAsync.when(
                      //     data: (hierarchy) {
                      //       final nodes = hierarchy.nodes;
                      //       final edges = hierarchy.edges;

                      //       final Map<String, String> nodeIdToLabel =
                      //           Map.fromEntries(
                      //         nodes.map(
                      //             (node) => MapEntry(node.id, node.label.name)),
                      //       );

                      //       final Map<String, List<String>> parentIdToChildren =
                      //           {};

                      //       for (var edge in edges) {
                      //         parentIdToChildren.putIfAbsent(
                      //             edge.from, () => []);
                      //         parentIdToChildren[edge.from]!.add(edge.to);
                      //       }

                      //       return Container(
                      //         alignment:
                      //             Alignment.centerLeft, // Align to the left
                      //         margin: EdgeInsets.symmetric(
                      //           horizontal:
                      //               MediaQuery.of(context).size.width * 0.02,
                      //         ).copyWith(
                      //           top: MediaQuery.of(context).size.height * 0.005,
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 children: [
                      //                   SelectableSubGroupWidget(
                      //                     text: nodes[0].label.name.isNotEmpty
                      //                         ? nodes[0].label.name
                      //                         : '-',
                      //                     isSelected:
                      //                         currentPath.contains(nodes[0].id),
                      //                     onTap: () => _handleNodeTap(
                      //                         nodes[0].label.name,
                      //                         nodes[0].id,
                      //                         parentIdToChildren),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             ...currentPath.map((parentId) {
                      //               final children =
                      //                   parentIdToChildren[parentId] ?? [];
                      //               return Padding(
                      //                 padding: EdgeInsets.only(
                      //                     top: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.005),
                      //                 child: SingleChildScrollView(
                      //                   scrollDirection: Axis.horizontal,
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.start,
                      //                     children: children.map((childId) {
                      //                       return SelectableSubGroupWidget(
                      //                         text:
                      //                             nodeIdToLabel[childId] ?? '',
                      //                         isSelected:
                      //                             currentPath.contains(childId),
                      //                         onTap: () => _handleNodeTap(
                      //                             nodeIdToLabel[childId]!,
                      //                             childId,
                      //                             parentIdToChildren),
                      //                       );
                      //                     }).toList(),
                      //                   ),
                      //                 ),
                      //               );
                      //             }).toList(),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //     loading: () =>
                      //         const Center(child: CircularProgressIndicator()),
                      //     error: (error, stackTrace) => Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Lottie.asset(
                      //               'assets/animations/empty_list.json',
                      //               height: 200,
                      //               width: 200),
                      //           const Text(
                      //             "Nothing to display",
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),

// this code  is for left align

                      // if (selectedParameter.isNotEmpty)
                      //   hierarchyAsync.when(
                      //     data: (hierarchy) {
                      //       final nodes = hierarchy.nodes;
                      //       final edges = hierarchy.edges;

                      //       final Map<String, String> nodeIdToLabel =
                      //           Map.fromEntries(
                      //         nodes.map(
                      //             (node) => MapEntry(node.id, node.label.name)),
                      //       );

                      //       final Map<String, List<String>> parentIdToChildren =
                      //           {};

                      //       for (var edge in edges) {
                      //         parentIdToChildren.putIfAbsent(
                      //             edge.from, () => []);
                      //         parentIdToChildren[edge.from]!.add(edge.to);
                      //       }

                      //       bool isRootSelected =
                      //           currentPath.contains(nodes[0].id);

                      //       return Container(
                      //         alignment:
                      //             Alignment.centerLeft, // Align to the left
                      //         margin: EdgeInsets.symmetric(
                      //           horizontal:
                      //               MediaQuery.of(context).size.width * 0.02,
                      //         ).copyWith(
                      //           top: MediaQuery.of(context).size.height * 0.005,
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 children: [
                      //                   SelectableSubGroupWidget(
                      //                     text: nodes[0].label.name.isNotEmpty
                      //                         ? nodes[0].label.name
                      //                         : '-',
                      //                     isSelected:
                      //                         currentPath.contains(nodes[0].id),
                      //                     onTap: () => _handleNodeTap(
                      //                         nodes[0].label.name,
                      //                         nodes[0].id,
                      //                         parentIdToChildren),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             if (isRootSelected)
                      //               ...currentPath.map((parentId) {
                      //                 final children =
                      //                     parentIdToChildren[parentId] ?? [];
                      //                 return Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005),
                      //                   child: SingleChildScrollView(
                      //                     scrollDirection: Axis.horizontal,
                      //                     child: Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.start,
                      //                       children: children.map((childId) {
                      //                         return SelectableSubGroupWidget(
                      //                           text: nodeIdToLabel[childId] ??
                      //                               '',
                      //                           isSelected: currentPath
                      //                               .contains(childId),
                      //                           onTap: () => _handleNodeTap(
                      //                               nodeIdToLabel[childId]!,
                      //                               childId,
                      //                               parentIdToChildren),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //     loading: () =>
                      //         const Center(child: CircularProgressIndicator()),
                      //     error: (error, stackTrace) => Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Lottie.asset(
                      //               'assets/animations/empty_list.json',
                      //               height: 200,
                      //               width: 200),
                      //           const Text(
                      //             "Nothing to display",
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (selectedParameter.isNotEmpty)
                      //   hierarchyAsync.when(
                      //     data: (hierarchy) {
                      //       final nodes = hierarchy.nodes;
                      //       final edges = hierarchy.edges;

                      //       final Map<String, String> nodeIdToLabel =
                      //           Map.fromEntries(
                      //         nodes.map((node) => MapEntry(
                      //             node.id, _formatName(node.label.name))),
                      //       );

                      //       final Map<String, List<String>> parentIdToChildren =
                      //           {};

                      //       for (var edge in edges) {
                      //         parentIdToChildren.putIfAbsent(
                      //             edge.from, () => []);
                      //         parentIdToChildren[edge.from]!.add(edge.to);
                      //       }

                      //       bool isRootSelected =
                      //           currentPath.contains(nodes[0].id);

                      //       return Container(
                      //         alignment: Alignment
                      //             .center, // Align everything to the center
                      //         margin: EdgeInsets.symmetric(
                      //           horizontal:
                      //               MediaQuery.of(context).size.width * 0.02,
                      //         ).copyWith(
                      //           top: MediaQuery.of(context).size.height * 0.005,
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment
                      //               .center, // Center the column content
                      //           children: [
                      //             SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Row(
                      //                 mainAxisAlignment: MainAxisAlignment
                      //                     .center, // Center the root node
                      //                 children: [
                      //                   SelectableSubGroupWidget(
                      //                     text:
                      //                         nodeIdToLabel[nodes[0].id] ?? '-',
                      //                     isSelected:
                      //                         currentPath.contains(nodes[0].id),
                      //                     onTap: () => _handleNodeTap(
                      //                         nodeIdToLabel[nodes[0].id]!,
                      //                         nodes[0].id,
                      //                         parentIdToChildren),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             if (isRootSelected)
                      //               ...currentPath.map((parentId) {
                      //                 final children =
                      //                     parentIdToChildren[parentId] ?? [];
                      //                 return Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005),
                      //                   child: SingleChildScrollView(
                      //                     scrollDirection: Axis.horizontal,
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment
                      //                           .center, // Center the children nodes
                      //                       children: children.map((childId) {
                      //                         return SelectableSubGroupWidget(
                      //                           text: nodeIdToLabel[childId] ??
                      //                               '',
                      //                           isSelected: currentPath
                      //                               .contains(childId),
                      //                           onTap: () => _handleNodeTap(
                      //                               nodeIdToLabel[childId]!,
                      //                               childId,
                      //                               parentIdToChildren),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //     loading: () =>
                      //         const Center(child: CircularProgressIndicator()),
                      //     error: (error, stackTrace) => Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Lottie.asset(
                      //               'assets/animations/empty_list.json',
                      //               height: 200,
                      //               width: 200),
                      //           const Text(
                      //             "Nothing to display",
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),

                      if (selectedParameter.isNotEmpty)
                        hierarchyAsync.when(
                          data: (hierarchy) {
                            final nodes = hierarchy.nodes;
                            final edges = hierarchy.edges;

                            final Map<String, String> nodeIdToLabel =
                                Map.fromEntries(
                              nodes.map((node) => MapEntry(
                                    node.id,
                                    _formatNameWithCount(node.label.name,
                                        node.label.allSubordinatesCount),
                                  )),
                            );

                            final Map<String, List<String>> parentIdToChildren =
                                {};

                            for (var edge in edges) {
                              parentIdToChildren.putIfAbsent(
                                  edge.from, () => []);
                              parentIdToChildren[edge.from]!.add(edge.to);
                            }

                            bool isRootSelected =
                                currentPath.contains(nodes[0].id);

                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02,
                              ).copyWith(
                                top: MediaQuery.of(context).size.height * 0.005,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SelectableSubGroupWidget(
                                          text:
                                              nodeIdToLabel[nodes[0].id] ?? '-',
                                          isSelected:
                                              currentPath.contains(nodes[0].id),
                                          onTap: () => _handleNodeTap(
                                            nodeIdToLabel[nodes[0].id]!,
                                            nodes[0].id,
                                            parentIdToChildren,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isRootSelected)
                                    ...currentPath.map((parentId) {
                                      final children =
                                          parentIdToChildren[parentId] ?? [];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005,
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: children.map((childId) {
                                              return SelectableSubGroupWidget(
                                                text: nodeIdToLabel[childId] ??
                                                    '',
                                                isSelected: currentPath
                                                    .contains(childId),
                                                onTap: () => _handleNodeTap(
                                                  nodeIdToLabel[childId]!,
                                                  childId,
                                                  parentIdToChildren,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                ],
                              ),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                    'assets/animations/empty_list.json',
                                    height: 200,
                                    width: 200),
                                const Text(
                                  "Nothing to display",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.05,
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ).copyWith(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            if (!selectedStates.contains(true) &&
                                images.isNotEmpty) {
                              selectedStates[0] = true;
                            }

                            return SelectableChartWidget(
                              imagePath: images[index],
                              isSelected: selectedStates[index],
                              onTap: () => handleTapForCharts(index),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _handlePrevTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 145, 173, 216),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(8),
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: currentMonth == DateTime.now().month
                                ? null
                                : _handleNextTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 145, 173, 216),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(8),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedHierarchyUser &&
                          selectedStates[0])
                        ref
                            .watch(userDataFutureProvider(Tuple4(
                                businessId,
                                selectedUserId,
                                selectedParameter,
                                currentMonth.toString())))
                            .when(
                              data: (userData) {
                                // return CustomChart(
                                //   parameter: selectedParameter,
                                //   predictedData: userData.userEntries,
                                //   actualData: userData.dailyTarget,
                                // );

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomChart(
                                        parameter: selectedParameter,
                                        actualData: userData.userEntries,
                                        predictedData:
                                            userData.dailyTargetAccumulated,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Graphicalstatistics(
                                    //     parameter: selectedParameter,
                                    //     actualData: userData.userEntries,
                                    //     predictedData:
                                    //         userData.dailyTargetAccumulated,
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (error, stackTrace) => Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedStates[2])
                        ref
                            .watch(userDataFutureProvider(Tuple4(
                                businessId,
                                selectedUserId,
                                selectedParameter,
                                currentMonth.toString())))
                            .when(
                              data: (userData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataTableWidget(
                                    parameter: selectedParameter,
                                    actualData: userData.userEntries,
                                    predictedData:
                                        userData.dailyTargetAccumulated,
                                  ),
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (error, stackTrace) => Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

// here adding Ratio Data Table for users selected
                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedHierarchyUser &&
                          selectedStates[2])
                        Column(
                          children: [
                            for (var pair in dropdownPairs.where((pair) =>
                                pair.firstSelectedItem == selectedParameter ||
                                pair.secondSelectedItem ==
                                    selectedParameter)) ...[
                              if (pair.firstSelectedItem != null &&
                                  pair.secondSelectedItem != null)
                                ref
                                    .watch(
                                        combinedUserDataFutureProvider(Tuple5(
                                      businessId,
                                      selectedUserId,
                                      pair.firstSelectedItem!,
                                      pair.secondSelectedItem!,
                                      currentMonth.toString(),
                                    )))
                                    .when(
                                      data: (data) {
                                        final firstDataModel = data[0];
                                        final secondDataModel = data[1];

                                        final firstData =
                                            firstDataModel.userEntries;
                                        final secondData =
                                            secondDataModel.userEntries;

                                        return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: DataTableForRatioWidget(
                                                firstitem:
                                                    pair.firstSelectedItem!,
                                                seconditem:
                                                    pair.secondSelectedItem!,
                                                actualData: firstData,
                                                predictedData: secondData));
                                      },
                                      loading: () =>
                                          const Center(child: Text('')),
                                      error: (error, stackTrace) => Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ],
                        ),

                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedStates[1])
                        ref
                            .watch(userPieDataFutureProvider(Tuple4(
                                businessId,
                                selectedUserId,
                                selectedParameter,
                                currentMonth.toString())))
                            .when(
                              data: (userData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PiechartGraph1(
                                    parameter: selectedParameter,
                                    actualData: userData.userEntries,
                                  ),
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (error, stackTrace) => Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      // if (selectedHierarchyUser &&
                      //     selectedParameter.isNotEmpty &&
                      //     selectedUserId.isNotEmpty &&
                      //     selectedStates[3])
                      //   ref
                      //       .watch(userCommentsFutureProvider(Tuple4(
                      //           businessId,
                      //           selectedUserId,
                      //           selectedParameter,
                      //           currentMonth.toString())))
                      //       .when(
                      //         data: (commentsData) {
                      //           return Column(
                      //             children: commentsData.reversed.map((entry) {
                      //               return Card(
                      //                 margin: EdgeInsets.symmetric(
                      //                   vertical: 8.0,
                      //                   horizontal: 16.0,
                      //                 ),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     ListTile(
                      //                       title: Text(entry.date),
                      //                     ),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: entry.comments
                      //                           .map((commentDetail) {
                      //                         return Padding(
                      //                           padding: EdgeInsets.symmetric(
                      //                               horizontal: 16.0),
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               ListTile(
                      //                                 title: Text(commentDetail
                      //                                     .todaysComment),
                      //                                 subtitle: Text(
                      //                                   'Added by: ${commentDetail.addedBy} on ${commentDetail.date}',
                      //                                 ),
                      //                               ),
                      //                               SizedBox(
                      //                                   height:
                      //                                       8.0), // Adjust spacing as needed
                      //                             ],
                      //                           ),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             }).toList(),
                      //           );
                      //         },
                      //         loading: () =>
                      //             Center(child: CircularProgressIndicator()),
                      //         error: (error, stackTrace) => Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedStates[3])
                        ref
                            .watch(userCommentsFutureProvider(Tuple4(
                                businessId,
                                selectedUserId,
                                selectedParameter,
                                currentMonth.toString())))
                            .when(
                              data: (commentsData) {
                                final reversedCommentsData =
                                    commentsData.reversed.toList();

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: reversedCommentsData.length,
                                  itemBuilder: (context, index) {
                                    final entry = reversedCommentsData[index];
                                    return Column(
                                      children:
                                          entry.comments.map((commentDetail) {
                                        return CommentBubble(
                                          profileImage:
                                              'https://randomuser.me/api/portraits/lego/2.jpg', // Replace with actual profile image URL
                                          message: commentDetail.todaysComment,
                                          sender: commentDetail.addedBy,
                                          timestamp: commentDetail.time,
                                          dateAdded: DateTime.parse(entry.date),
                                        );
                                      }).toList(),
                                    );
                                  },
                                );
                              },
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                              error: (error, stackTrace) => Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      if (selectedStates.isNotEmpty &&
                          selectedStates[0] &&
                          selectedParameter.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomChart(
                            parameter: '',
                            actualData: [],
                            predictedData: [],
                          ),
                        ),

// after these are only parameter selected --- checkpoint

                      if (selectedStates.isNotEmpty &&
                          selectedStates[0] &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isEmpty &&
                          !selectedHierarchyUser)
                        FutureBuilder<UserDataModel>(
                          future: dataAddedController.fetchDataAdded(businessId,
                              selectedParameter, currentMonth.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(child: Text('No data available'));
                            } else {
                              UserDataModel data = snapshot.data!;
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomChart(
                                      parameter: selectedParameter,
                                      actualData: data.userEntries,
                                      predictedData:
                                          data.dailyTargetAccumulated,
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Graphicalstatistics(
                                  //     parameter: selectedParameter,
                                  //     actualData: data.userEntries,
                                  //     predictedData:
                                  //         data.dailyTargetAccumulated,
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                          },
                        ),
                      if (selectedStates.isNotEmpty &&
                          selectedStates[1] &&
                          selectedParameter.isNotEmpty &&
                          !selectedHierarchyUser)
                        FutureBuilder<UserDataModel>(
                          future: dataAddedController.fetchDataAdded(businessId,
                              selectedParameter, currentMonth.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              UserDataModel data = snapshot.data!;
                              print(data);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PiechartGraph1(
                                  parameter: selectedParameter,
                                  actualData: userEntries,
                                ),
                              );
                            }
                          },
                        ),
                      if (selectedStates.isNotEmpty &&
                          selectedStates[2] &&
                          selectedParameter.isNotEmpty &&
                          !selectedHierarchyUser)
                        FutureBuilder<UserDataModel>(
                          future: dataAddedController.fetchDataAdded(businessId,
                              selectedParameter, currentMonth.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              UserDataModel data = snapshot.data!;
                              print(data);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTableWidget(
                                  parameter: selectedParameter,
                                  actualData: data.userEntries,
                                  predictedData: data.dailyTargetAccumulated,
                                ),
                              );
                            }
                          },
                        ),
                      if (selectedStates.isNotEmpty &&
                          selectedStates[2] &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isEmpty &&
                          !selectedHierarchyUser)
                        Column(
                          children: [
                            for (var pair in dropdownPairs.where((pair) =>
                                pair.firstSelectedItem == selectedParameter ||
                                pair.secondSelectedItem ==
                                    selectedParameter)) ...[
                              if (pair.firstSelectedItem != null &&
                                  pair.secondSelectedItem != null)
                                FutureBuilder<List<dynamic>>(
                                  future: Future.wait([
                                    dataAddedController.fetchDataAdded(
                                      businessId,
                                      pair.firstSelectedItem!,
                                      currentMonth.toString(),
                                    ),
                                    dataAddedController.fetchDataAdded(
                                      businessId,
                                      pair.secondSelectedItem!,
                                      currentMonth.toString(),
                                    ),
                                  ]),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (!snapshot.hasData) {
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var firstDataModel =
                                          snapshot.data![0] as UserDataModel;
                                      var secondDataModel =
                                          snapshot.data![1] as UserDataModel;

                                      List<List<dynamic>> firstData =
                                          firstDataModel.userEntries;
                                      List<List<dynamic>> secondData =
                                          secondDataModel.userEntries;

                                      return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: DataTableForRatioWidget(
                                              firstitem:
                                                  pair.firstSelectedItem!,
                                              seconditem:
                                                  pair.secondSelectedItem!,
                                              actualData: firstData,
                                              predictedData: secondData));
                                    }
                                  },
                                ),
                            ],
                          ],
                        ),

                      // if (selectedStates[3] &&
                      //     selectedParameter.isNotEmpty &&
                      //     selectedUserId.isEmpty &&
                      //     !selectedHierarchyUser)
                      //   FutureBuilder<CommentsDataModel>(
                      //     future: ref
                      //         .read(commentsDataControllerProvider)
                      //         .fetchCommentsData(businessId, selectedParameter,
                      //             currentMonth.toString()),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return const Center(
                      //             child: CircularProgressIndicator());
                      //       } else if (snapshot.hasError) {
                      //         return Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       } else if (!snapshot.hasData ||
                      //           snapshot.data!.comments.isEmpty) {
                      //         return Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       } else {
                      //         final commentsData = snapshot.data!;
                      //         return Column(
                      //           children:
                      //               commentsData.comments.reversed.map((entry) {
                      //             return Card(
                      //               margin: EdgeInsets.symmetric(
                      //                 vertical: 8.0,
                      //                 horizontal: 16.0,
                      //               ),
                      //               child: Column(
                      //                 children: [
                      //                   ListTile(
                      //                     title: Text(entry.date),
                      //                   ),
                      //                   ...entry.comments.map((commentDetail) {
                      //                     return ListTile(
                      //                       title:
                      //                           Text(commentDetail.todaysComment),
                      //                       subtitle: Text(
                      //                           'Added by: ${commentDetail.addedBy} on ${commentDetail.date}'),
                      //                     );
                      //                   }).toList(),
                      //                 ],
                      //               ),
                      //             );
                      //           }).toList(),
                      //         );
                      //       }
                      //     },
                      //   ),
                      if (selectedStates[3] &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isEmpty &&
                          !selectedHierarchyUser)
                        FutureBuilder<CommentsDataModel>(
                          future: ref
                              .read(commentsDataControllerProvider)
                              .fetchCommentsData(businessId, selectedParameter,
                                  currentMonth.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.comments.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/animations/empty_list.json',
                                        height: 200,
                                        width: 200),
                                    const Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final commentsData = snapshot.data!;
                              // Reverse the comments list
                              final reversedCommentsData =
                                  commentsData.comments.reversed.toList();

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: reversedCommentsData.length,
                                itemBuilder: (context, index) {
                                  final entry = reversedCommentsData[index];
                                  return Column(
                                    children:
                                        entry.comments.map((commentDetail) {
                                      return CommentBubble(
                                        profileImage:
                                            'https://randomuser.me/api/portraits/lego/2.jpg', // Replace with actual profile image URL
                                        message: commentDetail.todaysComment,
                                        sender: commentDetail.addedBy,
                                        timestamp: commentDetail.time,
                                        dateAdded: DateTime.parse(entry.date),
                                      );
                                    }).toList(),
                                  );
                                },
                              );
                            }
                          },
                        ),

                      // for displaying progress bar if only parameter and states is selected

                      // if (selectedStates.isNotEmpty &&
                      //     selectedStates[2] &&
                      //     selectedParameter.isNotEmpty &&
                      //     selectedUserId.isEmpty &&
                      //     !selectedHierarchyUser)
                      //   FutureBuilder<UserDataModel>(
                      //     future: dataAddedController.fetchDataAdded(businessId,
                      //         selectedParameter, currentMonth.toString()),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasError) {
                      //         return Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       } else if (!snapshot.hasData) {
                      //         return Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       } else {
                      //         UserDataModel data = snapshot.data!;
                      //         return Padding(
                      //           padding: const EdgeInsets.all(16.0),
                      //           child: Column(
                      //             children: [
                      //               ProgressBarWidget(
                      //                 label: selectedParameter,
                      //                 TargetValue: data.actualTotalTarget,
                      //                 AchievedValue: data.totalTargetAchieved,
                      //                 color: getRandomColor(),
                      //               ),
                      //               Text(
                      //                 getMonthName(currentMonth),
                      //                 style: TextStyle(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }
                      //     },
                      //   ),

                      // for displaying the custom ratio charts just below the progress bar indicator if parameter is selected and no user is selected

                      if (selectedStates.isNotEmpty &&
                          selectedStates[0] &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isEmpty &&
                          !selectedHierarchyUser)
                        Column(
                          children: [
                            for (var pair in dropdownPairs.where((pair) =>
                                pair.firstSelectedItem == selectedParameter ||
                                pair.secondSelectedItem ==
                                    selectedParameter)) ...[
                              if (pair.firstSelectedItem != null &&
                                  pair.secondSelectedItem != null)
                                FutureBuilder<List<dynamic>>(
                                  future: Future.wait([
                                    dataAddedController.fetchDataAdded(
                                      businessId,
                                      pair.firstSelectedItem!,
                                      currentMonth.toString(),
                                    ),
                                    dataAddedController.fetchDataAdded(
                                      businessId,
                                      pair.secondSelectedItem!,
                                      currentMonth.toString(),
                                    ),
                                  ]),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (!snapshot.hasData) {
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var firstDataModel =
                                          snapshot.data![0] as UserDataModel;
                                      var secondDataModel =
                                          snapshot.data![1] as UserDataModel;

                                      List<List<dynamic>> firstData =
                                          firstDataModel.userEntries;
                                      List<List<dynamic>> secondData =
                                          secondDataModel.userEntries;

                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CustomRatioChart(
                                          firstParameter:
                                              pair.firstSelectedItem!,
                                          secondParameter:
                                              pair.secondSelectedItem!,
                                          firstData: firstData,
                                          secondData: secondData,
                                          benchmark: pair.values,
                                        ),
                                      );
                                    }
                                  },
                                ),
                            ],
                          ],
                        ),

                      // for displaying progress bar if user and parameter is selected
                      // if (selectedHierarchyUser &&
                      //     selectedParameter.isNotEmpty &&
                      //     selectedUserId.isNotEmpty &&
                      //     selectedHierarchyUser &&
                      //     selectedStates[2])
                      //   ref
                      //       .watch(userDataFutureProvider(Tuple4(
                      //           businessId,
                      //           selectedUserId,
                      //           selectedParameter,
                      //           currentMonth.toString())))
                      //       .when(
                      //         data: (userData) {
                      //           return Padding(
                      //             padding: const EdgeInsets.all(16.0),
                      //             child: Column(
                      //               children: [
                      //                 ProgressBarWidget(
                      //                   label: selectedParameter,
                      //                   TargetValue: userData.actualTotalTarget,
                      //                   AchievedValue:
                      //                       userData.totalTargetAchieved,
                      //                   color: getRandomColor(),
                      //                 ),
                      //                 Text(
                      //                   getMonthName(currentMonth),
                      //                   style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //         loading: () => const Center(
                      //             child: CircularProgressIndicator()),
                      //         error: (error, stackTrace) => Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Lottie.asset(
                      //                   'assets/animations/empty_list.json',
                      //                   height: 200,
                      //                   width: 200),
                      //               const Text(
                      //                 "Nothing to display",
                      //                 style: TextStyle(
                      //                   color: Colors.grey,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),

// displaying the Customratio graph for Added Charts by the user if parameter is selected and User is also selected
                      if (selectedHierarchyUser &&
                          selectedParameter.isNotEmpty &&
                          selectedUserId.isNotEmpty &&
                          selectedHierarchyUser &&
                          selectedStates[0])
                        Column(
                          children: [
                            for (var pair in dropdownPairs.where((pair) =>
                                pair.firstSelectedItem == selectedParameter ||
                                pair.secondSelectedItem ==
                                    selectedParameter)) ...[
                              if (pair.firstSelectedItem != null &&
                                  pair.secondSelectedItem != null)
                                ref
                                    .watch(
                                        combinedUserDataFutureProvider(Tuple5(
                                      businessId,
                                      selectedUserId,
                                      pair.firstSelectedItem!,
                                      pair.secondSelectedItem!,
                                      currentMonth.toString(),
                                    )))
                                    .when(
                                      data: (data) {
                                        final firstDataModel = data[0];
                                        final secondDataModel = data[1];

                                        final firstData =
                                            firstDataModel.userEntries;
                                        final secondData =
                                            secondDataModel.userEntries;

                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: CustomRatioChart(
                                            firstParameter:
                                                pair.firstSelectedItem!,
                                            secondParameter:
                                                pair.secondSelectedItem!,
                                            firstData: firstData,
                                            secondData: secondData,
                                            benchmark: pair.values,
                                          ),
                                        );
                                      },
                                      loading: () =>
                                          const Center(child: Text('')),
                                      error: (error, stackTrace) => Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                                'assets/animations/empty_list.json',
                                                height: 200,
                                                width: 200),
                                            const Text(
                                              "Nothing to display",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ],
                        ),
                    ],
                  ),
                )),
    );
  }

  String _formatName(String fullName) {
    final parts = fullName.split(' ');
    if (parts.length > 1) {
      return '${parts[0]} ${parts[1][0]}'; // First name + initial of the last name
    } else {
      return fullName; // Single-word name
    }
  }

  String _formatNameWithCount(String name, int count) {
    return '$name ($count)';
  }

  final List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  Color getRandomColor() {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  String getMonthName(int month) {
    DateTime dateTime = DateTime(DateTime.now().year, month);
    return DateFormat('MMMM').format(dateTime);
  }
}
