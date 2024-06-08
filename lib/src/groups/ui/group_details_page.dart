// GroupDetailsPage.dart
import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/groups/ui/Create_subgroup.dart';
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

class GroupDetailsPage extends StatelessWidget {
  final GroupDataModel group;

  const GroupDetailsPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.groupName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     group.groupName,
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: group.members.length,
          //     itemBuilder: (context, index) {
          //       final member = group.members[index];
          //       return ListTile(
          //         title: Text(member.name),
          //         subtitle: Text(member.role),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightblue,
        onPressed: () {
          // Implement adding subgroups functionality
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateSubGroupPage(group)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
