import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/groups/ui/Create_group.dart';
import 'package:targafy/src/groups/ui/groups_screen.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
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

  String? _selectedDepartmentId;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 5, vsync: this);
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

    return Scaffold(
      body: Column(
        children: [
          Align(
            child: TabBar(
              controller: _subTabController,
              tabs: const [
                Tab(text: 'Department'),
                Tab(text: 'Parameters'),
                Tab(text: 'Users'),
                Tab(text: 'Charts'),
                Tab(text: 'Targets'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _subTabController,
              children: [
                GroupScreen(),
                AddParameterMainScreen(departmentId: ''),
                UsersScreen(departmentId: ''),
                AddChartsMainPage(
                  departmentId: '',
                  businessId: businessId,
                ),
                AddTargetMainScreen(departmentId: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
