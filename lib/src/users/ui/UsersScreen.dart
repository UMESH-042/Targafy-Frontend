import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:share/share.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
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

  bool isAscending = true;
  String sortType = "Name";

  void sortFunction(String _sortType) {
    setState(() {
      if (_sortType == "Name") {
        users.sort((a, b) =>
            a['name']!.compareTo(b['name']!) * (isAscending ? 1 : -1));
      } else if (_sortType == "Role") {
        users.sort((a, b) =>
            a['role']!.compareTo(b['role']!) * (isAscending ? 1 : -1));
      }
      sortType = _sortType;
      isAscending = !isAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final selectedUserType = selectedBusinessData?['userType'] as String?;
    // print(selectedUserType);
    final selectedbusinessCode =
        selectedBusinessData?['businessCode'] as String?;
    final businessName = selectedBusiness?.name;

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
                    String shareText = 'Dear User,\n\n'
                        'We invite you to download our app via the following link: '
                        'Please download the app from: https://play.google.com/store/apps/details?id=com.issuecop.app\n\n'
                        'And then join our business using code: $selectedbusinessCode\n\n'
                        'Best regards,\n'
                        '$businessName Team';
                    Share.share(shareText,
                        subject: 'Join our business on BizIssue');
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () => sortFunction("Name"),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: lightblue,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //       side: BorderSide(color: primaryColor, width: 2),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Sort by Name',
                  //         style: TextStyle(color: primaryColor),
                  //       ),
                  //       Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward, color: primaryColor),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(width: 10),
                  // ElevatedButton(
                  //   onPressed: () => sortFunction("Role"),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: lightblue,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //       side: BorderSide(color: primaryColor, width: 2),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Sort by Role',
                  //         style: TextStyle(color: primaryColor),
                  //       ),
                  //       Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward, color: primaryColor),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
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
