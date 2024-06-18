// import 'dart:async';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/business_home_page/screens/business_profile.dart';
// import 'package:targafy/business_home_page/screens/create_business.dart';
// import 'package:targafy/business_home_page/screens/join_business.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/feedback/feedback.dart';
// import 'package:targafy/src/activity/ui/activity_screen.dart';
// import 'package:targafy/src/groups/ui/groups_screen.dart';
// import 'package:targafy/src/home/view/screens/AddScreen.dart';
// import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
// import 'package:targafy/src/home/view/screens/home_screen.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
// import 'package:targafy/src/users/ui/UsersScreen.dart';

// class BottomNavigationAndAppBar extends ConsumerStatefulWidget {
//   const BottomNavigationAndAppBar({super.key});

//   @override
//   _BottomNavigationAndAppBarState createState() =>
//       _BottomNavigationAndAppBarState();
// }

// class _BottomNavigationAndAppBarState
//     extends ConsumerState<BottomNavigationAndAppBar> {
//   int _selectedIndex = 0;

//   static final List<Widget> _widgetOptions = <Widget>[
//     const HomeScreen(),
//     const UsersScreen(),
//     const Addscreen(),
//     const ActivityScreen(),
//     const FeedbackScreen()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncValue = ref.watch(businessAndUserProvider);
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;
//     final selectedUserType = selectedBusinessData?['userType'] as String?;
//     final selectedbusinessCode =
//         selectedBusinessData?['businessCode'] as String?;
//     final SelectedRole = selectedBusinessData?['role'] as String?;
//     print(selectedbusinessCode);

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(getScreenheight(context) * 0.08),
//         child: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.only(
//             top: 5,
//             bottom: 5,
//             left: 5,
//           ),
//           // margin: EdgeInsets.only(top: getScreenheight(context) * 0.01),
//           child: AppBar(
//             // title: CustomText(
//             //   text: selectedBusiness != null && selectedUserType != null
//             //       ? '${selectedBusiness.name}\n($selectedUserType)'
//             //       : 'Hi User',
//             //   fontSize: getScreenWidth(context) * 0.055,
//             // ),
//             title: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'Targafy',
//                   style: TextStyle(
//                     fontSize: getScreenWidth(context) *
//                         0.066, // Adjust size as needed
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   selectedBusiness != null && selectedUserType != null
//                       ? '${selectedBusiness.name}'
//                       : 'Hi User',
//                   style: TextStyle(
//                     fontSize: getScreenWidth(context) *
//                         0.038, // Adjust size as needed
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             centerTitle: false,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: GestureDetector(
//                   child: Image.asset('assets/img/search.png'),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: GestureDetector(
//                   child: Image.asset('assets/img/filter.png'),
//                 ),
//               ),
//               // Modify the PopupMenuButton in the appBar
//               Consumer(
//                 builder: (context, ref, _) {
//                   final userRoleAsyncValue = ref.watch(userRoleProvider);

//                   return userRoleAsyncValue.when(
//                     data: (role) {
//                       // Show the three-dot option
//                       return PopupMenuButton<int>(
//                         icon: const Icon(Icons.more_vert),
//                         color: Colors.white,
//                         surfaceTintColor: Colors.white,
//                         position: PopupMenuPosition.under,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)
//                               .copyWith(topRight: const Radius.circular(0)),
//                         ),
//                         onSelected: (value) {
//                           if (value == 1) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     const AddParameterTargetScreen(),
//                               ),
//                             );
//                           } else if (value == 2) {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => const AddChartsScreen(), // Assuming you have a screen for Add Charts
//                             //   ),
//                             // );
//                           } else if (value == 3) {
//                           } else if (value == 4) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     const BusinessProfile(), // Assuming you have a screen for Business Profile
//                               ),
//                             );
//                           }
//                         },
//                         itemBuilder: (BuildContext context) =>
//                             <PopupMenuEntry<int>>[
//                           if (role != 'User' && role != 'MiniAdmin')
//                             PopupMenuItem<int>(
//                               value: 1,
//                               child: CustomText(
//                                 text: 'Add Parameters/Target',
//                                 fontSize: getScreenWidth(context) * 0.04,
//                                 fontWeight: FontWeight.w600,
//                                 color: primaryColor,
//                               ),
//                             ),
//                           if (role != 'User' && role != 'MiniAdmin')
//                             PopupMenuItem<int>(
//                               value: 2,
//                               child: CustomText(
//                                 text: 'Add Charts',
//                                 fontSize: getScreenWidth(context) * 0.04,
//                                 fontWeight: FontWeight.w600,
//                                 color: primaryColor,
//                               ),
//                             ),
//                           PopupMenuItem<int>(
//                             value: 3,
//                             child: CustomText(
//                               text: 'Refresh',
//                               fontSize: getScreenWidth(context) * 0.04,
//                               fontWeight: FontWeight.w600,
//                               color: primaryColor,
//                             ),
//                           ),
//                           PopupMenuItem<int>(
//                             value: 4,
//                             child: CustomText(
//                               text: 'Business Profile',
//                               fontSize: getScreenWidth(context) * 0.04,
//                               fontWeight: FontWeight.w600,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                     loading: () => const SizedBox.shrink(),
//                     error: (error, stack) {
//                       // Handle error case
//                       return const SizedBox.shrink();
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: SingleChildScrollView(
//           child: Consumer(
//             builder: (context, ref, _) {
//               // Retrieve the stream containing the data
//               final asyncValue = ref.watch(businessAndUserProvider);

//               return asyncValue.when(
//                 data: (data) {
//                   final businesses = data['businesses'] as List<Business>;
//                   final user = data['user'] as User;
//                   return Column(
//                     children: [
//                       DrawerHeader(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: double.infinity,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: primaryColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 padding: const EdgeInsets.all(1.5),
//                                 child: Center(
//                                   child: CircleAvatar(
//                                     radius: getScreenWidth(context) * 0.09,
//                                     backgroundImage: businesses.isNotEmpty
//                                         ? NetworkImage(businesses.first.logo)
//                                         : null,
//                                     child: businesses.isNotEmpty
//                                         ? null
//                                         : Image.network(
//                                             'https://via.placeholder.com/150',
//                                             fit: BoxFit.cover,
//                                           ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: getScreenWidth(context) * 0.02),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Center(
//                                     child: CustomText(
//                                       text: user.name,
//                                       fontSize: getScreenWidth(context) * 0.045,
//                                       color: primaryColor,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   Center(
//                                     child: CustomText(
//                                       text: 'Admin',
//                                       fontSize: getScreenWidth(context) * 0.04,
//                                       color: primaryColor,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ExpansionTile(
//                         leading: const Icon(Icons.business),
//                         title: const Text('Businesses'),
//                         children: businesses.map((business) {
//                           // Find the userType for this business
//                           final businessUser = user.businesses.firstWhere(
//                             (b) => b.businessId == business.id,
//                             orElse: () => BusinessUser(
//                                 name: '', userType: '', businessId: ''),
//                           );

//                           return ListTile(
//                             leading: Image.network(
//                               business.logo,
//                               width: 30,
//                               height: 30,
//                               errorBuilder: (BuildContext context,
//                                   Object exception, StackTrace? stackTrace) {
//                                 return Image.network(
//                                   'https://via.placeholder.com/30',
//                                   width: 30,
//                                   height: 30,
//                                 );
//                               },
//                             ),
//                             title: Text(business.name),
//                             onTap: () {
//                               // Select the business and its userType
//                               selectBusiness(business, businessUser.userType,
//                                   business.businessCode, ref);
//                               Navigator.pop(context); // Close the drawer
//                             },
//                           );
//                         }).toList(),
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.add),
//                         title: const Text('Create Business'),
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const CreateBusinessPage()));
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.group_add),
//                         title: const Text('Join Business'),
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => JoinBusinessScreen()));
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.person),
//                         title: const Text('Profile'),
//                         onTap: () {
//                           // Action for Profile
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.logout),
//                         title: const Text('Log out'),
//                         onTap: () {
//                           // Action for Log out
//                         },
//                       ),
//                     ],
//                   );
//                 },
//                 loading: () => const CircularProgressIndicator(),
//                 error: (error, stack) => ListTile(
//                   title: Text('Error: $error'),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         color: Colors.black,
//         backgroundColor: Colors.transparent,
//         buttonBackgroundColor: Colors.black,
//         height: 60,
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 600),
//         index: _selectedIndex,
//         items: const [
//           Icon(Icons.home, size: 30, color: Colors.white),
//           Icon(Icons.supervised_user_circle, size: 30, color: Colors.white),
//           Icon(Icons.add, size: 40, color: Colors.white),
//           Icon(Icons.local_activity, size: 30, color: Colors.white),
//           Icon(Icons.feedback, size: 30, color: Colors.white),
//         ],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// // Function to select a business
// void selectBusiness(
//     Business business, String userType, String businessCode, WidgetRef ref) {
//   final Map<String, dynamic> selectedBusinessData = {
//     'business': business,
//     'userType': userType,
//     'businessCode': businessCode,
//   };
//   ref.read(currentBusinessProvider.notifier).state = selectedBusinessData;
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restart_app/restart_app.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/business_home_page/screens/business_profile.dart';
import 'package:targafy/business_home_page/screens/create_business.dart';
import 'package:targafy/business_home_page/screens/join_business.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/feedback/feedback.dart';
import 'package:targafy/src/activity/ui/activity_screen.dart';
import 'package:targafy/src/home/view/screens/AddScreen.dart';
import 'package:targafy/src/home/view/screens/UserProfile.dart';
import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
import 'package:targafy/src/users/ui/UsersScreen.dart';

