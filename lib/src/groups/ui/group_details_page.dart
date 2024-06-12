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
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

class GroupDetailsPage extends ConsumerStatefulWidget {
  final GroupDataModel group;

  const GroupDetailsPage({super.key, required this.group});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends ConsumerState<GroupDetailsPage> {
  File? _logoImage;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.groupName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _logoImage != null
                      ? FileImage(_logoImage!)
                      : NetworkImage(widget.group.logo) as ImageProvider,
                  child: _logoImage == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
          // The rest of your UI components
        ],
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
