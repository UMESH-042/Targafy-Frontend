import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import 'package:lottie/lottie.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/home/view/screens/controller/actual_predicted_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/data_of_subgroup_users_controller.dart';
import 'package:targafy/src/home/view/screens/controller/fetchSubGroup_controller.dart';
import 'package:targafy/src/home/view/screens/controller/parameter_group_list_controller.dart';
import 'package:targafy/src/home/view/screens/controller/sub_group_data_provider_controller.dart';
import 'package:targafy/src/home/view/screens/controller/subgroup_user_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/GraphicalStatistics.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/home/view/widgets/selectable_sub_group.dart';
import 'package:targafy/src/home/view/widgets/selectable_username.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';
import 'package:targafy/src/users/ui/controller/user_hierarchy_controller.dart';
import 'package:targafy/src/users/ui/model/user_hierarchy_model.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'widgets/CustomCharts.dart';
import 'widgets/DataTable.dart';
import 'widgets/PieChart.dart';

String domain = AppRemoteRoutes.baseUrl;

// Providers
final selectedBusinessData = Provider<Map<String, dynamic>?>((ref) {
  return ref.watch(currentBusinessProvider);
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
  // Map<String, bool> expandedNodes = {};
  // List<String> visibleNodeIds = [];
  List<String> currentPath = [];

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameter = '';
    selectedUser = '';
    selectedUserId = '';

    // _getToken();
  }

  static const List<String> images = [
    'assets/img/line_chart_invert.png',
    'assets/img/table_invert.png',
    'assets/img/chat_invert.png',
    'assets/img/pie_invert.png',
    'assets/img/line_invert.png'
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

    // Perform your refresh logic here
    await Future.delayed(Duration(seconds: 2)); // Simulating delay

    setState(() {
      _isRefreshing = false;
    });
  }

  // void _toggleNodeExpansion(String nodeId) {
  //   setState(() {
  //     expandedNodes[nodeId] = !(expandedNodes[nodeId] ?? false);
  //   });
  // }

  // void _handleNodeTap(String nodeId) {
  //   setState(() {
  //     if (visibleNodeIds.contains(nodeId)) {
  //       visibleNodeIds.remove(nodeId);
  //     } else {
  //       visibleNodeIds.add(nodeId);
  //     }
  //   });
  // }
  // void _handleNodeTap(String nodeName, String nodeId) {
  //   setState(() {
  //     if (currentPath.contains(nodeId)) {
  //       currentPath.remove(nodeId);
  //     } else {
  //       currentPath.add(nodeId);
  //     }
  //   });
  // }
  // Function to handle node tap
  void _handleNodeTap(String nodeName, String nodeId,
      Map<String, List<String>> parentIdToChildren) {
    setState(() {
      if (currentPath.contains(nodeId)) {
        _removeDescendants(nodeId, parentIdToChildren);
      } else {
        currentPath.add(nodeId);
      }
    });
  }

// Function to remove descendants of a node
  void _removeDescendants(
      String nodeId, Map<String, List<String>> parentIdToChildren) {
    final nodesToRemove = _getDescendants(nodeId, parentIdToChildren);
    currentPath.removeWhere((id) => nodesToRemove.contains(id));
    currentPath.remove(nodeId);
  }

// Helper function to get all descendants of a node
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
  // void _handleNodeTap(String nodeName, String nodeId) {
  //   setState(() {
  //     if (currentPath.contains(nodeId)) {
  //       currentPath.remove(nodeId);
  //     } else {
  //       currentPath.add(nodeId);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final parameterListAsync = ref.watch(parameterListProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final dataAddedController = ref.watch(dataAddedControllerProvider);

    final businessId = selectedBusinessData?['business']?.id;

    final hierarchyAsync = ref.watch(businessHierarchyProvider);

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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      ).copyWith(
                        top: MediaQuery.of(context).size.height * 0.03,
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
                    parameterListAsync.when(
                      data: (parameterList) {
                        // if (selectedParameter.isEmpty && parameterList.isNotEmpty) {
                        //   selectedParameter = parameterList[0].name;

                        //   ref.invalidate(GroupProvider);
                        // }
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.035,
                          ).copyWith(
                            top: MediaQuery.of(context).size.height * 0.01,
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
                                isSelected: parameterName == selectedParameter,
                                onTap: () => _handleTapForParameters(
                                    parameterName, paramId),
                              );
                            },
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(child: Text('')),
                      // Center(child: Text('Error: $error')),
                    ),
                    if (selectedParameter.isNotEmpty)
                      hierarchyAsync.when(
                        data: (hierarchy) {
                          final nodes = hierarchy.nodes;
                          final edges = hierarchy.edges;

                          // Create a map to store node labels by ID for quick access
                          final Map<String, String> nodeIdToLabel =
                              Map.fromEntries(
                            nodes.map(
                                (node) => MapEntry(node.id, node.label.name)),
                          );

                          // Initialize a map to track child nodes by parent ID
                          final Map<String, List<String>> parentIdToChildren =
                              {};

                          for (var edge in edges) {
                            parentIdToChildren.putIfAbsent(edge.from, () => []);
                            parentIdToChildren[edge.from]!.add(edge.to);
                          }

                          // Function to build the hierarchy rows
                          List<Widget> buildHierarchy(String parentId) {
                            if (!parentIdToChildren.containsKey(parentId)) {
                              return [];
                            }

                            return parentIdToChildren[parentId]!.map((childId) {
                              final childLabel = nodeIdToLabel[childId] ?? '-';
                              return SelectableSubGroupWidget(
                                text: childLabel,
                                isSelected: currentPath.contains(childId),
                                onTap: () => _handleNodeTap(
                                    childLabel, childId, parentIdToChildren),
                              );
                            }).toList();
                          }

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.035,
                            ).copyWith(
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SelectableSubGroupWidget(
                                        text: nodes[0].label.name.isNotEmpty
                                            ? nodes[0].label.name
                                            : '-',
                                        isSelected:
                                            currentPath.contains(nodes[0].id),
                                        onTap: () => _handleNodeTap(
                                            nodes[0].label.name,
                                            nodes[0].id,
                                            parentIdToChildren),
                                      ),
                                    ],
                                  ),
                                ),
                                ...currentPath.map((parentId) {
                                  final children =
                                      parentIdToChildren[parentId] ?? [];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: children.map((childId) {
                                          return SelectableSubGroupWidget(
                                            text: nodeIdToLabel[childId] ?? '',
                                            isSelected:
                                                currentPath.contains(childId),
                                            onTap: () => _handleNodeTap(
                                                nodeIdToLabel[childId]!,
                                                childId,
                                                parentIdToChildren),
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
                        error: (error, stackTrace) =>
                            Center(child: Text('Error: $error')),
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
                    if (selectedStates.isNotEmpty &&
                        selectedStates[0] &&
                        selectedParameter.isNotEmpty)
                      FutureBuilder<Map<String, List<List<dynamic>>>>(
                        future: dataAddedController.fetchDataAdded(
                            businessId, selectedParameter),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return Center(child: Text('No data available'));
                          } else {
                            Map<String, List<List<dynamic>>> data =
                                snapshot.data!;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomChart(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData:
                                        data['dailyTargetAccumulated'] ?? [],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Graphicalstatistics(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData:
                                        data['dailyTargetAccumulated'] ?? [],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[3] &&
                        selectedParameter.isNotEmpty)
                      FutureBuilder(
                        future: dataAddedController.fetchDataAdded(
                            businessId, selectedParameter),
                        builder: (context,
                            AsyncSnapshot<Map<String, List<List<dynamic>>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final data = snapshot.data!;
                            print(data);
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PiechartGraph(
                                  parameter: selectedParameter,
                                  actualData: data['userEntries'] ?? [],
                                ));
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[1] &&
                        selectedParameter.isNotEmpty)
                      FutureBuilder(
                        future: dataAddedController.fetchDataAdded(
                            businessId, selectedParameter),
                        builder: (context,
                            AsyncSnapshot<Map<String, List<List<dynamic>>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final data = snapshot.data!;
                            print(data);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DataTableWidget(
                                  parameter: selectedParameter,
                                  actualData: data['userEntries'] ?? [],
                                  predictedData:
                                      data['dailyTargetAccumulated'] ?? []),
                            );
                          }
                        },
                      ),
                    if (selectedStates[2])
                      Center(
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
                      ),
                    if (selectedStates[4])
                      Center(
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
                      )
                  ],
                ),
              ),
      ),
    );
  }
}
