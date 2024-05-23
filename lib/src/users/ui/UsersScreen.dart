import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<Map<String, String>> users = [
    {
      'name': 'John Doe',
      'userType': 'Insider',
      'role': 'Admin',
      'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Jane Doe',
      'userType': 'Insider',
      'role': 'User',
      'profilePhotoUrl': 'https://randomuser.me/api/portraits/women/1.jpg',
    },
    {
      'name': 'Michael Smith',
      'userType': 'Insider',
      'role': 'Admin',
      'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    {
      'name': 'Emily Johnson',
      'userType': 'Insider',
      'role': 'User',
      'profilePhotoUrl': 'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'name': 'David Wilson',
      'userType': 'Insider',
      'role': 'Admin',
      'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
    // Add more dummy users here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Invite User button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Invite Users',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Accept Users button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Accept Users',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getScreenheight(context) * 0.03,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: getScreenheight(context) * 0.03,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(users[index]['profilePhotoUrl']!),
                        ),
                        SizedBox(width: getScreenheight(context) * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index]['name']!,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'UserType: ${users[index]['userType']}',
                                style: TextStyle(color: primaryColor),
                              ),
                              Text(
                                'Role: ${users[index]['role']}',
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}






