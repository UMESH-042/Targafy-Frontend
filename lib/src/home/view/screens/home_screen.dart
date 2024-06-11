import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/controller/actual_predicted_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/data_of_subgroup_users_controller.dart';
import 'package:targafy/src/home/view/screens/controller/fetching_id_controller.dart';
import 'package:targafy/src/home/view/screens/controller/parameter_group_list_controller.dart';
import 'package:targafy/src/home/view/screens/controller/sub_group_data_provider_controller.dart';
import 'package:targafy/src/home/view/screens/controller/subgroup_user_controller.dart';
import 'package:targafy/src/home/view/screens/model/subgroup_user_model.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/home/view/widgets/selectable_sub_group.dart';
import 'package:targafy/src/home/view/widgets/selectable_username.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';
import 'widgets/CustomCharts.dart';
import 'widgets/DataTable.dart';
import 'widgets/PieChart.dart';

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
  late String selectedSubGroup;
  late String groupId;
  late String subgroupId;
  late String selectedUser;
  late String selectedUserId;

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameter = '';
    selectedSubGroup = '';
    subgroupId = '';
    selectedUser = '';
    selectedUserId = '';
    _getToken();
  }

  Future<void> _getToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');

      if (fcmToken != null && bearerToken != null) {
        await _sendTokenToServer(fcmToken, bearerToken);
      } else {
        print('Failed to retrieve FCM token or bearer token.');
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
    try {
      final url = Uri.parse(
          'http://13.234.163.59:5000/api/v1/user/update/fcmToken?fcmToken=$fcmToken');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        print('Token sent successfully.');
      } else {
        print('Failed to send token: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  static const List<String> images = [
    'assets/img/line_chart.png',
    'assets/img/table.png',
    'assets/img/chat.png',
    'assets/img/pie.png',
    'assets/img/lines.png'
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
      selectedSubGroup = '';
    });
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null && selectedParameter.isNotEmpty) {
      final groupController = ref.read(groupControllerProvider);
      final fetchedGroupId =
          await groupController.getGroupId(businessId, selectedParameter);
      if (fetchedGroupId != null) {
        groupId = fetchedGroupId;
        print(groupId);
      } else {
        print('Failed to fetch Group ID');
      }
    }

    if (selectedParameter.isNotEmpty) {
      ref.invalidate(subGroupProvider(selectedParameter));
    }
  }

  Future<void> _handleTapForSubGroups(String subGroupName) async {
    setState(() {
      selectedSubGroup = selectedSubGroup == subGroupName ? '' : subGroupName;
    });

    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null && selectedSubGroup.isNotEmpty) {
      final groupController = ref.read(groupControllerProvider);
      final fetchedGroupId =
          await groupController.getGroupId(businessId, selectedSubGroup);
      if (fetchedGroupId != null) {
        subgroupId = fetchedGroupId;
        print('this is subgroupId :- $subgroupId');

        // Invalidate the userGroupProvider to fetch new data for the selected subgroup
        ref.invalidate(userGroupProvider(subgroupId));
      } else {
        print('Failed to fetch Group ID');
      }
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
  }

  @override
  Widget build(BuildContext context) {
    final parameterListAsync = ref.watch(parameterListProvider);
    final dataAddedController = ref.read(dataAddedControllerProvider);
    final SubGroupDataController = ref.read(SubGroupDataControllerProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    return Scaffold(
      body: SingleChildScrollView(
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
                return Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.035,
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
                        onTap: () => _handleTapForParameters(parameterName),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
            if (selectedParameter.isNotEmpty)
              ref.watch(subGroupProvider(selectedParameter)).when(
                    data: (subGroups) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.035,
                        ).copyWith(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: subGroups.length,
                          itemBuilder: (context, index) {
                            final subGroupName = subGroups[index].groupName;
                            return SelectableSubGroupWidget(
                              text: subGroupName,
                              isSelected: subGroupName == selectedSubGroup,
                              onTap: () => _handleTapForSubGroups(subGroupName),
                            );
                          },
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                  ),
            if (selectedSubGroup.isNotEmpty)
              ref.watch(userGroupProvider(subgroupId)).when(
                    data: (userGroup) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.035,
                        ).copyWith(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userGroup.businessUsers.length,
                          itemBuilder: (context, index) {
                            final businessUser = userGroup.businessUsers[index];
                            final userid = userGroup.users[index].id;
                            final username = businessUser.name;
                            return SelectableUsername(
                              text: username,
                              isSelected: username == selectedUser,
                              onTap: () => _handleUserTap(username, userid),
                            );
                          },
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
                selectedParameter.isNotEmpty &&
                selectedSubGroup.isEmpty &&
                selectedUser.isEmpty)
              FutureBuilder(
                future: dataAddedController.fetchDataAdded(
                    businessId, selectedParameter),
                builder: (context,
                    AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                selectedUser.isEmpty)
              FutureBuilder(
                future: dataAddedController.fetchDataAdded(
                    businessId, selectedParameter),
                builder: (context,
                    AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                selectedUser.isEmpty)
              FutureBuilder(
                future: dataAddedController.fetchDataAdded(
                    businessId, selectedParameter),
                builder: (context,
                    AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                selectedSubGroup.isNotEmpty &&
                selectedUser.isEmpty)
              FutureBuilder(
                future: SubGroupDataController.fetchDataAdded(
                    businessId, groupId, selectedSubGroup),
                builder: (context,
                    AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                selectedUser.isNotEmpty)
              FutureBuilder<Map<String, List<List<dynamic>>>>(
                future: ref.read(userDataControllerProvider).fetchUserData(
                    businessId!, selectedParameter, selectedUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomChart(
                        parameter: selectedParameter,
                        actualData: data['userEntries'] ?? [],
                        predictedData: data['dailyTarget'] ?? [],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
               if (selectedStates.isNotEmpty &&
                selectedStates[1] &&
                selectedParameter.isNotEmpty &&
                selectedUser.isNotEmpty)
              FutureBuilder<Map<String, List<List<dynamic>>>>(
                future: ref.read(userDataControllerProvider).fetchUserData(
                    businessId!, selectedParameter, selectedUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              if (selectedStates.isNotEmpty &&
                selectedStates[3] &&
                selectedParameter.isNotEmpty &&
                selectedUser.isNotEmpty)
              FutureBuilder<Map<String, List<List<dynamic>>>>(
                future: ref.read(userDataControllerProvider).fetchUserData(
                    businessId!, selectedParameter, selectedUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
