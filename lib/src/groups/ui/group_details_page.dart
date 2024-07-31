// // GroupDetailsPage.dart
// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/groups/ui/Create_subgroup.dart';
// import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

// class GroupDetailsPage extends StatelessWidget {
//   final GroupDataModel group;

//   const GroupDetailsPage({super.key, required this.group});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(group.groupName),
//       ),
//       body: const Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Padding(
//           //   padding: const EdgeInsets.all(16.0),
//           //   child: Text(
//           //     group.groupName,
//           //     style: TextStyle(
//           //       fontSize: 24,
//           //       fontWeight: FontWeight.bold,
//           //     ),
//           //   ),
//           // ),
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: group.members.length,
//           //     itemBuilder: (context, index) {
//           //       final member = group.members[index];
//           //       return ListTile(
//           //         title: Text(member.name),
//           //         subtitle: Text(member.role),
//           //       );
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: lightblue,
//         onPressed: () {
//           // Implement adding subgroups functionality
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CreateSubGroupPage(group)));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// lib/src/groups/ui/GroupDetailsPage.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/groups/ui/Create_subgroup.dart';
import 'package:targafy/src/groups/ui/controller/create_group_controller.dart';
import 'package:targafy/src/groups/ui/controller/group_data_controller.dart';
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';
import 'package:targafy/src/groups/ui/widget/group_tile.dart';
import 'package:targafy/widgets/custom_back_button.dart';
import 'package:targafy/widgets/custom_button.dart';

class GroupDetailsPage extends ConsumerStatefulWidget {
  final GroupDataModel group;

  const GroupDetailsPage({super.key, required this.group});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends ConsumerState<GroupDetailsPage> {
  File? _logoImage;

  @override
  void initState() {
    super.initState();
    // Fetch subgroups when the page is initialized
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    ref
        .read(SubGroupDataControllerProvider.notifier)
        .fetchSubGroups(widget.group.id);
    // });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });

      // Upload logo and update group logo
      try {
        final selectedBusinessData = ref.watch(currentBusinessProvider);
        final selectedBusiness = selectedBusinessData?['business'] as Business?;
        final businessId = selectedBusiness?.id;
        final logoUrl =
            await ref.read(groupControllerProvider).uploadLogo(_logoImage!);
        await ref
            .read(groupControllerProvider)
            .updateGroupLogo(widget.group.id, businessId!, logoUrl);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logo updated successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update logo: $e')));
      }
    }
  }

