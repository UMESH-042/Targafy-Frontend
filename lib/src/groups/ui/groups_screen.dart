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
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/src/groups/ui/Create_group.dart';
import 'package:targafy/src/groups/ui/widget/group_tile.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart'; // Import the department provider

class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Consumer(
          builder: (context, ref, child) {
            final selectedBusinessData = ref.watch(currentBusinessProvider);
            final businessId = selectedBusinessData?['business']?.id;

            if (businessId == null) {
              return const Center(
                child: Text(
                  'No business created',
                  style: TextStyle(fontSize: 18, color: Colors.red),
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
                child: Text(
                  'Error: $error',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightblue,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DepartmentCreatePage()),
          );

          final selectedBusinessData = ref.read(currentBusinessProvider);
          final businessId = selectedBusinessData?['business']?.id;

          if (result == true && businessId != null) {
            ref.invalidate(departmentProvider(businessId));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
