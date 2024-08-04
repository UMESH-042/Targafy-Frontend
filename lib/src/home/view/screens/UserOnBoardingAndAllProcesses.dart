// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/groups/ui/Create_group.dart';
// import 'package:targafy/src/groups/ui/groups_screen.dart';
// import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
// import 'package:targafy/src/users/ui/UsersScreen.dart';

// class AllFourImpPage extends ConsumerStatefulWidget {
//   const AllFourImpPage({super.key});

//   @override
//   ConsumerState<AllFourImpPage> createState() => _AllFourImpPageState();
// }

// class _AllFourImpPageState extends ConsumerState<AllFourImpPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0, // Removes extra spacing
//         title: TabBar(
//           controller: _tabController,
//           isScrollable: true, // This makes the TabBar scrollable
//           tabs: const [
//             Tab(text: 'User'),
//             Tab(text: 'Parameter'),
//             Tab(text: 'Charts'),
//             Tab(text: 'Target'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           UsersScreen(),
//           AddParameterMainScreen(),
//           AddChartsMainPage(
//             businessId: businessId,
//           ),
//           AddTargetMainScreen(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => DepartmentCreatePage()));
//         },
//         backgroundColor: lightblue,
//         child: const Icon(
//           Icons.add,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

// class UserPage extends StatelessWidget {
//   const UserPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('User Page'),
//     );
//   }
// }

// class ParameterPage extends StatelessWidget {
//   const ParameterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Parameter Page'),
//     );
//   }
// }

// class ChartsPage extends StatelessWidget {
//   const ChartsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Charts Page'),
//     );
//   }
// }

// class TargetPage extends StatelessWidget {
//   const TargetPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Target Page'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/groups/ui/Create_group.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
import 'package:targafy/src/users/ui/UsersScreen.dart';

class AllFourImpPage extends ConsumerStatefulWidget {
  const AllFourImpPage({super.key});

  @override
  ConsumerState<AllFourImpPage> createState() => _AllFourImpPageState();
}

class _AllFourImpPageState extends ConsumerState<AllFourImpPage>
    with TickerProviderStateMixin {
  late TabController _subTabController;
  int _selectedDepartmentIndex = 0; // Track selected department index
  String? _selectedDepartmentId; // Store selected department ID

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _subTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    if (businessId == null) {
      return Scaffold(
        body: Center(
          child: Text('Please select a business.'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DepartmentCreatePage()));
          },
          backgroundColor: lightblue,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      );
    }

    final departmentAsyncValue = ref.watch(departmentProvider(businessId));

    return Scaffold(
      body: Column(
        children: [
          departmentAsyncValue.when(
            data: (departments) {
              if (departments.isNotEmpty) {
                // Set the selected department ID if it's not already set
                if (_selectedDepartmentId == null) {
                  _selectedDepartmentId =
                      departments[_selectedDepartmentIndex].id;
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 34,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            final department = departments[index];
                            return SelectableParameterWidget(
                              text: department.name,
                              isSelected: _selectedDepartmentIndex == index,
                              onTap: () {
                                setState(() {
                                  _selectedDepartmentIndex = index;
                                  _selectedDepartmentId = department
                                      .id; // Update the selected department ID
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No Departments'));
              }
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('No Departments')),
          ),
          Align(
            alignment: Alignment.center,
            child: TabBar(
              controller: _subTabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Users'),
                Tab(text: 'Parameters'),
                Tab(text: 'Charts'),
                Tab(text: 'Targets'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _subTabController,
              children: [
                // if (_selectedDepartmentId != null)
                UsersScreen(departmentId: _selectedDepartmentId!),
                if (_selectedDepartmentId != null)
                  AddParameterMainScreen(departmentId: _selectedDepartmentId!),
                if (_selectedDepartmentId != null)
                  AddChartsMainPage(
                    departmentId: _selectedDepartmentId!,
                    businessId: businessId,
                  ),
                // Assuming AddTargetMainScreen also needs departmentId, if not, you can remove it
                if (_selectedDepartmentId != null)
                  AddTargetMainScreen(departmentId: _selectedDepartmentId!),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => DepartmentCreatePage()));
          if (result == true) {
            ref.invalidate(departmentProvider(businessId));
          }
        },
        backgroundColor: lightblue,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