  Future<void> _refreshSubGroups() async {
    await ref
        .read(SubGroupDataControllerProvider.notifier)
        .fetchSubGroups(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    final subGroups = ref.watch(SubGroupDataControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.headGroupName),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshSubGroups,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Center(
            //     child: GestureDetector(
            //       onTap: _pickImage,
            //       child: CircleAvatar(
            //         radius: 50,
            //         backgroundImage: NetworkImage(
            //             'https://randomuser.me/api/portraits/lego/2.jpg'),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: subGroups.isEmpty
                  ? const Center(
                      child: Text(
                        'No subgroups created',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: subGroups.length,
                      itemBuilder: (context, index) {
                        final subGroup = subGroups[index];
                        return SubGroupTile(
                          group: subGroup,
                          onDataAdded: () {
                            ref
                                .read(SubGroupDataControllerProvider.notifier)
                                .fetchSubGroups(widget.group.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightblue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateSubGroupPage(widget.group)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class SubGroupDetailsPage extends ConsumerStatefulWidget {
//   final SubGroupDataModel group;

//   const SubGroupDetailsPage({super.key, required this.group});

//   @override
//   _SubGroupDetailsPageState createState() => _SubGroupDetailsPageState();
// }

// class _SubGroupDetailsPageState extends ConsumerState<SubGroupDetailsPage> {
//   File? _logoImage;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch subgroups when the page is initialized
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     ref
//         .read(SubGroupDataControllerProvider.notifier)
//         .fetchSubGroups(widget.group.groupId);
//     // });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _logoImage = File(pickedFile.path);
//       });

//       // Upload logo and update group logo
//       try {
//         final selectedBusinessData = ref.watch(currentBusinessProvider);
//         final selectedBusiness = selectedBusinessData?['business'] as Business?;
//         final businessId = selectedBusiness?.id;
//         final logoUrl =
//             await ref.read(groupControllerProvider).uploadLogo(_logoImage!);
//         await ref
//             .read(groupControllerProvider)
//             .updateGroupLogo(widget.group.groupId, businessId!, logoUrl);

//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Logo updated successfully!')));
//       } catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Failed to update logo: $e')));
//       }
//     }
//   }

//   Future<void> _refreshSubGroups() async {
//     await ref
//         .read(SubGroupDataControllerProvider.notifier)
//         .fetchSubGroups(widget.group.groupId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final subGroups = ref.watch(SubGroupDataControllerProvider);

//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.group.groupName),
//       // ),
//       body: RefreshIndicator(
//         onRefresh: _refreshSubGroups,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.all(16.0),
//             //   child: Center(
//             //     child: GestureDetector(
//             //       onTap: _pickImage,
//             //       child: CircleAvatar(
//             //         radius: 50,
//             //         backgroundImage: NetworkImage(
//             //             'https://randomuser.me/api/portraits/lego/2.jpg'),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             CustomSubBackButton(
//               buttonText: widget.group.groupName,
//               onPressed: () async {
//                 Navigator.pop(context);
//                 _refreshSubGroups();
//               },
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: subGroups.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No subgroups created',
//                         style: TextStyle(fontSize: 18, color: Colors.red),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: subGroups.length,
//                       itemBuilder: (context, index) {
//                         final subGroup = subGroups[index];
//                         return SubGroupTile(
//                           group: subGroup,
//                           onDataAdded: () {
//                             ref
//                                 .read(SubGroupDataControllerProvider.notifier)
//                                 .fetchSubGroups(widget.group.groupId);
//                           },
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: lightblue,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CreateSubSubGroupPage(widget.group)));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

class SubGroupDetailsPage extends ConsumerStatefulWidget {
  final SubGroupDataModel group;

  const SubGroupDetailsPage({super.key, required this.group});

  @override
  _SubGroupDetailsPageState createState() => _SubGroupDetailsPageState();
}

class _SubGroupDetailsPageState extends ConsumerState<SubGroupDetailsPage> {
  File? _logoImage;

  @override
  void initState() {
    super.initState();
    _refreshSubGroups();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('this function called ');
    _refreshSubGroups();
  }

  // Future<void> _fetchSubGroups() async {
  //   await ref
  //       .read(SubGroupDataControllerProvider.notifier)
  //       .fetchSubGroups(widget.group.groupId);
  // }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });

      // Upload logo and update group logo
      try {
        final selectedBusinessData = ref.watch(currentBusinessProvider);
        final selectedBusiness = selectedBusinessData?['business'] as Business?;
        final businessId = selectedBusiness?.id;
        final logoUrl =
            await ref.read(groupControllerProvider).uploadLogo(_logoImage!);
        await ref
            .read(groupControllerProvider)
            .updateGroupLogo(widget.group.groupId, businessId!, logoUrl);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logo updated successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update logo: $e')));
      }
    }
  }

  Future<void> _refreshSubGroups() async {
    if (mounted) {
      await ref
          .read(SubGroupDataControllerProvider.notifier)
          .fetchSubGroups(widget.group.groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final subGroups = ref.watch(SubGroupDataControllerProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.group.groupName),
      // ),
      body: RefreshIndicator(
        onRefresh: _refreshSubGroups,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSubBackButton(
              buttonText: widget.group.groupName,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: subGroups.isEmpty
                  ? const Center(
                      child: Text(
                        'No subgroups created',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: subGroups.length,
                      itemBuilder: (context, index) {
                        final subGroup = subGroups[index];
                        return SubGroupTile(
                          group: subGroup,
                          onDataAdded: () {
                            _refreshSubGroups();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightblue,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateSubSubGroupPage(widget.group)));
          _refreshSubGroups();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