final userAvatarProvider = FutureProvider<String>((ref) async {
  final controller = ref.read(userProfileLogoControllerProvider);
  return await controller.fetchUserAvatar();
});

class BottomNavigationAndAppBar extends ConsumerStatefulWidget {
  const BottomNavigationAndAppBar({super.key});

  @override
  _BottomNavigationAndAppBarState createState() =>
      _BottomNavigationAndAppBarState();
}

class _BottomNavigationAndAppBarState
    extends ConsumerState<BottomNavigationAndAppBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const UsersScreen(),
    const Addscreen(),
    const ActivityScreen(),
    const FeedbackScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(businessAndUserProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    // Check if a business is selected, if not, try to select the first one
    if (selectedBusinessData == null) {
      asyncValue.whenData((data) {
        final businesses = (data['businesses'] as List<Business>?) ?? [];
        final user = data['user'] as User?;

        if (businesses.isNotEmpty && user != null) {
          final firstBusiness = businesses.first;
          final businessUser = user.businesses.firstWhere(
            (b) => b.businessId == firstBusiness.id,
            orElse: () => BusinessUser(name: '', userType: '', businessId: ''),
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {
            selectBusiness(
              firstBusiness,
              businessUser.userType ?? 'No User Type',
              firstBusiness.businessCode ?? 'No Code',
              ref,
            );
          });
        }
      });
    }
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final selectedUserType = selectedBusinessData?['userType'] as String?;
    final selectedbusinessCode =
        selectedBusinessData?['businessCode'] as String?;
    final selectedRole = selectedBusinessData?['role'] as String?;
    print(selectedbusinessCode);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenheight(context) * 0.08),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 5,
          ),
          child: AppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Targafy',
                  style: TextStyle(
                    fontSize: getScreenWidth(context) *
                        0.066, // Adjust size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  selectedBusiness != null && selectedUserType != null
                      ? selectedBusiness.name
                      : 'Hi User',
                  style: TextStyle(
                    fontSize: getScreenWidth(context) *
                        0.038, // Adjust size as needed
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            centerTitle: false,
            actions: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   child: GestureDetector(
              //     child: Image.asset('assets/img/search.png'),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: GestureDetector(
              //     child: Image.asset('assets/img/filter.png'),
              //   ),
              // ),
              Consumer(
                builder: (context, ref, _) {
                  final userRoleAsyncValue = ref.watch(userRoleProvider);

                  return userRoleAsyncValue.when(
                    data: (role) {
                      return PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        position: PopupMenuPosition.under,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                              .copyWith(topRight: const Radius.circular(0)),
                        ),
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddParameterTargetScreen(),
                              ),
                            );
                          } else if (value == 2) {
                            // Handle action for "Add Charts"
                          } else if (value == 3) {
                            // Handle action for "Refresh"
                            Restart.restartApp();
                          } else if (value == 4) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BusinessProfile(),
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                          if (role != 'User' && role != 'MiniAdmin')
                            PopupMenuItem<int>(
                              value: 1,
                              child: CustomText(
                                text: 'Add Parameters/Target',
                                fontSize: getScreenWidth(context) * 0.04,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          // if (role != 'User' && role != 'MiniAdmin')
                          //   PopupMenuItem<int>(
                          //     value: 2,
                          //     child: CustomText(
                          //       text: 'Add Charts',
                          //       fontSize: getScreenWidth(context) * 0.04,
                          //       fontWeight: FontWeight.w600,
                          //       color: primaryColor,
                          //     ),
                          //   ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: CustomText(
                              text: 'Refresh',
                              fontSize: getScreenWidth(context) * 0.04,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 4,
                            child: CustomText(
                              text: 'Business Profile',
                              fontSize: getScreenWidth(context) * 0.04,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, stack) => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, _) {
              return asyncValue.when(
                data: (data) {
                  print('this is the :-$data');

                  // final businesses = data['businesses'] as List<Business>?;
                  final businesses =
                      (data['businesses'] as List<Business>?) ?? [];
                  print(businesses);
                  final user = data['user'] as User?;
                  print(user);

                  // Fetch user avatar
                  final userAvatar = ref.watch(userAvatarProvider);

                  return Column(
                    children: [
                      DrawerHeader(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // userAvatar.when(
                            //   data: (avatarUrl) => Container(
                            //     alignment: Alignment.centerLeft,
                            //     width: double.infinity,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         color: primaryColor,
                            //         shape: BoxShape.circle,
                            //       ),
                            //       padding: const EdgeInsets.all(1.5),
                            //       child: Center(
                            //         child: CircleAvatar(
                            //           radius: getScreenWidth(context) * 0.09,
                            //           // backgroundImage:
                            //           //     NetworkImage(avatarUrl),
                            //           backgroundImage:
                            //               CachedNetworkImageProvider(avatarUrl),
                            //           onBackgroundImageError:
                            //               (exception, stackTrace) {
                            //             // Fallback image if loading fails

                            //           },
                            //           child: null,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   loading: () => const CircularProgressIndicator(),
                            //   error: (error, stack) => Icon(
                            //     Icons.error,
                            //     size: getScreenWidth(context) * 0.09,
                            //   ),
                            // ),
                            userAvatar.when(
                              data: (avatarUrl) => Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(1.5),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: getScreenWidth(context) * 0.09,
                                      backgroundImage:
                                          CachedNetworkImageProvider(avatarUrl),
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        // Fallback image if loading fails
                                        const NetworkImage(
                                            'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/LdTCEUo.png');
                                      },
                                      child: null,
                                    ),
                                  ),
                                ),
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) {
                                // Check for specific error message and display fallback image
                                // if (error
                                //     .toString()
                                //     .contains("User avatar does not exist")) {
                                //   return Container(
                                //     alignment: Alignment.centerLeft,
                                //     width: double.infinity,
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         color: primaryColor,
                                //         shape: BoxShape.circle,
                                //       ),
                                //       padding: const EdgeInsets.all(1.5),
                                //       child: Center(
                                //         child: CircleAvatar(
                                //           radius:
                                //               getScreenWidth(context) * 0.09,
                                //           backgroundImage: NetworkImage(
                                //               'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/LdTCEUo.png'),
                                //           child: null,
                                //         ),
                                //       ),
                                //     ),
                                //   );
                                // } else {
                                // return Icon(
                                //   Icons.error,
                                //   size: getScreenWidth(context) * 0.09,
                                // );
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(1.5),
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: getScreenWidth(context) * 0.09,
                                        backgroundImage: const NetworkImage(
                                            'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/LdTCEUo.png'),
                                        child: null,
                                      ),
                                    ),
                                  ),
                                );
                                // }
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getScreenWidth(context) * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (user != null)
                                    Center(
                                      child: CustomText(
                                        text: user.name ?? 'No Name',
                                        fontSize:
                                            getScreenWidth(context) * 0.045,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  if (user != null)
                                    Center(
                                      child: CustomText(
                                        text: 'Admin',
                                        fontSize:
                                            getScreenWidth(context) * 0.04,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (businesses.isNotEmpty)
                        ExpansionTile(
                          leading: const Icon(Icons.business),
                          title: const Text('Businesses'),
                          children: businesses.map((business) {
                            final businessUser = user?.businesses.firstWhere(
                              (b) => b.businessId == business.id,
                              orElse: () => BusinessUser(
                                  name: '', userType: '', businessId: ''),
                            );

                            return ListTile(
                              leading: business.logo != null
                                  ? CachedNetworkImage(
                                      imageUrl: business.logo,
                                      width: 30,
                                      height: 30,
                                      errorWidget: (context, url, error) =>
                                          Image.network(
                                        'https://via.placeholder.com/30',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  : const Icon(Icons.business),
                              title: Text(business.name ?? 'No Name'),
                              onTap: () {
                                if (businessUser != null) {
                                  selectBusiness(
                                      business,
                                      businessUser.userType ?? 'No User Type',
                                      business.businessCode ?? 'No Code',
                                      ref);
                                  Navigator.pop(context); // Close the drawer
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Create Business'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateBusinessPage()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.group_add),
                        title: const Text('Join Business'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const JoinBusinessScreen()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Profile'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserProfile()));
                        },
                      ),
                      // ListTile(
                      //   leading: const Icon(Icons.logout),
                      //   title: const Text('Log out'),
                      //   onTap: () async {
                      //     // Clear SharedPreferences
                      //     final prefs = await SharedPreferences.getInstance();
                      //     await prefs.remove('authToken');

                      //     // Reset all providers
                      //     ResettableProviderScope.reset(context);

                      //     // Navigate to login screen and remove all previous routes
                      //     if (context.mounted) {
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(
                      //             builder: (context) => const LoginScreen()),
                      //         (Route<dynamic> route) => false,
                      //       );
                      //     }
                      //     // ref.invalidate(currentBusinessProvider);
                      //     // ref.invalidate(businessAndUserProvider);
                      //     // ref.invalidate(userProfileLogoControllerProvider);
                      //     // ref.read(loginProvider.notifier).logout(context);
                      //   },
                      // ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Column(
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: CustomText(
                          text: 'Error: $error',
                          fontSize: getScreenWidth(context) * 0.045,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Create Business'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateBusinessPage()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.group_add),
                      title: const Text('Join Business'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const JoinBusinessScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        // Action for Profile
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log out'),
                      onTap: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: primaryColor,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: primaryColor,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.supervised_user_circle, size: 30, color: Colors.white),
          Icon(Icons.add, size: 40, color: Colors.white),
          // Icon(Icons.local_activity, size: 30, color: Colors.white),
          ImageIcon(
            AssetImage("assets/img/activity-icon-without-bg.png"),
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.feedback, size: 30, color: Colors.white),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Function to select a business
void selectBusiness(
    Business business, String userType, String businessCode, WidgetRef ref) {
  final Map<String, dynamic> selectedBusinessData = {
    'business': business,
    'userType': userType,
    'businessCode': businessCode,
  };
  ref.read(currentBusinessProvider.notifier).state = selectedBusinessData;
}
