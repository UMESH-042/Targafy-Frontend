import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    FutureProvider.autoDispose<List<Parameter>>((ref) async {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;

  if (businessId != null) {
    final notifier = ref.read(parameterNotifierProvider.notifier);
    await notifier.fetchParameters(businessId);
    return ref.watch(parameterNotifierProvider);
  } else {
    return <Parameter>[];
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
  late String selectedGroup;
  late String groupId;
  late String IdForSubGroup;
  late String selectedUser;
  late String selectedUserId;
  late String selectedSubOffice;
  late String selectedSubgroupId;

  bool _isRefreshing = false;
  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameter = '';
    selectedGroup = '';
    IdForSubGroup = '';
    selectedUser = '';
    selectedUserId = '';
    selectedSubOffice = '';
    selectedSubgroupId = '';
    groupId = '';
    // _getToken();
  }

  // Future<void> _refreshData() async {
  //   // Here, you can invalidate any providers you need to refresh the data.
  //   ref.invalidate(parameterListProvider);
  //   ref.invalidate(GroupProvider);
  //   ref.invalidate(subGroupDetailsProvider(IdForSubGroup));
  //   ref.invalidate(userGroupProvider(IdForSubGroup));
  //   ref.invalidate(userDataControllerProvider);
  //   ref.invalidate(dataAddedControllerProvider);
  //   ref.invalidate(SubGroupDataControllerProvider);

  //   // You can also add any additional logic you need for refreshing data.
  // }

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

  Future<void> _handleTapForParameters(String parameterName) async {
    setState(() {
      selectedParameter =
          selectedParameter == parameterName ? '' : parameterName;
      selectedSubOffice = '';
    });

    if (selectedParameter.isNotEmpty) {
      ref.invalidate(GroupProvider);
    }
  }

  Future<void> _handleTapForGroups(
      String GroupName, String parentGroupId) async {
    setState(() {
      selectedGroup = selectedGroup == GroupName ? '' : GroupName;
    });

    if (selectedGroup.isNotEmpty) {
      IdForSubGroup = parentGroupId;
      groupId = parentGroupId;
      print('this is the parent Group Id :- ${IdForSubGroup}');
    }

    if (selectedGroup.isNotEmpty) {
      ref.invalidate(subGroupDetailsProvider(IdForSubGroup));
    }
  }

  void _handleUserTap(String username, String userId) {
    setState(() {
      selectedUser = selectedUser == username ? '' : username;
      selectedUserId = userId;
    });
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    if (businessId != null && selectedParameter.isNotEmpty) {
      ref
          .read(userDataControllerProvider)
          .fetchUserData(businessId, selectedParameter, userId);
    }

    ref.invalidate(userDataControllerProvider);
  }

  void _handleSubGroupTap(String SubOfficeName, String subgroupId) {
    setState(() {
      selectedSubOffice =
          selectedSubOffice == SubOfficeName ? '' : SubOfficeName;
    });
    if (selectedSubOffice.isNotEmpty) {
      selectedSubgroupId = subgroupId;
    }
    print('This is the selected Subgroup Id :- $selectedSubgroupId');
    if (selectedSubOffice.isNotEmpty) {
      ref.invalidate(userGroupProvider(IdForSubGroup));
    }
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

  @override
  Widget build(BuildContext context) {
    final parameterListAsync = ref.watch(parameterListProvider);
    final dataAddedController = ref.read(dataAddedControllerProvider);
    final SubGroupDataController = ref.read(SubGroupDataControllerProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

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
                              return SelectableParameterWidget(
                                text: parameterName,
                                isSelected: parameterName == selectedParameter,
                                onTap: () =>
                                    _handleTapForParameters(parameterName),
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
                      ref.watch(GroupProvider).when(
                            data: (Groups) {
                              // if (selectedGroup.isEmpty && Groups.isNotEmpty) {
                              //   selectedGroup = Groups[0].headOfficeName;
                              //   IdForSubGroup = Groups[0].id;
                              //   groupId = Groups[0].id;
                              //   ref.invalidate(subGroupDetailsProvider(IdForSubGroup));
                              // }
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.035,
                                ).copyWith(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Groups.length,
                                  itemBuilder: (context, index) {
                                    final GroupName =
                                        Groups[index].headOfficeName;
                                    final parentGroupId = Groups[index].id;
                                    return SelectableSubGroupWidget(
                                      text: GroupName,
                                      isSelected: GroupName == selectedGroup,
                                      onTap: () => _handleTapForGroups(
                                          GroupName, parentGroupId),
                                    );
                                  },
                                ),
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Center(child: Text('')),
                            // Center(child: Text('Error: $error')),
                          ),
                    if (selectedGroup.isNotEmpty &&
                        selectedParameter.isNotEmpty)
                      ref.watch(subGroupDetailsProvider(IdForSubGroup)).when(
                            data: (SubGroup) {
                              // if (selectedSubOffice.isEmpty && SubGroup.isNotEmpty) {
                              //   selectedSubOffice = SubGroup[0].subOfficeName;
                              //   selectedSubgroupId = SubGroup[0].groupId;
                              //   ref.invalidate(userGroupProvider(IdForSubGroup));
                              // }
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.035,
                                ).copyWith(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: SubGroup.length,
                                  itemBuilder: (context, index) {
                                    final subofficeName =
                                        SubGroup[index].subOfficeName;
                                    final subgroupId = SubGroup[index].groupId;
                                    return SelectableUsername(
                                      text: subofficeName,
                                      isSelected:
                                          subofficeName == selectedSubOffice,
                                      onTap: () => _handleSubGroupTap(
                                          subofficeName, subgroupId),
                                    );
                                  },
                                ),
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Center(child: Text('')),
                          ),
         

                    if (selectedSubOffice.isNotEmpty &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty)
                      ref.watch(userGroupProvider(groupId)).when(
                            data: (userGroup) {
                              // if (selectedUser.isEmpty &&
                              //     userGroup.businessUsers.isNotEmpty) {
                              //   selectedUser = userGroup.businessUsers[0].name;
                              //   selectedUserId = userGroup.users[0].id;
                              // }
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.035,
                                ).copyWith(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userGroup.businessUsers.length,
                                  itemBuilder: (context, index) {
                                    final businessUser =
                                        userGroup.businessUsers[index];
                                    final userid = userGroup.users[index].id;
                                    final username = businessUser.name;
                                    return SelectableUsername(
                                      text: username,
                                      isSelected: username == selectedUser,
                                      onTap: () =>
                                          _handleUserTap(username, userid),
                                    );
                                  },
                                ),
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Center(child: Text('')),
                            // Center(child: Text('Error: $error')),
                          ),
                    if (selectedSubOffice.isEmpty &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty)
                      ref.watch(userGroupProvider(IdForSubGroup)).when(
                            data: (userGroup) {
                              // if (selectedUser.isEmpty &&
                              //     userGroup.businessUsers.isNotEmpty) {
                              //   selectedUser = userGroup.businessUsers[0].name;
                              //   selectedUserId = userGroup.users[0].id;
                              // }
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.035,
                                ).copyWith(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: userGroup.businessUsers.length,
                                  itemBuilder: (context, index) {
                                    final businessUser =
                                        userGroup.businessUsers[index];
                                    final userid = userGroup.users[index].id;
                                    final username = businessUser.name;
                                    return SelectableUsername(
                                      text: username,
                                      isSelected: username == selectedUser,
                                      onTap: () =>
                                          _handleUserTap(username, userid),
                                    );
                                  },
                                ),
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Center(child: Text('')),
                            // Center(child: Text('Error: $error')),
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
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isEmpty &&
                        selectedSubOffice.isEmpty &&
                        selectedUser.isEmpty)
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
                              child: CustomChart(
                                parameter: selectedParameter,
                                actualData: data['userEntries'] ?? [],
                                predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[3] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isEmpty &&
                        selectedSubOffice.isEmpty &&
                        selectedUser.isEmpty)
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
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isEmpty &&
                        selectedSubOffice.isEmpty &&
                        selectedUser.isEmpty)
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
                                  predictedData: data['dailyTarget'] ?? []),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[0] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isEmpty &&
                        selectedUser.isEmpty)
                      FutureBuilder(
                        future: SubGroupDataController.fetchDataAdded(
                            groupId, selectedParameter),
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
                              child: CustomChart(
                                parameter: selectedParameter,
                                actualData: data['userEntries'] ?? [],
                                predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[0] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isNotEmpty &&
                        selectedUser.isEmpty)
                      FutureBuilder(
                        future: SubGroupDataController.fetchDataAdded(
                            selectedSubgroupId, selectedParameter),
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
                              child: CustomChart(
                                parameter: selectedParameter,
                                actualData: data['userEntries'] ?? [],
                                predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[1] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isNotEmpty &&
                        selectedUser.isEmpty)
                      FutureBuilder(
                        future: SubGroupDataController.fetchDataAdded(
                            selectedSubgroupId, selectedParameter),
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
                                predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[3] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isNotEmpty &&
                        selectedUser.isEmpty)
                      FutureBuilder(
                        future: SubGroupDataController.fetchDataAdded(
                            selectedSubgroupId, selectedParameter),
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
                                // predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[0] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isNotEmpty &&
                        selectedUser.isNotEmpty)
                      FutureBuilder<Map<String, List<List<dynamic>>>>(
                        future: ref
                            .read(userDataControllerProvider)
                            .fetchUserData(
                                businessId!, selectedParameter, selectedUserId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            //       return Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: CustomChart(
                            //           parameter: selectedParameter,
                            //           actualData: data['userEntries'] ?? [],
                            //           predictedData: data['dailyTarget'] ?? [],
                            //         ),
                            //       );
                            //     } else {
                            //       return const Center(child: Text('No data available'));
                            //     }
                            //   },
                            // ),
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomChart(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData: data['dailyTarget'] ?? [],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Graphicalstatistics(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData: data['dailyTarget'] ?? [],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[0] &&
                        selectedParameter.isNotEmpty &&
                        selectedGroup.isNotEmpty &&
                        selectedSubOffice.isEmpty &&
                        selectedUser.isNotEmpty)
                      FutureBuilder<Map<String, List<List<dynamic>>>>(
                        future: ref
                            .read(userDataControllerProvider)
                            .fetchUserData(
                                businessId!, selectedParameter, selectedUserId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            //       return Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: CustomChart(
                            //           parameter: selectedParameter,
                            //           actualData: data['userEntries'] ?? [],
                            //           predictedData: data['dailyTarget'] ?? [],
                            //         ),
                            //       );
                            //     } else {
                            //       return const Center(child: Text('No data available'));
                            //     }
                            //   },
                            // ),
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomChart(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData: data['dailyTarget'] ?? [],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Graphicalstatistics(
                                    parameter: selectedParameter,
                                    actualData: data['userEntries'] ?? [],
                                    predictedData: data['dailyTarget'] ?? [],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[1] &&
                        selectedParameter.isNotEmpty &&
                        selectedUser.isNotEmpty)
                      FutureBuilder<Map<String, List<List<dynamic>>>>(
                        future: ref
                            .read(userDataControllerProvider)
                            .fetchUserData(
                                businessId!, selectedParameter, selectedUserId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DataTableWidget(
                                parameter: selectedParameter,
                                actualData: data['userEntries'] ?? [],
                                predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                    if (selectedStates.isNotEmpty &&
                        selectedStates[3] &&
                        selectedParameter.isNotEmpty &&
                        selectedUser.isNotEmpty)
                      FutureBuilder<Map<String, List<List<dynamic>>>>(
                        future: ref
                            .read(userDataControllerProvider)
                            .fetchUserData(
                                businessId!, selectedParameter, selectedUserId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PiechartGraph(
                                parameter: selectedParameter,
                                actualData: data['userEntries'] ?? [],
                                // predictedData: data['dailyTarget'] ?? [],
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
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
