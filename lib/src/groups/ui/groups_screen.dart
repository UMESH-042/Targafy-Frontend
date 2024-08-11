// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/groups/ui/Create_group.dart';
// import 'package:targafy/src/groups/ui/controller/group_data_controller.dart';
// import 'package:targafy/src/groups/ui/widget/group_tile.dart';

// class GroupScreen extends ConsumerStatefulWidget {
//   const GroupScreen({super.key});

//   @override
//   _GroupScreenState createState() => _GroupScreenState();
// }

// class _GroupScreenState extends ConsumerState<GroupScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Groups'),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: Consumer(
//           builder: (context, ref, child) {
//             final selectedBusinessData = ref.watch(currentBusinessProvider);
//             final businessId = selectedBusinessData?['business']?.id;
//             ref
//                 .read(GroupDataControllerProvider.notifier)
//                 .fetchGroups(businessId);

//             final groups = ref.watch(GroupDataControllerProvider);

//             return groups.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: groups.length,
//                     itemBuilder: (context, index) {
//                       final group = groups[index];
//                       return GroupTile(
//                         group: group,
//                         onDataAdded: () {
//                           ref
//                               .read(GroupDataControllerProvider.notifier)
//                               .fetchGroups(businessId);
//                         },
//                       );
//                     },
//                   );
//           },
//         ),
//       ),
//       // In GroupScreen
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: lightblue,
//         onPressed: () async {
//           final created = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const CreateGroupPage()),
//           );

//           if (created == true) {
//             final selectedBusinessData = ref.watch(currentBusinessProvider);
//             final businessId = selectedBusinessData?['business']?.id;
//             ref
//                 .read(GroupDataControllerProvider.notifier)
//                 .fetchGroups(businessId);
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/groups/ui/Create_group.dart';
import 'package:targafy/src/groups/ui/widget/group_tile.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart'; // Import the department provider

class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userRoleAsyncValue = ref.watch(userRoleProvider);

        return userRoleAsyncValue.when(
          data: (role) {
            if (role == 'User' || role == 'MiniAdmin') {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/animations/empty_list.json',
                          height: 200, width: 200),
                      const Text(
                        'You don\'t have access to this page',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final selectedBusinessData = ref.watch(currentBusinessProvider);
            final businessId = selectedBusinessData?['business']?.id;

            if (businessId == null) {
              return const Scaffold(
                body: Center(
                  child: Text('No business selected'),
                ),
              );
            }

            // Watch the departmentProvider with the businessId
            final departmentAsyncValue =
                ref.watch(departmentProvider(businessId));

            return departmentAsyncValue.when(
              data: (departments) {
                if (departments.isEmpty) {
                  return const Center(
                    child: Text(
                      'No departments created',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    final department = departments[index];
                    return DepartmentTile(department: department);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
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
            );
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Scaffold(
            body: Center(
              child: Text('Failed to load user role: $error'),
            ),
          ),
        );
      },
    );
  }
}
