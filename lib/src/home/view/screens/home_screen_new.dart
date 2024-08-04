// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/home/view/screens/home_screen.dart';

// class AllTwoImpPage extends ConsumerStatefulWidget {
//   const AllTwoImpPage({super.key});

//   @override
//   ConsumerState<AllTwoImpPage> createState() => _AllTwoImpPageState();
// }

// class _AllTwoImpPageState extends ConsumerState<AllTwoImpPage>
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
//         titleSpacing: 0,
//         title: Center(
//           child: TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             tabs: const [
//               Tab(text: 'Employees'),
//               Tab(text: 'Groups'),
//             ],
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           HomeScreenEmployees(),
//           HomeScreenGroups(),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/home/view/screens/home_screen_groups.dart';
// import 'package:targafy/src/home/view/screens/home_screen_employees.dart';

// class AllTwoImpPage extends ConsumerStatefulWidget {
//   const AllTwoImpPage({super.key});

//   @override
//   ConsumerState<AllTwoImpPage> createState() => _AllTwoImpPageState();
// }

// class _AllTwoImpPageState extends ConsumerState<AllTwoImpPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
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
//         title: Center(
//           child: TabBar(
//             controller: _tabController,
//             isScrollable: false,
//             tabs: const [
//               Tab(text: 'Employees'),
//               Tab(text: 'Groups'),
//             ],
//           ),
//         ),
//         titleSpacing: 0, // Remove extra spacing
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           HomeScreenEmployees(),
//           HomeScreenGroups(),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';

// class AllTwoImpPage extends ConsumerStatefulWidget {
//   const AllTwoImpPage({super.key});

//   @override
//   ConsumerState<AllTwoImpPage> createState() => _AllTwoImpPageState();
// }

// class _AllTwoImpPageState extends ConsumerState<AllTwoImpPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isLoading = true;
//   List<Department> _departments = [];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//         print('fetch department called');
//         fetchDepartments();
//     });
//   }

//   void fetchDepartments() async {
//     var selectedBusinessData = ref.read(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;

//     if (selectedBusiness == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }

//     String businessId = selectedBusiness.id;
//     ref.read(departmentProvider(businessId)).when(
//           data: (departments) {
//             if (departments.isEmpty) {
//               departments = [
//                 Department(id: 'dummy', name: 'Dummy Department'),
//               ];
//             }
//             setState(() {
//               _departments = departments;
//               _isLoading = false;
//               _tabController =
//                   TabController(length: _departments.length, vsync: this);
//             });
//           },
//           loading: () {},
//           error: (err, stack) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//         );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var selectedBusinessData = ref.read(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;

//     if (selectedBusiness == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('No Business Selected'),
//         ),
//         body: const Center(
//           child: Text('Please select a business.'),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Center(
//                 child: TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   tabs: _departments.map((department) {
//                     return Tab(text: department.name);
//                   }).toList(),
//                 ),
//               ),
//         titleSpacing: 0,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : TabBarView(
//               controller: _tabController,
//               children: _departments.map((department) {
//                 return DepartmentPage(department: department);
//               }).toList(),
//             ),
//     );
//   }
// }

// class DepartmentPage extends StatelessWidget {
//   final Department department;

//   const DepartmentPage({Key? key, required this.department}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Information for ${department.name}'),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';

class AllTwoImpPage extends ConsumerStatefulWidget {
  const AllTwoImpPage({super.key});

  @override
  ConsumerState<AllTwoImpPage> createState() => _AllTwoImpPageState();
}

class _AllTwoImpPageState extends ConsumerState<AllTwoImpPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<Department> _departments = [];

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _updateTabController() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    _tabController = TabController(
      length: _departments.isEmpty ? 1 : _departments.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;

    return Scaffold(
      body: selectedBusiness == null
          ? const Center(child: Text('Please select a business.'))
          : _buildDepartmentContent(selectedBusiness),
    );
  }

  Widget _buildDepartmentContent(Business selectedBusiness) {
    return ref.watch(departmentProvider(selectedBusiness.id)).when(
          data: (departments) {
            if (departments.isEmpty) {
              departments = [
                Department(id: 'dummy', name: 'Dummy Department'),
              ];
            }
            if (_departments != departments) {
              _departments = departments;
              _updateTabController();
            }
            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _departments.map((department) {
                    return Tab(text: department.name);
                  }).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _departments.map((department) {
                      return DepartmentPage(department: department);
                    }).toList(),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) {
            return Column(
              children: [
                Expanded(
                  child: DepartmentPage(
                    department:
                        Department(id: 'dummy', name: 'Dummy Department'),
                  ),
                ),
              ],
            );
          },
        );
  }
}

class DepartmentPage extends StatelessWidget {
  final Department department;

  const DepartmentPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Information for ${department.name}'),
    );
  }
}
