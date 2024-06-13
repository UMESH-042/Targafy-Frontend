// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:share/share.dart';
// import 'package:targafy/src/users/ui/RequestUsersScreen.dart';

// class UsersScreen extends ConsumerStatefulWidget {
//   const UsersScreen({super.key});

//   @override
//   _UsersScreenState createState() => _UsersScreenState();
// }

// class _UsersScreenState extends ConsumerState<UsersScreen> {
//   final List<Map<String, String>> users = [
//     {
//       'name': 'John Doe',
//       'userType': 'Insider',
//       'role': 'Admin',
//       'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
//     },
//     {
//       'name': 'Jane Doe',
//       'userType': 'Insider',
//       'role': 'User',
//       'profilePhotoUrl': 'https://randomuser.me/api/portraits/women/1.jpg',
//     },
//     {
//       'name': 'Michael Smith',
//       'userType': 'Insider',
//       'role': 'Admin',
//       'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
//     },
//     {
//       'name': 'Emily Johnson',
//       'userType': 'Insider',
//       'role': 'User',
//       'profilePhotoUrl': 'https://randomuser.me/api/portraits/women/2.jpg',
//     },
//     {
//       'name': 'David Wilson',
//       'userType': 'Insider',
//       'role': 'Admin',
//       'profilePhotoUrl': 'https://randomuser.me/api/portraits/men/3.jpg',
//     },
//     // Add more dummy users here
//   ];

//   bool isAscending = true;
//   String sortType = "Name";

//   void sortFunction(String _sortType) {
//     setState(() {
//       if (_sortType == "Name") {
//         users.sort((a, b) =>
//             a['name']!.compareTo(b['name']!) * (isAscending ? 1 : -1));
//       } else if (_sortType == "Role") {
//         users.sort((a, b) =>
//             a['role']!.compareTo(b['role']!) * (isAscending ? 1 : -1));
//       }
//       sortType = _sortType;
//       isAscending = !isAscending;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;
//     final selectedUserType = selectedBusinessData?['userType'] as String?;
//     // print(selectedUserType);
//     final selectedbusinessCode =
//         selectedBusinessData?['businessCode'] as String?;
//     final businessName = selectedBusiness?.name;
//     final businessId = selectedBusiness?.id;
//     print(businessName);
//     print(businessId);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     String shareText = 'Dear User,\n\n'
//                         'We invite you to download our app via the following link: '
//                         'Please download the app from: https://play.google.com/store/apps/details?id=com.issuecop.app\n\n'
//                         'And then join our business using code: $selectedbusinessCode\n\n'
//                         'Best regards,\n'
//                         '$businessName Team';
//                     Share.share(shareText,
//                         subject: 'Join our business on BizIssue');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: lightblue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       side: BorderSide(color: primaryColor, width: 2),
//                     ),
//                   ),
//                   child: Text(
//                     'Invite Users',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle Accept Users button press
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BusinessRequestsPage(
//                                   businessId: businessId,
//                                 )));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: lightblue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       side: BorderSide(color: primaryColor, width: 2),
//                     ),
//                   ),
//                   child: Text(
//                     'Accept Users',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: getScreenheight(context) * 0.03,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ElevatedButton(
//                   //   onPressed: () => sortFunction("Name"),
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: lightblue,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(15),
//                   //       side: BorderSide(color: primaryColor, width: 2),
//                   //     ),
//                   //   ),
//                   //   child: Row(
//                   //     children: [
//                   //       Text(
//                   //         'Sort by Name',
//                   //         style: TextStyle(color: primaryColor),
//                   //       ),
//                   //       Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward, color: primaryColor),
//                   //     ],
//                   //   ),
//                   // ),
//                   // SizedBox(width: 10),
//                   // ElevatedButton(
//                   //   onPressed: () => sortFunction("Role"),
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: lightblue,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(15),
//                   //       side: BorderSide(color: primaryColor, width: 2),
//                   //     ),
//                   //   ),
//                   //   child: Row(
//                   //     children: [
//                   //       Text(
//                   //         'Sort by Role',
//                   //         style: TextStyle(color: primaryColor),
//                   //       ),
//                   //       Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward, color: primaryColor),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: getScreenheight(context) * 0.03,
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: users.length,
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: getScreenheight(context) * 0.03,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: primaryColor, width: 2),
//                     ),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage:
//                               NetworkImage(users[index]['profilePhotoUrl']!),
//                         ),
//                         SizedBox(width: getScreenheight(context) * 0.02),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 users[index]['name']!,
//                                 style: TextStyle(
//                                   color: primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'UserType: ${users[index]['userType']}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                               Text(
//                                 'Role: ${users[index]['role']}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:share/share.dart';
// import 'package:targafy/src/users/ui/RequestUsersScreen.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';

// class UsersScreen extends ConsumerStatefulWidget {
//   const UsersScreen({super.key});

//   @override
//   _UsersScreenState createState() => _UsersScreenState();
// }

// class _UsersScreenState extends ConsumerState<UsersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;
//     final selectedUserType = selectedBusinessData?['userType'] as String?;
//     final selectedbusinessCode =
//         selectedBusinessData?['businessCode'] as String?;
//     final businessName = selectedBusiness?.name;
//     final businessId = selectedBusiness?.id;

//     final usersState = ref.watch(businessUsersProvider);
//     print(businessId);

