import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/home/view/screens/AddScreen.dart';
import 'package:targafy/src/home/view/screens/UserProfile.dart';
import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
import 'package:targafy/src/users/ui/UsersScreen.dart';
import 'package:targafy/utils/remote_routes.dart';
// final userAvatarProvider = FutureProvider<String>((ref) async {
//   final controller = ref.read(userProfileLogoControllerProvider);
//   return await controller.fetchUserAvatar();
// });

String domain = AppRemoteRoutes.baseUrl;

class BottomNavigationAndAppBar extends ConsumerStatefulWidget {
  final String? token;
  const BottomNavigationAndAppBar({
    required this.token,
  });

  @override
  _BottomNavigationAndAppBarState createState() =>
      _BottomNavigationAndAppBarState();
}

class _BottomNavigationAndAppBarState
    extends ConsumerState<BottomNavigationAndAppBar> {
  int _selectedIndex = 0;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   const HomeScreen(),
  //   const UsersScreen(),
  //   const Addscreen(),
  //   const ActivityScreen(),
  //   const FeedbackScreen(token:,)
  // ];
  late final List<Widget> _widgetOptions;
  bool _isRefreshing = false;

  @override
  void initState() {
    _requestNotificationPermissions();
    super.initState();
    _widgetOptions = <Widget>[
      const HomeScreen(),
      const UsersScreen(),
      const Addscreen(),
      const ActivityScreen(),
      FeedbackScreen(token: widget.token!), // Pass the token here
    ];

    _getToken();
    _getToken1();
    _refreshParameters();
  }

  void _refreshParameters() {
    print('Refresh Parameter is called');
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref
          .read(parametersProviderHome.notifier)
          .fetchParametersforHome(businessId);
    }
  }

  Future<void> _getToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');

      if (fcmToken != null && bearerToken != null) {
        await _sendTokenToServer(fcmToken, bearerToken);
      } else {
        print('Failed to retrieve FCM token or bearer token.');
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> _getToken1() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');

      if (bearerToken != null) {
        await _sendSessionHistoryToServer(bearerToken);
      } else {
        print('Failed to retrieve bearer token.');
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
    try {
      final url = Uri.parse('${domain}user/update/fcmToken?fcmToken=$fcmToken');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        print('Token sent successfully.');
      } else {
        print('Failed to send token: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  Future<void> _sendSessionHistoryToServer(String bearerToken) async {
    try {
      final url = Uri.parse('${domain}user/add-lastseenhistory');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        print('Session history updated successfully.');
      } else {
        print(
            'Failed to send Session history ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending Session history: $e');
    }
  }

  Future<void> _requestNotificationPermissions() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification allowed');
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Perform your refresh logic here
    await Future.delayed(Duration(seconds: 0)); // Simulating delay

    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     'This is the final authToken which will be used for doing all functions :- ${widget.token}');
    final asyncValue = ref.watch(businessAndUserProvider(widget.token!));
    var selectedBusinessData = ref.read(currentBusinessProvider);
    // final Map<String, dynamic>? selectedBusinessData1 = {
    //   'business': Business(
    //     id: '',
    //     businessCode: '',
    //     name: '',
    //     logo: '',
    //     industryType: '',
    //     city: '',
    //     country: '',
    //   ),
    //   'userType': '',
    //   'businessCode': '',
    // };
    // // Check if a business is selected, if not, try to select the first one
    // print('This is $selectedBusinessData');
    // print('This is 1 $selectedBusinessData1');

    if (selectedBusinessData == null) {
      asyncValue.whenData((data) {
        final businesses = (data?['businesses'] as List<Business>?) ?? [];
        final user = data?['user'] as User?;

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
                        onSelected: (value) async {
                          if (value == 1) {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddParameterTargetScreen(),
                              ),
                            );
                            if (result == true) {
                              _refreshParameters();
                            }
                          } else if (value == 2) {
                            // Handle action for "Add Charts"
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddCharts(),
                              ),
                            );
                          } else if (value == 3) {
                            // Handle action for "Refresh"
                            Restart.restartApp();
                          } else if (value == 4) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessProfile(
                                  token: widget.token,
                                ),
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
                          if (role != 'User' && role != 'MiniAdmin')
                            PopupMenuItem<int>(
                              value: 2,
                              child: CustomText(
                                text: 'Add Charts',
                                fontSize: getScreenWidth(context) * 0.04,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
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
              final userRoleAsyncValue = ref.watch(userRoleProvider);
              return asyncValue.when(
                data: (data) {
                  print('this is the :-$data');

                  // final businesses = data['businesses'] as List<Business>?;
                  final businesses =
                      (data?['businesses'] as List<Business>?) ?? [];
                  print(businesses);
                  final user = data?['user'] as User?;
                  print(user);

                  return Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: FutureBuilder(
                      //       future: getVersion(),
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasError) {
                      //           return Padding(
                      //             padding: const EdgeInsets.all(16.0),
                      //             child: Text("1.0.0"),
                      //           );
                      //         }
                      //         return Text("${snapshot.data}");
                      //       }),
                      // ),
                      DrawerHeader(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String>(
                              future: ref
                                  .read(userProfileLogoControllerProvider)
                                  .fetchUserAvatar(widget.token!),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return _buildFallbackAvatar();
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return _buildFallbackAvatar();
                                } else {
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
                                          radius:
                                              getScreenWidth(context) * 0.09,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  snapshot.data!),
                                          onBackgroundImageError:
                                              (exception, stackTrace) {
                                            // Fallback image if loading fails
                                            _buildFallbackAvatar();
                                          },
                                          child: null,
                                        ),
                                      ),
                                    ),
                                  );
                                }
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
                                  // if (user != null)
                                  //   Center(
                                  //     child: CustomText(
                                  //       text: 'Admin',
                                  //       fontSize:
                                  //           getScreenWidth(context) * 0.04,
                                  //       color: primaryColor,
                                  //       fontWeight: FontWeight.w400,
                                  //     ),
                                  //   ),
                                  userRoleAsyncValue.when(
                                    data: (role) => Center(
                                      child: CustomText(
                                        text: role ?? 'No Role',
                                        fontSize:
                                            getScreenWidth(context) * 0.04,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    loading: () => const SizedBox.shrink(),
                                    error: (error, stack) =>
                                        const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (businesses.isNotEmpty)
                        ExpansionTile(
                          initiallyExpanded: true,
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
                                  builder: (context) => CreateBusinessPage(
                                        token: widget.token,
                                      )));
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
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out'),
                        onTap: () async {
                          ref.read(loginProvider.notifier).logout(context);

                          final prefs = await SharedPreferences.getInstance();
                          ref.read(currentBusinessProvider.notifier).state =
                              null;
                          await prefs.remove('authToken');

                          // Navigate to login screen and remove all previous routes
                          // if (context.mounted) {
                          //   Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginScreen()),
                          //     (Route<dynamic> route) => false,
                          //   );
                          // }
                          // ref.read(loginProvider.notifier).logout(context);
                        },
                      ),
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
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isRefreshing
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : _widgetOptions.elementAt(_selectedIndex),
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

  Widget _buildFallbackAvatar() {
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
              'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/LdTCEUo.png',
            ),
            child: null,
          ),
        ),
      ),
    );
  }
}
