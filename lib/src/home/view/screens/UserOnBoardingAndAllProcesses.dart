import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
import 'package:targafy/src/users/ui/UsersScreen.dart';

class AllFourImpPage extends ConsumerStatefulWidget {
  const AllFourImpPage({super.key});

  @override
  ConsumerState<AllFourImpPage> createState() => _AllFourImpPageState();
}

class _AllFourImpPageState extends ConsumerState<AllFourImpPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Removes extra spacing
        title: TabBar(
          controller: _tabController,
          isScrollable: true, // This makes the TabBar scrollable
          tabs: const [
            Tab(text: 'User'),
            Tab(text: 'Parameter'),
            Tab(text: 'Charts'),
            Tab(text: 'Target'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UsersScreen(),
          AddParameterMainScreen(),
          AddChartsMainPage(
            businessId: businessId,
          ),
          AddTargetMainScreen(),
        ],
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('User Page'),
    );
  }
}

class ParameterPage extends StatelessWidget {
  const ParameterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Parameter Page'),
    );
  }
}

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Charts Page'),
    );
  }
}

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Target Page'),
    );
  }
}