//     // Placeholder image URL
//     const placeholderImageUrl =
//         'https://randomuser.me/api/portraits/lego/2.jpg';

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     String shareText = 'Dear User,\n\n'
//                         'We invite you to download our app via the following link: '
//                         'Please download the app from: https://play.google.com/store/apps/details?id=com.issuecop.app\n\n'
//                         'And then join our business using code: $selectedbusinessCode\n\n'
//                         'Best regards,\n'
//                         '$businessName Team';
//                     Share.share(shareText,
//                         subject: 'Join our business on BizIssue');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: lightblue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       side: BorderSide(color: primaryColor, width: 2),
//                     ),
//                   ),
//                   child: Text(
//                     'Invite Users',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle Accept Users button press
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BusinessRequestsPage(
//                                   businessId: businessId,
//                                 )));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: lightblue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       side: BorderSide(color: primaryColor, width: 2),
//                     ),
//                   ),
//                   child: Text(
//                     'Accept Users',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: getScreenheight(context) * 0.03,
//             ),
//             usersState.when(
//               data: (users) => Expanded(
//                 child: ListView.separated(
//                   itemCount: users.length,
//                   separatorBuilder: (context, index) => SizedBox(
//                     height: getScreenheight(context) * 0.03,
//                   ),
//                   itemBuilder: (context, index) {
//                     final user = users[index];
//                     return Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: primaryColor, width: 2),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               placeholderImageUrl,
//                             ),
//                           ),
//                           SizedBox(width: getScreenheight(context) * 0.02),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   user.name,
//                                   style: TextStyle(
//                                     color: primaryColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   'UserType: ${user.userType}',
//                                   style: TextStyle(color: primaryColor),
//                                 ),
//                                 Text(
//                                   'Role: ${user.role}',
//                                   style: TextStyle(color: primaryColor),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) =>
//                   Center(child: Text('Error: $error')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:share/share.dart';
import 'package:targafy/src/groups/ui/groups_screen.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/users/UserBusinessProfile.dart';
import 'package:targafy/src/users/ui/RequestUsersScreen.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/src/users/ui/controller/demote_user.dart';
import 'package:targafy/src/users/ui/controller/promote_to_MiniAdmin.dart';
import 'package:targafy/src/users/ui/controller/promote_to_admin.dart';
import 'package:targafy/src/users/ui/widget/user_hierarchy_view.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final selectedbusinessCode =
        selectedBusinessData?['businessCode'] as String?;
    final businessName = selectedBusiness?.name;
    final businessId = selectedBusiness?.id;
    print(businessId);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final usersStream =
        ref.watch(businessUsersStreamProvider(businessId ?? ''));

    const placeholderImageUrl =
        'https://randomuser.me/api/portraits/lego/2.jpg';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserHierarchy(businessId: businessId!)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/hierarchy.svg",
                        semanticsLabel: 'Acme Logo',
                        height: 25,
                        width: width * 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BusinessRequestsPage(businessId: businessId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GroupScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      backgroundColor: lightblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                    child: Text(
                      'Group',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getScreenheight(context) * 0.03,
            ),
            usersStream.when(
              data: (users) => Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: getScreenheight(context) * 0.016,
                  ),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserBusinessProfilePage(
                              userId: user.userId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              // backgroundImage: NetworkImage(
                              //   user.imageUrl ?? placeholderImageUrl,
                              // ),
                              backgroundImage:
                                  NetworkImage(placeholderImageUrl),
                            ),
                            SizedBox(width: getScreenheight(context) * 0.02),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   'UserType: ${user.userType}',
                                  //   style: TextStyle(color: primaryColor),
                                  // ),
                                  // Display the user's role
                                  Text(
                                    'Role: ${user.role}',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Consumer(
                                builder: (context, ref, _) {
                                  final userRoleAsyncValue =
                                      ref.watch(userRoleProvider);
                                  // print('userId :- ${user.userId}');
                                  return userRoleAsyncValue.when(
                                    data: (role) {
                                      if (role == 'User' ||
                                          role == 'MiniAdmin') {
                                        return const SizedBox.shrink();
                                      } else {
                                        return PopupMenuButton<int>(
                                          icon: const Icon(Icons.more_vert),
                                          color: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          position: PopupMenuPosition.under,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)
                                                    .copyWith(
                                                        topRight: const Radius
                                                            .circular(0)),
                                          ),
                                          onSelected: (value) {
                                            switch (value) {
                                              case 1:
                                                // Call the promote user to admin function
                                                ref
                                                    .read(
                                                        promoteUserToAdminProvider)
                                                    .promote(
                                                      businessId!,
                                                      user.userId,
                                                    );

                                                print(
                                                    'user Id:- ${user.userId}');
                                                print(
                                                    'business Id :-$businessId');
                                                break;
                                              case 2:
                                                // Call the promote user to MiniAdmin function
                                                ref
                                                    .read(
                                                        promoteUserToMiniAdminProvider)
                                                    .promote(
                                                      businessId!,
                                                      user.userId,
                                                    );
                                                break;
                                              case 3:
                                                // Call the promote user to MiniAdmin function
                                                ref
                                                    .read(demoteUserProvider)
                                                    .demoteUser(
                                                      businessId!,
                                                      user.userId,
                                                    );
                                                break;

                                              // Add cases for other options here
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<int>>[
                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Text(
                                                'Promote to Admin',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 2,
                                              child: Text(
                                                'Promote to MiniAdmin',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 3,
                                              child: Text(
                                                'Demote to User',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 4,
                                              child: Text(
                                                'Remove User',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 5,
                                              child: Text(
                                                'Change Manager',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                    loading: () => const SizedBox.shrink(),
                                    error: (error, stack) {
                                      return const SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}
