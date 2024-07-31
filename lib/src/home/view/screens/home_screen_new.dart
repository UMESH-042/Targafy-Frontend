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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';

class AllTwoImpPage extends ConsumerStatefulWidget {
  const AllTwoImpPage({super.key});

  @override
  ConsumerState<AllTwoImpPage> createState() => _AllTwoImpPageState();
}

class _AllTwoImpPageState extends ConsumerState<AllTwoImpPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Center(
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            tabs: const [
              Tab(text: 'Employees'),
              Tab(text: 'Groups'),
            ],
          ),
        ),
        titleSpacing: 0, // Remove extra spacing
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeScreenEmployees(),
          HomeScreenGroups(),
        ],
      ),
    );
  }
}
